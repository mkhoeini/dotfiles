(require-macros (doto :cljlib require))

(ns utils)

(defn global-filter []
  "Filter that includes full-screen apps"
  (let [filter (hs.window.filter.new)]
    (filter:setAppFilter :Emacs {:allowRoles [:AXUnknown :AXStandardWindow :AXDialog :AXSystemDialog]})))

utils
