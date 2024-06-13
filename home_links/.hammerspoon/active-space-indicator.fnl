(require-macros (doto :cljlib require))

(ns active-space-indicator)

(defn get-spaces-str []
  (let [title {}
        spaces-layout (hs.spaces.allSpaces)
        active-spaces (hs.spaces.activeSpaces)]
    (var num-spaces 0)
    (each [_ screen (ipairs (hs.screen.allScreens))]
      (table.insert title (.. (screen:name) ": "))
      (local screen-uuid (screen:getUUID))
      (local active-space (. active-spaces screen-uuid))
      (each [i space (ipairs (. spaces-layout screen-uuid))]
        (local space-title (tostring (+ i num-spaces)))
        (if (and active-space (= active-space space))
            (table.insert title (.. "[" space-title "]"))
            (table.insert title (.. " " space-title " "))))
      (set num-spaces (+ num-spaces (length (. spaces-layout screen-uuid))))
      (table.insert title "  "))
    (table.remove title)
    (table.concat title)))

(defn handle-space-switch [& rest]
  (hs.alert (get-spaces-str)))

(local space-watcher (hs.spaces.watcher.new handle-space-switch))
(: space-watcher :start)

(local screen-watcher (hs.screen.watcher.new handle-space-switch))
(: screen-watcher :start)

;; TODO proper shortcut and configs
(local expose (hs.expose.new))
(hs.hotkey.bind :ctrl-cmd :e :Expose (fn [] (expose:toggleShow)))
