(require-macros (doto :cljlib require))

(ns spoons
    (:require [cljlib :refer [contains?]]
              [lib.atom :refer [atom deref update!]]))

(def loaded-spoons
  (icollect [i spoon (ipairs (hs.spoons.list))] (. spoon :name)))

(defn trim [s]
  (-> s
      (: :gsub "^%s+" "")
      (: :gsub "%s+$" "")))

(defn exec [& rst]
  (hs.execute (table.concat rst " ") true))

(when (not (contains? loaded-spoons "SpoonInstall"))
    (let [tmpdir1 (exec "mktemp -d")
          tmpdir (trim tmpdir1)
          outfile (.. tmpdir "/SpoonInstall.spoon.zip")
          spoonfile (.. tmpdir "/SpoonInstall.spoon")]
      (exec "curl -fsSL https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip -o" outfile)
      (exec "cd" tmpdir ";" "unzip SpoonInstall.spoon.zip -d ~/.hammerspoon/Spoons/")
      (exec "ls -la " tmpdir)
      (exec "rm -rf " tmpdir)))


(hs.loadSpoon "SpoonInstall")

(defn use-spoon [spoon-name opts]
  (: spoon.SpoonInstall :andUse spoon-name opts))

(use-spoon "ReloadConfiguration" {:start true})
(use-spoon "Calendar" {})

;; spoon.SpoonInstall:andUse("HCalendar", { start = true}))
;; Pomodoro Menubar: spoon.SpoonInstall:andUse("Cherry", {})
(use-spoon "CircleClock" {})
(use-spoon "ClipboardTool" {:start true})
(use-spoon "Emojis" {})

;; Make setFrame behave more correctly. e.g. terminal windows)
;; hs.window.setFrameCorrectness = true

(defn toggle-emojis []
  (if (spoon.Emojis.chooser:isVisible)
    (spoon.Emojis.chooser:hide)
    (spoon.Emojis.chooser:show)))


(use-spoon "HSKeybindings" {})

(def hammerspoonKeybindingsIsShown (atom false))

(defn toggleShowKeybindings []
  (update! hammerspoonKeybindingsIsShown #(not $1))
  (if (deref hammerspoonKeybindingsIsShown)
    (spoon.HSKeybindings:show)
    (spoon.HSKeybindings:hide)))

(use-spoon "KSheet" {})

(set spoon.SpoonInstall.repos.PaperWM
     {:url "https://github.com/mogenson/PaperWM.spoon"
      :desc "PaperWM.spoon repository"
      :branch "release"})

(local paper-wm
       (use-spoon
        "PaperWM"
        {:repo "PaperWM"
         :config {:screen_margin 160
                  :window_gap 20
                  :window_ratios [0.3125 0.421875 0.625]}
         :fn #(: $1 :bindHotkeys (. $1 :default_hotkeys))
         :start true}))
