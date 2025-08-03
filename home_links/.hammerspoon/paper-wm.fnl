(require-macros (doto :cljlib require))

(ns paper-wm)

(local Screen hs.screen)
(local Spaces hs.spaces)
(local Timer hs.timer)
(local Watcher hs.uielement.watcher)
(local Window hs.window)
(local Window-filter hs.window.filter)
(local left-click hs.eventtap.leftClick)
(local left-mouse-down hs.eventtap.event.types.leftMouseDown)
(local left-mouse-dragged hs.eventtap.event.types.leftMouseDragged)
(local left-mouse-up hs.eventtap.event.types.leftMouseUp)
(local ___partial___ hs.fnutils.partial)

(def __index Paper-wM)
(def name :PaperWM)
(def version :0.5)
(def author "Michael Mogenson")
(def homepage "https://github.com/mogenson/PaperWM.spoon")
(def license "MIT - https://opensource.org/licenses/MIT")

(def default_hotkeys
     {:barf_out [[:alt :cmd] :o]
      :center_window [[:alt :cmd] :c]
      :cycle_height [[:alt :cmd :shift] :r]
      :cycle_width [[:alt :cmd] :r]
      :focus_down [[:alt :cmd] :down]
      :focus_left [[:alt :cmd] :left]
      :focus_right [[:alt :cmd] :right]
      :focus_up [[:alt :cmd] :up]
      :full_width [[:alt :cmd] :f]
      :move_window_1 [[:alt :cmd :shift] :1]
      :move_window_2 [[:alt :cmd :shift] :2]
      :move_window_3 [[:alt :cmd :shift] :3]
      :move_window_4 [[:alt :cmd :shift] :4]
      :move_window_5 [[:alt :cmd :shift] :5]
      :move_window_6 [[:alt :cmd :shift] :6]
      :move_window_7 [[:alt :cmd :shift] :7]
      :move_window_8 [[:alt :cmd :shift] :8]
      :move_window_9 [[:alt :cmd :shift] :9]
      :refresh_windows [[:alt :cmd :shift] :r]
      :reverse_cycle_height [[:ctrl :alt :cmd :shift] :r]
      :reverse_cycle_width [[:ctrl :alt :cmd] :r]
      :slurp_in [[:alt :cmd] :i]
      :stop_events [[:alt :cmd :shift] :q]
      :swap_down [[:alt :cmd :shift] :down]
      :swap_left [[:alt :cmd :shift] :left]
      :swap_right [[:alt :cmd :shift] :right]
      :swap_up [[:alt :cmd :shift] :up]
      :switch_space_1 [[:alt :cmd] :1]
      :switch_space_2 [[:alt :cmd] :2]
      :switch_space_3 [[:alt :cmd] :3]
      :switch_space_4 [[:alt :cmd] :4]
      :switch_space_5 [[:alt :cmd] :5]
      :switch_space_6 [[:alt :cmd] :6]
      :switch_space_7 [[:alt :cmd] :7]
      :switch_space_8 [[:alt :cmd] :8]
      :switch_space_9 [[:alt :cmd] :9]
      :switch_space_l [[:alt :cmd] ","]
      :switch_space_r [[:alt :cmd] "."]})

(def window_filter
  (-> (Window-filter.new)
      (: :setOverrideFilter
         {:allowRoles :AXStandardWindow
          :fullscreen false
          :hasTitlebar true
          :visible true})))

(def window_gap 8)
(def window_ratios [0.23607 0.38195 0.61804])
(def screen_margin 1)

(def logger (hs.logger.new name))

(local Direction {:ASCENDING 5
                  :DESCENDING 6
                  :DOWN 2
                  :HEIGHT 4
                  :LEFT (- 1)
                  :RIGHT 1
                  :UP (- 2)
                  :WIDTH 3})

(var window-list {})
(var index-table {})
(var ui-watchers {})

(local screen-watcher (Screen.watcher.new (fn [] (Paper-wM:refreshWindows))))

(fn get-space [index]
  (let [layout (Spaces.allSpaces)]
    (each [_ screen (ipairs (Screen.allScreens))]
      (local screen-uuid (screen:getUUID))
      (local num-spaces (length (. layout screen-uuid)))
      (when (>= num-spaces index)
        (let [___antifnl_rtn_1___ (. layout screen-uuid index)]
          (lua "return ___antifnl_rtn_1___")))
      (set-forcibly! index (- index num-spaces)))))

