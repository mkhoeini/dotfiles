(require-macros (doto :cljlib require))

(ns events
  (:require [:fennel :as fnl]
            [:cljlib :refer [count]]))



(comment example-event
  {:timestamp  0
   :event-name :window-move
   :origin     :windows-watcher
   :event-tags [:some :tags]
   :event-data {:window-id 123
                :x 10
                :y 20}})


(var processing? false)
(var events-queue [])
(local event-handlers [])


(defmulti get-event-tags (fn [ev] [ev.event-name ev.origin]))
(defmethod get-event-tags :default [_] [:event/unknown])


(defn tag-events [ev-name orig tags]
  (defmethod get-event-tags [ev-name orig] [_] tags))


(defn add-event-handler [handler]
  (let [idx (+ 1 (length event-handlers))]
    (table.insert event-handlers handler)
    #(tset event-handlers idx nil)))


(defn- process-events []
  (set processing? true)
  (while (< 0 (count events-queue))
    (let [events events-queue]
      (set events-queue [])
      (each [_ event (ipairs events)]
        (each [_ handler (pairs event-handlers)]
          (handler event)))))
  (set processing? false))


(defn dispatch-event [event-name origin event-data]
  (let [event {:timestamp (hs.timer.secondsSinceEpoch)
               : event-name : origin : event-data}]
    (tset event :event-tags (get-event-tags event))
    (table.insert events-queue event)
    (when (not processing?) (process-events))))


(add-event-handler
 (fn [event]
  (print "got event" (fnl.view event))))


events
