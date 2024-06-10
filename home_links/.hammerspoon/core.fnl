;; First thing to do: Clear console.
(hs.console.clearConsole)

(require-macros (doto :cljlib require))

(ns core
    (:require [:cljlib :refer [merge contains? some into mapv]]
              [:lib.globals]
              [:defaults]
              [:config]
              [:windows]
              [:apps]
              [:lib.bind :as lib-bind]
              [:lib.modal :as lib-modal]
              [:lib.apps :as lib-apps]))

;; TODO cliInstall doesn't work due to priviledges. For now I've linked manually
(hs.ipc.cliInstall) ; ensure CLI installed


;; Create a global reference so services like hs.application.watcher
;; do not get garbage collected.
(global resources
        (->> [windows apps lib-bind lib-modal lib-apps]
             (mapv #((. $ :init) config))))

;; Last thing to do: alert that the config is loaded
(_G.alert "Config is loaded successfully!")