(fn get-first-visible-window [columns screen]
  (let [x (. (screen:frame) :x)]
    (each [_ windows (ipairs (or columns {}))]
      (local window (. windows 1))
      (when (>= (. (window:frame) :x) x)
        (lua "return window")))))

(fn get-column [space col]
  (. (or (. window-list space) {}) col))

(fn get-window [space col row]
  (. (or (get-column space col) {}) row))

(fn get-canvas [screen]
  (let [screen-frame (screen:frame)]
    (hs.geometry.rect (+ screen-frame.x Paper-wM.window_gap)
                      (+ screen-frame.y Paper-wM.window_gap)
                      (- screen-frame.w (* 2 Paper-wM.window_gap))
                      (- screen-frame.h (* 2 Paper-wM.window_gap)))))

(fn update-index-table [space column]
  (let [columns (or (. window-list space) {})]
    (for [col column (length columns)]
      (each [row window (ipairs (get-column space col))]
        (tset index-table (window:id) {: col : row : space})))))

(var focused-window nil)

(var pending-window nil)

(fn window-event-handler [window event self]
  (self.logger.df "%s for [%s] id: %d" event window
                  (or (and window (window:id)) (- 1)))
  (var space nil)
  (if (= event :windowFocused)
      (do
        (when (and pending-window (= window pending-window))
          (Timer.doAfter Window.animationDuration
                         (fn []
                           (self.logger.vf "pending window timer for %s" window)
                           (window-event-handler window event self)))
          (lua "return "))
        (set focused-window window)
        (set space (. (Spaces.windowSpaces window) 1)))
      (or (= event :windowVisible) (= event :windowUnfullscreened))
      (do
        (set space (self:addWindow window))
        (if (and pending-window (= window pending-window))
            (set pending-window nil) (not space)
            (do
              (set pending-window window)
              (Timer.doAfter Window.animationDuration
                             (fn [] (window-event-handler window event self)))
              (lua "return ")))) (= event :windowNotVisible)
      (set space (self:removeWindow window)) (= event :windowFullscreened)
      (set space (self:removeWindow window true))
      (or (= event :AXWindowMoved) (= event :AXWindowResized))
      (set space (. (Spaces.windowSpaces window) 1)))
  (when space (self:tileSpace space)))

(fn focus-space [space window]
  (let [screen (Screen (Spaces.spaceDisplay space))]
    (when (not screen) (lua "return "))
    (set-forcibly! window
                   (or window
                       (get-first-visible-window (. window-list space) screen)))
    (local do-space-focus (coroutine.wrap (fn []
                                            (if window
                                                (do
                                                  (fn check-focus [win n]
                                                    (var focused true)
                                                    (for [i 1 n]
                                                      (set focused
                                                           (and focused
                                                                (= (Window.focusedWindow)
                                                                   win)))
                                                      (when (not focused)
                                                        (lua "return false"))
                                                      (coroutine.yield false))
                                                    focused)
                                                  (while true
                                                    (window:focus)
                                                    (coroutine.yield false)
                                                    (when (and (= (Spaces.focusedSpace)
                                                                  space)
                                                               (check-focus window
                                                                            3))
                                                      (lua :break))))
                                                (let [point (screen:frame)]
                                                  (set point.x
                                                       (+ point.x (/ point.w 2)))
                                                  (set point.y (- point.y 4))
                                                  (while true
                                                    (left-click point)
                                                    (coroutine.yield false)
                                                    (when (= (Spaces.focusedSpace)
                                                             space)
                                                      (lua :break)))))
                                            (hs.mouse.absolutePosition (hs.geometry.rectMidPoint (screen:frame)))
                                            true)))
    (local start-time (Timer.secondsSinceEpoch))
    (Timer.doUntil do-space-focus
                   (fn [timer]
                     (when (> (- (Timer.secondsSinceEpoch) start-time) 4)
                       (Paper-wM.logger.ef "focusSpace() timeout! space %d focused space %d"
                                           space (Spaces.focusedSpace))
                       (timer:stop)))
                   Window.animationDuration)))

