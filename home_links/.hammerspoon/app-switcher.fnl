(require-macros (doto :cljlib require))

(ns app-switcher
    (:require [lib.utils :refer [global-filter]]))


(defn- calc-thumbnail-size []
  "Calculates the height of thumbnail in pixels based on the screen size
  @TODO Make this advisable when #102 lands"
  (let [screen (hs.screen.mainScreen)
        {: h} (: screen :currentMode)]
    (/ h 2)))

(var switcher
     (hs.window.switcher.new
      (global-filter)
      {:textSize 12
       :showTitles false
       :showThumbnails false
       :showSelectedTitle true
       :selectedThumbnailSize (calc-thumbnail-size)
       :backgroundColor [0 0 0 0]}))

(defn init [_config])


(defn prev-app []
  "Open the fancy hammerspoon window switcher and move the cursor to the previous
  app.
  Runs side-effects
  Returns nil"
  (switcher:previous))

(defn next-app []
  "Open the fancy hammerspoon window switcher and move the cursor to next app.
  Runs side-effects
  Returns nil"
  (switcher:next))

app-switcher
