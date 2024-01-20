(require-macros (doto :cljlib require))

(ns core
    (:require
     [:fennel]
     [:cljlib :refer []]
     [:lib.functional :refer [split contains? some reduce merge map]]
     [:lib.globals]
     [:lib.atom]))

(require-macros :lib.advice.macros)

(hs.console.clearConsole)

;; cliInstall doesn't work due to priviledges. For now I've linked manually
(hs.ipc.cliInstall) ; ensure CLI installed

;; Add compatability with spoons as the spoon global may not exist at
;; this point until a spoon is loaded. It will exist if a spoon is
;; loaded from init.lua

(global spoon (or _G.spoon {}))

(local homedir (os.getenv "HOME"))

(local log (hs.logger.new "\tcore.fnl\t" "debug"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set hs.hints.style :vimperator)
(set hs.hints.showTitleThresh 4)
(set hs.hints.titleMaxSize 10)
(set hs.hints.fontSize 30)
(set hs.window.animationDuration 0.2)

"
alert :: str, { style }, seconds -> nil
Shortcut for showing an alert on the primary screen for a specified duration
Takes a message string, a style table, and the number of seconds to show alert
Returns nil. This function causes side-effects.
"
(global alert
        (afn
         alert
         [str style seconds]
         "
         Global alert function used for spacehammer modals and reload
         alerts after config reloads
         "
         (hs.alert.show str
                        style
                        (hs.screen.primaryScreen)
                        seconds)))

(global fw hs.window.focusedWindow)

(global pprint (fn [x] (print (fennel.view x))))

(global get-config
        (afn get-config
          []
          "
          Returns the global config object, or error if called early
          "
          (error "get-config can only be called after all modules have initialized")))

(fn file-exists?
  [filepath]
  "
  Determine if a file exists and is readable.
  Takes a file path string
  Returns true if file is readable
  "
  (let [file (io.open filepath "r")]
    (when file
      (io.close file))
    (~= file nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto reload config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(fn source-filename?
  [file]
  "
  Determine if a file is not an emacs backup file which starts with \".#\"
  Takes a file path string
  Returns true if it's a source file and not an emacs backup file.
  "
  (not (string.match file ".#")))

(fn source-extension?
  [file]
  "
  Determine if a file is a .fnl or .lua file
  Takes a file string
  Returns true if file extension ends in .fnl or .lua
  "
  (let [ext (split "%p" file)]
    (and
     (or (contains? "fnl" ext)
         (contains? "lua" ext))
     (not (string.match file "-test%..*$")))))


(fn source-updated?
  [file]
  "
  Determine if a file is a valid source file that we can load
  Takes a file string path
  Returns true if file is not an emacs backup and is a .fnl or .lua type.
  "
  (and (source-filename? file)
       (source-extension? file)))

(fn config-reloader
  [files]
  "
  If the list of files contains some hammerspoon or spacehammer source files:
  reload hammerspoon
  Takes a list of files from our config file watcher.
  Performs side effect of reloading hammerspoon.
  Returns nil
  "
  (when (some source-updated? files)
    (hs.console.clearConsole)
    (hs.reload)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set utility keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; toggle hs.console with Ctrl+Cmd+~
(hs.hotkey.bind
 [:ctrl :cmd] "`" nil
 (fn []
   (if-let
    [console (hs.console.hswindow)]
    (when (= console (hs.console.hswindow))
      (hs.closeConsole))
    (hs.openConsole))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize core modules
;; - Requires each module
;; - Calls module.init and provides config.fnl table
;; - Stores global reference to all initialized resources to prevent garbage
;;   collection.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(local config (require :config))

;; Initialize our modules that depend on config
(local modules [:lib.hyper
                :vim
                :windows
                :apps
                :lib.bind
                :lib.modal
                :lib.apps])

(defadvice get-config-impl
           []
           :override get-config
           "Returns global config obj"
           config)

;; Create a global reference so services like hs.application.watcher
;; do not get garbage collected.
(global resources
        (->> modules
             (map (fn [path]
                    (let [module (require path)]
                      {path (module.init config)})))
             (reduce #(merge $1 $2) {})))