(defn start []
  (when (not (Spaces.screensHaveSeparateSpaces))
    (self.logger.e "please check 'Displays have separate Spaces' in System Preferences -> Mission Control"))
  (set window-list {})
  (set index-table {})
  (set ui-watchers {})
  (refresh-windows)
  (window_filter:subscribe [Window-filter.windowFocused
                            Window-filter.windowVisible
                            Window-filter.windowNotVisible
                            Window-filter.windowFullscreened
                            Window-filter.windowUnfullscreened]
                           (fn [window _ event]
                             (window-event-handler window event self)))
  (screen-watcher:start))

(defn stop [self]
  (self.window_filter:unsubscribeAll)
  (each [_ watcher (pairs ui-watchers)] (watcher:stop))
  (screen-watcher:stop)
  self)

(defn tile-column [self windows bounds h w id h4id]
  (var (last-window frame) nil)
  (each [_ window (ipairs windows)]
    (set frame (window:frame))
    (set-forcibly! w (or w frame.w))
    (if bounds.x (set frame.x bounds.x)
        bounds.x2 (set frame.x (- bounds.x2 w)))
    (when h
      (if (and (and id h4id) (= (window:id) id)) (set frame.h h4id)
          (set frame.h h)))
    (set frame.y bounds.y)
    (set frame.w w)
    (set frame.y2 (math.min frame.y2 bounds.y2))
    (self:moveWindow window frame)
    (set bounds.y (math.min (+ frame.y2 self.window_gap) bounds.y2))
    (set last-window window))
  (when (not= frame.y2 bounds.y2) (set frame.y2 bounds.y2)
    (self:moveWindow last-window frame))
  w)

(defn tile-space [self space]
  (when (or (not space) (not= (Spaces.spaceType space) :user))
    (self.logger.e "current space invalid")
    (lua "return "))
  (local screen (Screen (Spaces.spaceDisplay space)))
  (when (not screen) (self.logger.e "no screen for space") (lua "return "))
  (local focused-window (Window.focusedWindow))
  (var anchor-window nil)
  (if (and focused-window (= (. (Spaces.windowSpaces focused-window) 1) space))
      (set anchor-window focused-window)
      (set anchor-window
           (get-first-visible-window (. window-list space) screen)))
  (when (not anchor-window) (self.logger.e "no anchor window in space")
    (lua "return "))
  (local anchor-index (. index-table (anchor-window:id)))
  (when (not anchor-index) (self.logger.e "anchor index not found")
    (lua "return "))
  (local screen-frame (screen:frame))
  (local left-margin (+ screen-frame.x self.screen_margin))
  (local right-margin (- screen-frame.x2 self.screen_margin))
  (local canvas (get-canvas screen))
  (local anchor-frame (anchor-window:frame))
  (set anchor-frame.x (math.max anchor-frame.x canvas.x))
  (set anchor-frame.w (math.min anchor-frame.w canvas.w))
  (set anchor-frame.h (math.min anchor-frame.h canvas.h))
  (when (> anchor-frame.x2 canvas.x2)
    (set anchor-frame.x (- canvas.x2 anchor-frame.w)))
  (local column (get-column space anchor-index.col))
  (when (not column) (self.logger.e "no anchor window column") (lua "return "))
  (if (= (length column) 1)
      (do
        (set (anchor-frame.y anchor-frame.h) (values canvas.y canvas.h))
        (self:moveWindow anchor-window anchor-frame))
      (let [n (- (length column) 1)
            h (/ (math.max 0
                           (- (- canvas.h anchor-frame.h) (* n self.window_gap)))
                 n)
            bounds {:x anchor-frame.x :x2 nil :y canvas.y :y2 canvas.y2}]
        (self:tileColumn column bounds h anchor-frame.w (anchor-window:id)
                         anchor-frame.h)))
  (var x (math.min (+ anchor-frame.x2 self.window_gap) right-margin))
  (for [col (+ anchor-index.col 1) (length (or (. window-list space) {}))]
    (local bounds {: x :x2 nil :y canvas.y :y2 canvas.y2})
    (local column-width (self:tileColumn (get-column space col) bounds))
    (set x (math.min (+ x column-width self.window_gap) right-margin)))
  (var x2 (math.max (- anchor-frame.x self.window_gap) left-margin))
  (for [col (- anchor-index.col 1) 1 (- 1)]
    (local bounds {:x nil : x2 :y canvas.y :y2 canvas.y2})
    (local column-width (self:tileColumn (get-column space col) bounds))
    (set x2 (math.max (- (- x2 column-width) self.window_gap) left-margin))))

