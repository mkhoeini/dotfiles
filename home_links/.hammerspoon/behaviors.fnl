(require-macros (doto :cljlib require))

(ns behaviors
  (:require [:cljlib :refer [mapcat into mapv hash-set]]
            [:events :refer [add-event-handler]]))


(comment example-behavior
  {:name :example-behavior
   :description "Some example behavior"
   :enabled? true
   :respond-to [:example-tag]
   :fn (fn [event] (print (fnl.view event)))})


(def :private behaviors-register {})
(def :private tag-to-behavior-map {})


(defn register-behavior [name desc tags f]
  (let [behavior {:name name
                  :description desc
                  :enabled? true
                  :respond-to tags
                  :fn f}]
    (tset behaviors-register name behavior)
    (each [_ tag (pairs tags)]
      (when (= nil (. tag-to-behavior-map tag))
        (tset tag-to-behavior-map tag []))
      (table.insert (. tag-to-behavior-map tag) name))))


(defn- get-behaviors-for-tags [tags]
  (->> tags
       (mapcat #(. tag-to-behavior-map $))
       (into (hash-set))
       (mapv #(. behaviors-register $))))


(add-event-handler
 (fn [event]
   (let [bs (get-behaviors-for-tags event.event-tags)]
     (each [_ behavior (pairs bs)]
       (let [f (. behavior :fn)]
         (f event))))))


behaviors
