(require-macros (doto :cljlib require))

(ns core
    (:require [:fennel]
              [:cljlib :refer [merge contains? some into map]]
              [:lib.globals]
              [:lib.atom]))

;; cliInstall doesn't work due to priviledges. For now I've linked manually
(hs.ipc.cliInstall) ; ensure CLI installed

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set hs.hints.style :vimperator)
(set hs.hints.showTitleThresh 4)
(set hs.hints.titleMaxSize 10)
(set hs.hints.fontSize 30)
(set hs.window.animationDuration 0.2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize core modules
;; - Requires each module
;; - Calls module.init and provides config.fnl table
;; - Stores global reference to all initialized resources to prevent garbage
;;   collection.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(local config (require :config))

;; Initialize our modules that depend on config
(local modules [:windows
                :apps
                :lib.bind
                :lib.modal
                :lib.apps])

;; Create a global reference so services like hs.application.watcher
;; do not get garbage collected.
(global resources
        (->> modules
             (map (fn [path]
                    (let [module (require path)]
                      [path (module.init config)])))
             (into {})))