(defn refresh-windows []
  (let [all-windows (window_filter:getWindows)
        retile-spaces {}]
    (each [_ window (ipairs all-windows)]
      (local index (. index-table (window:id)))
      (if (not index)
          (let [space (add-window window)]
            (when space (tset retile-spaces space true)))
          (not= index.space (. (Spaces.windowSpaces window) 1))
          (do
            (self:removeWindow window)
            (local space (self:addWindow window))
            (when space (tset retile-spaces space true)))))
    (each [space _ (pairs retile-spaces)] (self:tileSpace space))))

(defn add-window [self add-window]
  (when (> (add-window:tabCount) 0)
    (hs.notify.show :PaperWM "Windows with tabs are not supported!"
                    "See https://github.com/mogenson/PaperWM.spoon/issues/39")
    (lua "return "))
  (when (. index-table (add-window:id)) (lua "return "))
  (local space (. (Spaces.windowSpaces add-window) 1))
  (when (not space) (self.logger.e "add window does not have a space")
    (lua "return "))
  (when (not (. window-list space)) (tset window-list space {}))
  (var add-column 1)
  (if (and (and focused-window (= (. (or (. index-table (focused-window:id)) {})
                                     :space)
                                  space))
           (not= (focused-window:id) (add-window:id)))
      (set add-column (+ (. index-table (focused-window:id) :col) 1))
      (let [x (. (add-window:frame) :center :x)]
        (each [col windows (ipairs (. window-list space))]
          (when (< x (. (: (. windows 1) :frame) :center :x))
            (set add-column col)
            (lua :break)))))
  (table.insert (. window-list space) add-column [add-window])
  (update-index-table space add-column)
  (local watcher (add-window:newWatcher (fn [window event _ self]
                                          (window-event-handler window event
                                                                self))
                                        self))
  (watcher:start [Watcher.windowMoved Watcher.windowResized])
  (tset ui-watchers (add-window:id) watcher)
  space)

(defn remove-window [self remove-window skip-new-window-focus]
  (let [remove-index (. index-table (remove-window:id))]
    (when (not remove-index) (self.logger.e "remove index not found")
      (lua "return "))
    (when (not skip-new-window-focus)
      (local focused-window (Window.focusedWindow))
      (when (and focused-window (= (remove-window:id) (focused-window:id)))
        (each [_ direction (ipairs [Direction.DOWN
                                    Direction.UP
                                    Direction.LEFT
                                    Direction.RIGHT])]
          (when (self:focusWindow direction remove-index) (lua :break)))))
    (table.remove (. window-list remove-index.space remove-index.col)
                  remove-index.row)
    (when (= (length (. window-list remove-index.space remove-index.col)) 0)
      (table.remove (. window-list remove-index.space) remove-index.col))
    (: (. ui-watchers (remove-window:id)) :stop)
    (tset ui-watchers (remove-window:id) nil)
    (tset index-table (remove-window:id) nil)
    (update-index-table remove-index.space remove-index.col)
    (when (= (length (. window-list remove-index.space)) 0)
      (tset window-list remove-index.space nil))
    remove-index.space))

(defn focus-window [self direction focused-index]
  (when (not focused-index)
    (local focused-window (Window.focusedWindow))
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (set-forcibly! focused-index (. index-table (focused-window:id))))
  (when (not focused-index) (self.logger.e "focused index not found")
    (lua "return "))
  (var new-focused-window nil)
  (if (or (= direction Direction.LEFT) (= direction Direction.RIGHT))
      (for [row focused-index.row 1 (- 1)]
        (set new-focused-window
             (get-window focused-index.space (+ focused-index.col direction)
                         row))
        (when new-focused-window (lua :break)))
      (or (= direction Direction.UP) (= direction Direction.DOWN))
      (set new-focused-window
           (get-window focused-index.space focused-index.col
                       (+ focused-index.row (/ direction 2)))))
  (when (not new-focused-window) (self.logger.d "new focused window not found")
    (lua "return "))
  (new-focused-window:focus)
  new-focused-window)

