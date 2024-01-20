(require-macros (doto :cljlib require))

(ns globals
    (:require
     [:cljlib :refer [map apply]]
     [:fennel]))

(global pprint
        (fn pprint [...]
          "Similar to print but formats table arguments for human readability"
          (apply print
                 (map #(match (type $1)
                         "table" (fennel.view $1)
                         _       $1)
                      [...]))))

;; alert :: str, { style }, seconds -> nil
;; Shortcut for showing an alert on the primary screen for a specified duration
;; Takes a message string, a style table, and the number of seconds to show alert
;; Returns nil. This function causes side-effects.
(global alert
        (fn alert [str style seconds]
         "Global alert function used for spacehammer modals and reload alerts after config reloads"
         (hs.alert.show str style (hs.screen.primaryScreen) seconds)))
