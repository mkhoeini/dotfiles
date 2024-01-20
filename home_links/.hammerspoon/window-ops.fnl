(require-macros (doto :cljlib require))

(ns window-ops)

(def phi (/ 4 3)) ; (1 + math.sqrt(2)) / 2
(def menubar-height 25)
(def window-gap (* menubar-height 1.44))

(defn resize-window-to-a4 []
  (let [win (hs.window.focusedWindow)
        f (win:frame)
        screen (: (win:screen) :frame)
        max_h (* screen.h 0.95)
        h (math.min (* f.w phi) max_h)
        w (/ h phi)]
    (set f.w w)
    (set f.h h)

    (if (> (+ f.y f.h) screen.h)
        (set f.y (- screen.h f.h 10)))

    (win:setFrame f)))

(defn move-and-resize-window-left []
  (let [win (hs.window.focusedWindow)
        screen (win:screen)
        f (screen:fromUnitRect "0.1 0 0.55 1")]
    (set f.x (+ f.x window-gap))
    (set f.y (+ f.y window-gap menubar-height))
    (set f.w (- f.w (* 2 window-gap)))
    (set f.h (- (- f.h (* 2 window-gap)) menubar-height))
    (win:setFrame f)))

(defn move-and-resize-window-right []
  (let [win (hs.window.focusedWindow)
        screen (win:screen)
        f (screen:fromUnitRect "0.55 0 1 1")]
    (set f.x (+ f.x window-gap))
    (set f.y (+ f.y window-gap menubar-height))
    (set f.w (- f.w (* 2 window-gap)))
    (set f.h (- (- f.h (* 2 window-gap)) menubar-height))
    (win:setFrame f)))

(defn move-to-center []
  (: (hs.window.focusedWindow) :centerOnScreen))

(defn move-to-center-and-resize []
  (let [win (hs.window.focusedWindow)
        screen (win:screen)
        win-f (win:frame)
        f (screen:frame)]
    (set f.x win-f.x)
    (set f.y (+ win-f.y menubar-height))
    (set f.h (* f.h 0.95))
    (set f.w (/ f.h phi))
    (win:setFrame f)
    (win:centerOnScreen)))

(defn double-size []
  (let [win (hs.window.focusedWindow)
        screen (win:screen)
        win-f (win:frame)
        f (screen:fromUnitRect "0 0 1 1")]
    (set f.x win-f.x)
    (set f.y win-f.y)
    (set f.h (* f.h 0.95))
    (set f.w (+ (* (/ f.h phi) 2) window-gap))
    (win:setFrame f)
    (win:centerOnScreen)))

;; (spoon.SpoonInstall:andUse :RecursiveBinder {})

;; (local k spoon.RecursiveBinder.singleKey)

;; local keyMap = spoon.RecursiveBinder.recursiveBind{
;;   [k('a', 'applications')] = {
;;     [k('e', 'emojis')] = toggleEmojis,}
;;                                                    ,
;;                                                    [k('k', 'keyboard shortcuts')] = {
;;                                                                                      -- TODO find a way to bind ESC once for closing
;;                                                                                      [k('h', 'hammerspoon')] = toggleShowKeybindings,
;;                                                                                      [k('a', 'application')] = function() spoon.KSheet:toggle() end,}
;;                                                    ,
;;                                                    [k('w', 'window')] = {
;;                                                                          [k('c', 'move to center')] = moveToCenter,
;;                                                                          [k('C', 'move and resize to center')] = moveToCenterAndResize,
;;                                                                          [k('d', 'double size')] = doubleSize,
;;                                                                          [k('h', 'resize to left')] = moveAndResizeWindowLeft,
;;                                                                          [k('l', 'resize to right')] = moveAndResizeWindowRight,
;;                                                                          [k('p', 'proportionate')] = resizeWindowToA4,}
;;                                                    ,}



;; TODO write a desktop drawing version
;; spoon.SpoonInstall:andUse("SpeedMenu", {})
;; TODO use URLDispatcher instead of browserasorous)
;; (hs.hotkey.bind [:option] :space key-map)
;; (hs.alert.show "Config Loaded")