(defn swap-windows [self direction]
  (let [focused-window (Window.focusedWindow)]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (local focused-index (. index-table (focused-window:id)))
    (when (not focused-index) (self.logger.e "focused index not found")
      (lua "return "))
    (if (or (= direction Direction.LEFT) (= direction Direction.RIGHT))
        (let [target-index {:col (+ focused-index.col direction)}
              target-column (get-column focused-index.space target-index.col)]
          (when (not target-column) (self.logger.d "target column not found")
            (lua "return "))
          (local focused-column
                 (get-column focused-index.space focused-index.col))
          (tset (. window-list focused-index.space) target-index.col
                focused-column)
          (tset (. window-list focused-index.space) focused-index.col
                target-column)
          (each [row window (ipairs target-column)]
            (tset index-table (window:id)
                  {:col focused-index.col : row :space focused-index.space}))
          (each [row window (ipairs focused-column)]
            (tset index-table (window:id)
                  {:col target-index.col : row :space focused-index.space}))
          (local focused-frame (focused-window:frame))
          (local target-frame (: (. target-column 1) :frame))
          (if (= direction Direction.LEFT)
              (do
                (set focused-frame.x target-frame.x)
                (set target-frame.x (+ focused-frame.x2 self.window_gap)))
              (do
                (set target-frame.x focused-frame.x)
                (set focused-frame.x (+ target-frame.x2 self.window_gap))))
          (each [_ window (ipairs target-column)] (local frame (window:frame))
            (set frame.x target-frame.x)
            (self:moveWindow window frame))
          (each [_ window (ipairs focused-column)] (local frame (window:frame))
            (set frame.x focused-frame.x)
            (self:moveWindow window frame)))
        (or (= direction Direction.UP) (= direction Direction.DOWN))
        (let [target-index {:col focused-index.col
                            :row (+ focused-index.row (/ direction 2))
                            :space focused-index.space}
              target-window (get-window target-index.space target-index.col
                                        target-index.row)]
          (when (not target-window) (self.logger.d "target window not found")
            (lua "return "))
          (tset (. window-list target-index.space target-index.col)
                target-index.row focused-window)
          (tset (. window-list focused-index.space focused-index.col)
                focused-index.row target-window)
          (tset index-table (target-window:id) focused-index)
          (tset index-table (focused-window:id) target-index)
          (local focused-frame (focused-window:frame))
          (local target-frame (target-window:frame))
          (if (= direction Direction.UP)
              (do
                (set focused-frame.y target-frame.y)
                (set target-frame.y (+ focused-frame.y2 self.window_gap)))
              (do
                (set target-frame.y focused-frame.y)
                (set focused-frame.y (+ target-frame.y2 self.window_gap))))
          (self:moveWindow focused-window focused-frame)
          (self:moveWindow target-window target-frame)))
    (self:tileSpace focused-index.space)))

(defn center-window [self]
  (let [focused-window (Window.focusedWindow)]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (local focused-frame (focused-window:frame))
    (local screen-frame (: (focused-window:screen) :frame))
    (set focused-frame.x (- (+ screen-frame.x (/ screen-frame.w 2))
                            (/ focused-frame.w 2)))
    (self:moveWindow focused-window focused-frame)
    (local space (. (Spaces.windowSpaces focused-window) 1))
    (self:tileSpace space)))

(defn set-window-full-width [self]
  (let [focused-window (Window.focusedWindow)]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (local canvas (get-canvas (focused-window:screen)))
    (local focused-frame (focused-window:frame))
    (set (focused-frame.x focused-frame.w) (values canvas.x canvas.w))
    (self:moveWindow focused-window focused-frame)
    (local space (. (Spaces.windowSpaces focused-window) 1))
    (self:tileSpace space)))

