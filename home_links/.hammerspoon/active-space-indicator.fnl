(require-macros (doto :cljlib require))

(ns active-space-indicator)

(defn build-title []
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

(local menu (hs.menubar.new true))

(defn set-title [& rest]
  (alert (build-title))
  (: menu :setTitle (build-title)))

(set-title)

(local space-watcher (hs.spaces.watcher.new set-title))
(: space-watcher :start)

(local screen-watcher (hs.screen.watcher.new set-title))
(: screen-watcher :start)