(defn cycle-window-size [self direction cycle-direction]
  (let [focused-window (Window.focusedWindow)]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))

    (fn find-new-size [area-size frame-size cycle-direction]
      (let [sizes {}]
        (var new-size nil)
        (if (= cycle-direction Direction.ASCENDING)
            (do
              (each [index ratio (ipairs self.window_ratios)]
                (tset sizes index
                      (- (* ratio (+ area-size self.window_gap))
                         self.window_gap)))
              (set new-size (. sizes 1))
              (each [_ size (ipairs sizes)]
                (when (> size (+ frame-size 10)) (set new-size size)
                  (lua :break))))
            (= cycle-direction Direction.DESCENDING)
            (do
              (each [index ratio (ipairs self.window_ratios)]
                (tset sizes index
                      (- (* ratio (+ area-size self.window_gap))
                         self.window_gap)))
              (set new-size (. sizes (length sizes)))
              (for [i (length sizes) 1 (- 1)]
                (when (< (. sizes i) (- frame-size 10))
                  (set new-size (. sizes i))
                  (lua :break))))
            (do
              (self.logger.e "cycle_direction must be either Direction.ASCENDING or Direction.DESCENDING")
              (lua "return ")))
        new-size))

    (local canvas (get-canvas (focused-window:screen)))
    (local focused-frame (focused-window:frame))
    (if (= direction Direction.WIDTH)
        (let [new-width (find-new-size canvas.w focused-frame.w cycle-direction)]
          (set focused-frame.x
               (+ focused-frame.x (/ (- focused-frame.w new-width) 2)))
          (set focused-frame.w new-width))
        (= direction Direction.HEIGHT)
        (let [new-height (find-new-size canvas.h focused-frame.h
                                        cycle-direction)]
          (set focused-frame.y
               (math.max canvas.y
                         (+ focused-frame.y
                            (/ (- focused-frame.h new-height) 2))))
          (set focused-frame.h new-height)
          (set focused-frame.y
               (- focused-frame.y (math.max 0 (- focused-frame.y2 canvas.y2)))))
        (do
          (self.logger.e "direction must be either Direction.WIDTH or Direction.HEIGHT")
          (lua "return ")))
    (self:moveWindow focused-window focused-frame)
    (local space (. (Spaces.windowSpaces focused-window) 1))
    (self:tileSpace space)))

(defn slurp-window [self]
  (let [focused-window (Window.focusedWindow)]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (local focused-index (. index-table (focused-window:id)))
    (when (not focused-index) (self.logger.e "focused index not found")
      (lua "return "))
    (local column (get-column focused-index.space (- focused-index.col 1)))
    (when (not column) (self.logger.d "column not found") (lua "return "))
    (table.remove (. window-list focused-index.space focused-index.col)
                  focused-index.row)
    (when (= (length (. window-list focused-index.space focused-index.col)) 0)
      (table.remove (. window-list focused-index.space) focused-index.col))
    (table.insert column focused-window)
    (local num-windows (length column))
    (tset index-table (focused-window:id)
          {:col (- focused-index.col 1)
           :row num-windows
           :space focused-index.space})
    (update-index-table focused-index.space focused-index.col)
    (local canvas (get-canvas (focused-window:screen)))
    (local bounds {:x (. (: (. column 1) :frame) :x)
                   :x2 nil
                   :y canvas.y
                   :y2 canvas.y2})
    (local h (/ (math.max 0 (- canvas.h (* (- num-windows 1) self.window_gap)))
                num-windows))
    (self:tileColumn column bounds h)
    (self:tileSpace focused-index.space)))

(defn barf-window [self]
  (let [focused-window (Window.focusedWindow)]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (local focused-index (. index-table (focused-window:id)))
    (when (not focused-index) (self.logger.e "focused index not found")
      (lua "return "))
    (local column (get-column focused-index.space focused-index.col))
    (when (= (length column) 1) (self.logger.d "only window in column")
      (lua "return "))
    (table.remove column focused-index.row)
    (table.insert (. window-list focused-index.space) (+ focused-index.col 1)
                  [focused-window])
    (update-index-table focused-index.space focused-index.col)
    (local num-windows (length column))
    (local canvas (get-canvas (focused-window:screen)))
    (local focused-frame (focused-window:frame))
    (local bounds {:x focused-frame.x :x2 nil :y canvas.y :y2 canvas.y2})
    (local h (/ (math.max 0 (- canvas.h (* (- num-windows 1) self.window_gap)))
                num-windows))
    (set focused-frame.y canvas.y)
    (set focused-frame.x (+ focused-frame.x2 self.window_gap))
    (set focused-frame.h canvas.h)
    (self:moveWindow focused-window focused-frame)
    (self:tileColumn column bounds h)
    (self:tileSpace focused-index.space)))

(defn switch-to-space [self index]
  (let [space (get-space index)]
    (when (not space) (self.logger.d "space not found") (lua "return "))
    (Spaces.gotoSpace space)
    (focus-space space)))

(defn increment-space [self direction]
  (when (and (not= direction Direction.LEFT) (not= direction Direction.RIGHT))
    (self.logger.d "move is invalid, left and right only")
    (lua "return "))
  (local curr-space-id (Spaces.focusedSpace))
  (local layout (Spaces.allSpaces))
  (var curr-space-idx (- 1))
  (var num-spaces 0)
  (each [_ screen (ipairs (Screen.allScreens))]
    (local screen-uuid (screen:getUUID))
    (when (< curr-space-idx 0)
      (each [idx space-id (ipairs (. layout screen-uuid))]
        (when (= curr-space-id space-id)
          (set curr-space-idx (+ idx num-spaces))
          (lua :break))))
    (set num-spaces (+ num-spaces (length (. layout screen-uuid)))))
  (when (>= curr-space-idx 0)
    (local new-space-idx
           (+ (% (+ (- curr-space-idx 1) direction) num-spaces) 1))
    (self:switchToSpace new-space-idx)))

(defn move-window-to-space [self index window]
  (let [focused-window (or window (Window.focusedWindow))]
    (when (not focused-window) (self.logger.d "focused window not found")
      (lua "return "))
    (local focused-index (. index-table (focused-window:id)))
    (when (not focused-index) (self.logger.e "focused index not found")
      (lua "return "))
    (local new-space (get-space index))
    (when (not new-space) (self.logger.d "space not found") (lua "return "))
    (when (= new-space (. (Spaces.windowSpaces focused-window) 1))
      (self.logger.d "window already on space")
      (lua "return "))
    (when (not= (Spaces.spaceType new-space) :user)
      (self.logger.d "space is invalid")
      (lua "return "))
    (local screen (Screen (Spaces.spaceDisplay new-space)))
    (when (not screen) (self.logger.d "no screen for space") (lua "return "))
    (local old-space (self:removeWindow focused-window true))
    (when (not old-space) (self.logger.e "can't remove focused window")
      (lua "return "))
    (local version (hs.host.operatingSystemVersion))
    (if (>= (+ (* version.major 100) version.minor) 1405)
        (let [start-point (focused-window:frame)]
          (set start-point.x (+ start-point.x (/ start-point.w 2)))
          (set start-point.y (+ start-point.y 4))
          (local end-point (screen:frame))
          (set end-point.x (+ end-point.x (/ end-point.w 2)))
          (set end-point.y (+ end-point.y self.window_gap 4))
          (local do-window-drag
                 (coroutine.wrap (fn []
                                   (set start-point.x
                                        (+ start-point.x
                                           (/ (- end-point.x start-point.x) 2)))
                                   (set start-point.y
                                        (+ start-point.y
                                           (/ (- end-point.y start-point.y) 2)))
                                   (: (hs.eventtap.event.newMouseEvent left-mouse-dragged
                                                       start-point)
                                      :post)
                                   (coroutine.yield false)
                                   (: (hs.eventtap.event.newMouseEvent left-mouse-up end-point)
                                      :post)
                                   (while true
                                     (coroutine.yield false)
                                     (when (= (. (Spaces.windowSpaces focused-window)
                                                 1)
                                              new-space)
                                       (lua :break)))
                                   (self:addWindow focused-window)
                                   (self:tileSpace old-space)
                                   (self:tileSpace new-space)
                                   (focus-space new-space focused-window)
                                   true)))
          (: (hs.eventtap.event.newMouseEvent left-mouse-down start-point) :post)
          (Spaces.gotoSpace new-space)
          (local start-time (Timer.secondsSinceEpoch))
          (Timer.doUntil do-window-drag
                         (fn [timer]
                           (when (> (- (Timer.secondsSinceEpoch) start-time) 4)
                             (self.logger.ef "moveWindowToSpace() timeout! new space %d curr space %d window space %d"
                                             new-space
                                             (Spaces.activeSpaceOnScreen (screen:id))
                                             (. (Spaces.windowSpaces focused-window)
                                                1))
                             (timer:stop)))
                         Window.animationDuration))
        (do
          (Spaces.moveWindowToSpace focused-window new-space)
          (self:addWindow focused-window)
          (self:tileSpace old-space)
          (self:tileSpace new-space)
          (Spaces.gotoSpace new-space)
          (focus-space new-space focused-window)))))

(defn move-window [self window frame]
  (let [padding 0.02
        watcher (. ui-watchers (window:id))]
    (when (not watcher) (self.logger.e "window does not have ui watcher")
      (lua "return "))
    (when (= frame (window:frame)) (self.logger.v "no change in window frame")
      (lua "return "))
    (watcher:stop)
    (window:setFrame frame)
    (Timer.doAfter (+ Window.animationDuration padding)
                   (fn []
                     (watcher:start [Watcher.windowMoved Watcher.windowResized])))))

(def actions
  {:barf_out (___partial___ Paper-wM.barfWindow Paper-wM)
   :center_window (___partial___ Paper-wM.centerWindow Paper-wM)
   :cycle_height (___partial___ Paper-wM.cycleWindowSize Paper-wM
                                Direction.HEIGHT Direction.ASCENDING)
   :cycle_width (___partial___ Paper-wM.cycleWindowSize Paper-wM
                               Direction.WIDTH Direction.ASCENDING)
   :focus_down (___partial___ Paper-wM.focusWindow Paper-wM Direction.DOWN)
   :focus_left (___partial___ Paper-wM.focusWindow Paper-wM Direction.LEFT)
   :focus_right (___partial___ Paper-wM.focusWindow Paper-wM Direction.RIGHT)
   :focus_up (___partial___ Paper-wM.focusWindow Paper-wM Direction.UP)
   :full_width (___partial___ Paper-wM.setWindowFullWidth Paper-wM)
   :move_window_1 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 1)
   :move_window_2 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 2)
   :move_window_3 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 3)
   :move_window_4 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 4)
   :move_window_5 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 5)
   :move_window_6 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 6)
   :move_window_7 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 7)
   :move_window_8 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 8)
   :move_window_9 (___partial___ Paper-wM.moveWindowToSpace Paper-wM 9)
   :refresh_windows (___partial___ Paper-wM.refreshWindows Paper-wM)
   :reverse_cycle_height (___partial___ Paper-wM.cycleWindowSize Paper-wM
                                        Direction.HEIGHT Direction.DESCENDING)
   :reverse_cycle_width (___partial___ Paper-wM.cycleWindowSize Paper-wM
                                       Direction.WIDTH Direction.DESCENDING)
   :slurp_in (___partial___ Paper-wM.slurpWindow Paper-wM)
   :stop_events (___partial___ Paper-wM.stop Paper-wM)
   :swap_down (___partial___ Paper-wM.swapWindows Paper-wM Direction.DOWN)
   :swap_left (___partial___ Paper-wM.swapWindows Paper-wM Direction.LEFT)
   :swap_right (___partial___ Paper-wM.swapWindows Paper-wM Direction.RIGHT)
   :swap_up (___partial___ Paper-wM.swapWindows Paper-wM Direction.UP)
   :switch_space_1 (___partial___ Paper-wM.switchToSpace Paper-wM 1)
   :switch_space_2 (___partial___ Paper-wM.switchToSpace Paper-wM 2)
   :switch_space_3 (___partial___ Paper-wM.switchToSpace Paper-wM 3)
   :switch_space_4 (___partial___ Paper-wM.switchToSpace Paper-wM 4)
   :switch_space_5 (___partial___ Paper-wM.switchToSpace Paper-wM 5)
   :switch_space_6 (___partial___ Paper-wM.switchToSpace Paper-wM 6)
   :switch_space_7 (___partial___ Paper-wM.switchToSpace Paper-wM 7)
   :switch_space_8 (___partial___ Paper-wM.switchToSpace Paper-wM 8)
   :switch_space_9 (___partial___ Paper-wM.switchToSpace Paper-wM 9)
   :switch_space_l (___partial___ Paper-wM.incrementSpace Paper-wM
                                  Direction.LEFT)
   :switch_space_r (___partial___ Paper-wM.incrementSpace Paper-wM
                                  Direction.RIGHT)})

(defn bind-hotkeys [self mapping]
  (let [spec self.actions]
    (hs.spoons.bindHotkeysToSpec spec mapping)))

paper-wm
