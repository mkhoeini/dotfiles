hs.console.clearConsole()
local function _1_()
  return "#<namespace: core>"
end
package.preload["cljlib"] = package.preload["cljlib"] or function(...)
  local or_2_ = package.preload.reduced
  if not or_2_ then
    local function _3_()
      local Reduced
      local function _5_(_4_, view, options, indent)
        local x = _4_[1]
        return ("#<reduced: " .. view(x, options, (11 + indent)) .. ">")
      end
      local function _7_(_6_)
        local x = _6_[1]
        return x
      end
      local function _9_(_8_)
        local x = _8_[1]
        return ("reduced: " .. tostring(x))
      end
      Reduced = {__fennelview = _5_, __index = {unbox = _7_}, __name = "reduced", __tostring = _9_}
      local function reduced(value)
        return setmetatable({value}, Reduced)
      end
      local function reduced_3f(value)
        return rawequal(getmetatable(value), Reduced)
      end
      return {is_reduced = reduced_3f, reduced = reduced, ["reduced?"] = reduced_3f}
    end
    or_2_ = _3_
  end
  package.preload.reduced = or_2_
  local or_10_ = package.preload.itable
  if not or_10_ then
    local function _11_()
      local t_2fsort = table["sort"]
      local t_2fconcat = table["concat"]
      local t_2fremove = table["remove"]
      local t_2fmove = table["move"]
      local t_2finsert = table["insert"]
      local t_2funpack = (table.unpack or _G.unpack)
      local t_2fpack
      local function _12_(...)
        local tmp_9_auto = {...}
        tmp_9_auto["n"] = select("#", ...)
        return tmp_9_auto
      end
      t_2fpack = _12_
      local function pairs_2a(t)
        local _14_
        do
          local _13_ = getmetatable(t)
          if ((_G.type(_13_) == "table") and (nil ~= _13_.__pairs)) then
            local p = _13_.__pairs
            _14_ = p
          else
            local _ = _13_
            _14_ = pairs
          end
        end
        return _14_(t)
      end
      local function ipairs_2a(t)
        local _19_
        do
          local _18_ = getmetatable(t)
          if ((_G.type(_18_) == "table") and (nil ~= _18_.__ipairs)) then
            local i = _18_.__ipairs
            _19_ = i
          else
            local _ = _18_
            _19_ = ipairs
          end
        end
        return _19_(t)
      end
      local function length_2a(t)
        local _24_
        do
          local _23_ = getmetatable(t)
          if ((_G.type(_23_) == "table") and (nil ~= _23_.__len)) then
            local l = _23_.__len
            _24_ = l
          else
            local _ = _23_
            local function _27_(...)
              return #...
            end
            _24_ = _27_
          end
        end
        return _24_(t)
      end
      local function copy(t)
        if t then
          local tbl_16_auto = {}
          for k, v in pairs_2a(t) do
            local k_17_auto, v_18_auto = k, v
            if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
              tbl_16_auto[k_17_auto] = v_18_auto
            else
            end
          end
          return tbl_16_auto
        else
          return nil
        end
      end
      local function eq(...)
        local _31_, _32_, _33_ = select("#", ...), ...
        if ((_31_ == 0) or (_31_ == 1)) then
          return true
        elseif ((_31_ == 2) and true and true) then
          local _3fa = _32_
          local _3fb = _33_
          if (_3fa == _3fb) then
            return true
          else
            local _34_ = type(_3fb)
            if ((type(_3fa) == _34_) and (_34_ == "table")) then
              local res, count_a, count_b = true, 0, 0
              for k, v in pairs_2a(_3fa) do
                if not res then break end
                local function _35_(...)
                  local res0 = nil
                  for k_2a, v0 in pairs_2a(_3fb) do
                    if res0 then break end
                    if eq(k_2a, k) then
                      res0 = v0
                    else
                    end
                  end
                  return res0
                end
                res = eq(v, _35_(...))
                count_a = (count_a + 1)
              end
              if res then
                for _, _0 in pairs_2a(_3fb) do
                  count_b = (count_b + 1)
                end
                res = (count_a == count_b)
              else
              end
              return res
            else
              return false
            end
          end
        elseif (true and true and true) then
          local _ = _31_
          local _3fa = _32_
          local _3fb = _33_
          return (eq(_3fa, _3fb) and eq(select(2, ...)))
        else
          return nil
        end
      end
      local function deep_index(tbl, key)
        local res = nil
        for k, v in pairs_2a(tbl) do
          if res then break end
          if eq(k, key) then
            res = v
          else
            res = nil
          end
        end
        return res
      end
      local function deep_newindex(tbl, key, val)
        local done = false
        if ("table" == type(key)) then
          for k, _ in pairs_2a(tbl) do
            if done then break end
            if eq(k, key) then
              rawset(tbl, k, val)
              done = true
            else
            end
          end
        else
        end
        if not done then
          return rawset(tbl, key, val)
        else
          return nil
        end
      end
      local function immutable(t, opts)
        local t0
        if (opts and opts["fast-index?"]) then
          t0 = t
        else
          t0 = setmetatable(t, {__index = deep_index, __newindex = deep_newindex})
        end
        local len = length_2a(t0)
        local proxy = {}
        local __len
        local function _45_()
          return len
        end
        __len = _45_
        local __index
        local function _46_(_241, _242)
          return t0[_242]
        end
        __index = _46_
        local __newindex
        local function _47_()
          return error((tostring(proxy) .. " is immutable"), 2)
        end
        __newindex = _47_
        local __pairs
        local function _48_()
          local function _49_(_, k)
            return next(t0, k)
          end
          return _49_, nil, nil
        end
        __pairs = _48_
        local __ipairs
        local function _50_()
          local function _51_(_, k)
            return next(t0, k)
          end
          return _51_
        end
        __ipairs = _50_
        local __call
        local function _52_(_241, _242)
          return t0[_242]
        end
        __call = _52_
        local __fennelview
        local function _53_(_241, _242, _243, _244)
          return _242(t0, _243, _244)
        end
        __fennelview = _53_
        local __fennelrest
        local function _54_(_241, _242)
          return immutable({t_2funpack(t0, _242)})
        end
        __fennelrest = _54_
        return setmetatable(proxy, {__index = __index, __newindex = __newindex, __len = __len, __pairs = __pairs, __ipairs = __ipairs, __call = __call, __metatable = {__len = __len, __pairs = __pairs, __ipairs = __ipairs, __call = __call, __fennelrest = __fennelrest, __fennelview = __fennelview, ["itable/type"] = "immutable"}})
      end
      local function insert(t, ...)
        local t0 = copy(t)
        do
          local _55_, _56_, _57_ = select("#", ...), ...
          if (_55_ == 0) then
            error("wrong number of arguments to 'insert'")
          elseif ((_55_ == 1) and true) then
            local _3fv = _56_
            t_2finsert(t0, _3fv)
          elseif (true and true and true) then
            local _ = _55_
            local _3fk = _56_
            local _3fv = _57_
            t_2finsert(t0, _3fk, _3fv)
          else
          end
        end
        return immutable(t0)
      end
      local move
      if t_2fmove then
        local function _59_(src, start, _end, tgt, dest)
          local src0 = copy(src)
          local dest0 = copy(dest)
          return immutable(t_2fmove(src0, start, _end, tgt, dest0))
        end
        move = _59_
      else
        move = nil
      end
      local function pack(...)
        local function _61_(...)
          local tmp_9_auto = {...}
          tmp_9_auto["n"] = select("#", ...)
          return tmp_9_auto
        end
        return immutable(_61_(...))
      end
      local function remove(t, key)
        local t0 = copy(t)
        local v = t_2fremove(t0, key)
        return immutable(t0), v
      end
      local function concat(t, sep, start, _end, serializer, opts)
        local serializer0 = (serializer or tostring)
        local _62_
        do
          local tbl_21_auto = {}
          local i_22_auto = 0
          for _, v in ipairs_2a(t) do
            local val_23_auto = serializer0(v, opts)
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          _62_ = tbl_21_auto
        end
        return t_2fconcat(_62_, sep, start, _end)
      end
      local function unpack(t, ...)
        return t_2funpack(copy(t), ...)
      end
      local function assoc(t, key, val, ...)
        local len = select("#", ...)
        if (0 ~= (len % 2)) then
          error(("no value supplied for key " .. tostring(select(len, ...))), 2)
        else
        end
        local t0
        do
          local tmp_9_auto = copy(t)
          tmp_9_auto[key] = val
          t0 = tmp_9_auto
        end
        for i = 1, len, 2 do
          local k, v = select(i, ...)
          t0[k] = v
        end
        return immutable(t0)
      end
      local function assoc_in(t, _65_, val)
        local k = _65_[1]
        local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_65_, 2)
        local t0 = (t or {})
        if next(ks) then
          return assoc(t0, k, assoc_in((t0[k] or {}), ks, val))
        else
          return assoc(t0, k, val)
        end
      end
      local function update(t, key, f)
        local function _67_()
          local tmp_9_auto = copy(t)
          tmp_9_auto[key] = f(t[key])
          return tmp_9_auto
        end
        return immutable(_67_())
      end
      local function update_in(t, _68_, f)
        local k = _68_[1]
        local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_68_, 2)
        local t0 = (t or {})
        if next(ks) then
          return assoc(t0, k, update_in(t0[k], ks, f))
        else
          return update(t0, k, f)
        end
      end
      local function deepcopy(x)
        local function deepcopy_2a(x0, seen)
          local _70_ = type(x0)
          if (_70_ == "table") then
            local _71_ = seen[x0]
            if (_71_ == true) then
              return error("immutable tables can't contain self reference", 2)
            else
              local _ = _71_
              seen[x0] = true
              local function _72_()
                local tbl_16_auto = {}
                for k, v in pairs_2a(x0) do
                  local k_17_auto, v_18_auto = deepcopy_2a(k, seen), deepcopy_2a(v, seen)
                  if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
                    tbl_16_auto[k_17_auto] = v_18_auto
                  else
                  end
                end
                return tbl_16_auto
              end
              return immutable(_72_())
            end
          else
            local _ = _70_
            return x0
          end
        end
        return deepcopy_2a(x, {})
      end
      local function first(_76_)
        local x = _76_[1]
        return x
      end
      local function rest(t)
        return (remove(t, 1))
      end
      local function nthrest(t, n)
        local t_2a = {}
        for i = (n + 1), length_2a(t) do
          t_2finsert(t_2a, t[i])
        end
        return immutable(t_2a)
      end
      local function last(t)
        return t[length_2a(t)]
      end
      local function butlast(t)
        return (remove(t, length_2a(t)))
      end
      local function join(...)
        local _77_, _78_, _79_ = select("#", ...), ...
        if (_77_ == 0) then
          return nil
        elseif ((_77_ == 1) and true) then
          local _3ft = _78_
          return immutable(copy(_3ft))
        elseif ((_77_ == 2) and true and true) then
          local _3ft1 = _78_
          local _3ft2 = _79_
          local to = copy(_3ft1)
          local from = (_3ft2 or {})
          for _, v in ipairs_2a(from) do
            t_2finsert(to, v)
          end
          return immutable(to)
        elseif (true and true and true) then
          local _ = _77_
          local _3ft1 = _78_
          local _3ft2 = _79_
          return join(join(_3ft1, _3ft2), select(3, ...))
        else
          return nil
        end
      end
      local function take(n, t)
        local t_2a = {}
        for i = 1, n do
          t_2finsert(t_2a, t[i])
        end
        return immutable(t_2a)
      end
      local function drop(n, t)
        return nthrest(t, n)
      end
      local function partition(...)
        local res = {}
        local function partition_2a(...)
          local _81_, _82_, _83_, _84_, _85_ = select("#", ...), ...
          if ((_81_ == 0) or (_81_ == 1)) then
            return error("wrong amount arguments to 'partition'")
          elseif ((_81_ == 2) and true and true) then
            local _3fn = _82_
            local _3ft = _83_
            return partition_2a(_3fn, _3fn, _3ft)
          elseif ((_81_ == 3) and true and true and true) then
            local _3fn = _82_
            local _3fstep = _83_
            local _3ft = _84_
            local p = take(_3fn, _3ft)
            if (_3fn == length_2a(p)) then
              t_2finsert(res, p)
              return partition_2a(_3fn, _3fstep, {t_2funpack(_3ft, (_3fstep + 1))})
            else
              return nil
            end
          elseif (true and true and true and true and true) then
            local _ = _81_
            local _3fn = _82_
            local _3fstep = _83_
            local _3fpad = _84_
            local _3ft = _85_
            local p = take(_3fn, _3ft)
            if (_3fn == length_2a(p)) then
              t_2finsert(res, p)
              return partition_2a(_3fn, _3fstep, _3fpad, {t_2funpack(_3ft, (_3fstep + 1))})
            else
              return t_2finsert(res, take(_3fn, join(p, _3fpad)))
            end
          else
            return nil
          end
        end
        partition_2a(...)
        return immutable(res)
      end
      local function keys(t)
        local function _89_()
          local tbl_21_auto = {}
          local i_22_auto = 0
          for k, _ in pairs_2a(t) do
            local val_23_auto = k
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          return tbl_21_auto
        end
        return immutable(_89_())
      end
      local function vals(t)
        local function _91_()
          local tbl_21_auto = {}
          local i_22_auto = 0
          for _, v in pairs_2a(t) do
            local val_23_auto = v
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          return tbl_21_auto
        end
        return immutable(_91_())
      end
      local function group_by(f, t)
        local res = {}
        local ungroupped = {}
        for _, v in pairs_2a(t) do
          local k = f(v)
          if (nil ~= k) then
            local _93_ = res[k]
            if (nil ~= _93_) then
              local t_2a = _93_
              t_2finsert(t_2a, v)
            else
              local _0 = _93_
              res[k] = {v}
            end
          else
            t_2finsert(ungroupped, v)
          end
        end
        local function _96_()
          local tbl_16_auto = {}
          for k, t0 in pairs_2a(res) do
            local k_17_auto, v_18_auto = k, immutable(t0)
            if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
              tbl_16_auto[k_17_auto] = v_18_auto
            else
            end
          end
          return tbl_16_auto
        end
        return immutable(_96_()), immutable(ungroupped)
      end
      local function frequencies(t)
        local res = setmetatable({}, {__index = deep_index, __newindex = deep_newindex})
        for _, v in pairs_2a(t) do
          local _98_ = res[v]
          if (nil ~= _98_) then
            local a = _98_
            res[v] = (a + 1)
          else
            local _0 = _98_
            res[v] = 1
          end
        end
        return immutable(res)
      end
      local itable
      local function _100_(t, f)
        local function _101_()
          local tmp_9_auto = copy(t)
          t_2fsort(tmp_9_auto, f)
          return tmp_9_auto
        end
        return immutable(_101_())
      end
      itable = {sort = _100_, pack = pack, unpack = unpack, concat = concat, insert = insert, move = move, remove = remove, pairs = pairs_2a, ipairs = ipairs_2a, length = length_2a, eq = eq, deepcopy = deepcopy, assoc = assoc, ["assoc-in"] = assoc_in, update = update, ["update-in"] = update_in, keys = keys, vals = vals, ["group-by"] = group_by, frequencies = frequencies, first = first, rest = rest, nthrest = nthrest, last = last, butlast = butlast, join = join, partition = partition, take = take, drop = drop}
      local function _102_(_, t, opts)
        local _103_ = getmetatable(t)
        if ((_G.type(_103_) == "table") and (_103_["itable/type"] == "immutable")) then
          return t
        else
          local _0 = _103_
          return immutable(copy(t), opts)
        end
      end
      return setmetatable(itable, {__call = _102_})
    end
    or_10_ = _11_
  end
  package.preload.itable = or_10_
  local or_105_ = package.preload["lazy-seq"]
  if not or_105_ then
    local function _106_()
      local or_107_ = package.preload.reduced
      if not or_107_ then
        local function _108_()
          local Reduced
          local function _110_(_109_, view, options, indent)
            local x = _109_[1]
            return ("#<reduced: " .. view(x, options, (11 + indent)) .. ">")
          end
          local function _112_(_111_)
            local x = _111_[1]
            return x
          end
          local function _114_(_113_)
            local x = _113_[1]
            return ("reduced: " .. tostring(x))
          end
          Reduced = {__fennelview = _110_, __index = {unbox = _112_}, __name = "reduced", __tostring = _114_}
          local function reduced(value)
            return setmetatable({value}, Reduced)
          end
          local function reduced_3f(value)
            return rawequal(getmetatable(value), Reduced)
          end
          return {is_reduced = reduced_3f, reduced = reduced, ["reduced?"] = reduced_3f}
        end
        or_107_ = _108_
      end
      package.preload.reduced = or_107_
      utf8 = _G.utf8
      local function pairs_2a(t)
        local mt = getmetatable(t)
        if (("table" == mt) and mt.__pairs) then
          return mt.__pairs(t)
        else
          return pairs(t)
        end
      end
      local function ipairs_2a(t)
        local mt = getmetatable(t)
        if (("table" == mt) and mt.__ipairs) then
          return mt.__ipairs(t)
        else
          return ipairs(t)
        end
      end
      local function rev_ipairs(t)
        local function next(t0, i)
          local i0 = (i - 1)
          if (i0 == 0) then
            return nil
          else
            local _ = i0
            return i0, t0[i0]
          end
        end
        return next, t, (1 + #t)
      end
      local function length_2a(t)
        local mt = getmetatable(t)
        if (("table" == mt) and mt.__len) then
          return mt.__len(t)
        else
          return #t
        end
      end
      local function table_pack(...)
        local tmp_9_auto = {...}
        tmp_9_auto["n"] = select("#", ...)
        return tmp_9_auto
      end
      local table_unpack = (table.unpack or _G.unpack)
      local seq = nil
      local cons_iter = nil
      local function first(s)
        local _119_ = seq(s)
        if (nil ~= _119_) then
          local s_2a = _119_
          return s_2a(true)
        else
          local _ = _119_
          return nil
        end
      end
      local function empty_cons_view()
        return "@seq()"
      end
      local function empty_cons_len()
        return 0
      end
      local function empty_cons_index()
        return nil
      end
      local function cons_newindex()
        return error("cons cell is immutable")
      end
      local function empty_cons_next(s)
        return nil
      end
      local function empty_cons_pairs(s)
        return empty_cons_next, nil, s
      end
      local function gettype(x)
        local _121_
        do
          local t_122_ = getmetatable(x)
          if (nil ~= t_122_) then
            t_122_ = t_122_["__lazy-seq/type"]
          else
          end
          _121_ = t_122_
        end
        if (nil ~= _121_) then
          local t = _121_
          return t
        else
          local _ = _121_
          return type(x)
        end
      end
      local function realize(c)
        if ("lazy-cons" == gettype(c)) then
          c()
        else
        end
        return c
      end
      local empty_cons = {}
      local function empty_cons_call(tf)
        if tf then
          return nil
        else
          return empty_cons
        end
      end
      local function empty_cons_fennelrest()
        return empty_cons
      end
      local function empty_cons_eq(_, s)
        return rawequal(getmetatable(empty_cons), getmetatable(realize(s)))
      end
      setmetatable(empty_cons, {__call = empty_cons_call, __len = empty_cons_len, __fennelview = empty_cons_view, __fennelrest = empty_cons_fennelrest, ["__lazy-seq/type"] = "empty-cons", __newindex = cons_newindex, __index = empty_cons_index, __name = "cons", __eq = empty_cons_eq, __pairs = empty_cons_pairs})
      local function rest(s)
        local _127_ = seq(s)
        if (nil ~= _127_) then
          local s_2a = _127_
          return s_2a(false)
        else
          local _ = _127_
          return empty_cons
        end
      end
      local function seq_3f(x)
        local tp = gettype(x)
        return ((tp == "cons") or (tp == "lazy-cons") or (tp == "empty-cons"))
      end
      local function empty_3f(x)
        return not seq(x)
      end
      local function next(s)
        return seq(realize(rest(seq(s))))
      end
      local function view_seq(list, options, view, indent, elements)
        table.insert(elements, view(first(list), options, indent))
        do
          local tail = next(list)
          if ("cons" == gettype(tail)) then
            view_seq(tail, options, view, indent, elements)
          else
          end
        end
        return elements
      end
      local function pp_seq(list, view, options, indent)
        local items = view_seq(list, options, view, (indent + 5), {})
        local lines
        do
          local tbl_21_auto = {}
          local i_22_auto = 0
          for i, line in ipairs(items) do
            local val_23_auto
            if (i == 1) then
              val_23_auto = line
            else
              val_23_auto = ("     " .. line)
            end
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          lines = tbl_21_auto
        end
        lines[1] = ("@seq(" .. (lines[1] or ""))
        lines[#lines] = (lines[#lines] .. ")")
        return lines
      end
      local drop = nil
      local function cons_fennelrest(c, i)
        return drop((i - 1), c)
      end
      local allowed_types = {cons = true, ["empty-cons"] = true, ["lazy-cons"] = true, ["nil"] = true, string = true, table = true}
      local function cons_next(_, s)
        if (empty_cons ~= s) then
          local tail = next(s)
          local _132_ = gettype(tail)
          if (_132_ == "cons") then
            return tail, first(s)
          else
            local _0 = _132_
            return empty_cons, first(s)
          end
        else
          return nil
        end
      end
      local function cons_pairs(s)
        return cons_next, nil, s
      end
      local function cons_eq(s1, s2)
        if rawequal(s1, s2) then
          return true
        else
          if (not rawequal(s2, empty_cons) and not rawequal(s1, empty_cons)) then
            local s10, s20, res = s1, s2, true
            while (res and s10 and s20) do
              res = (first(s10) == first(s20))
              s10 = next(s10)
              s20 = next(s20)
            end
            return res
          else
            return false
          end
        end
      end
      local function cons_len(s)
        local s0, len = s, 0
        while s0 do
          s0, len = next(s0), (len + 1)
        end
        return len
      end
      local function cons_index(s, i)
        if (i > 0) then
          local s0, i_2a = s, 1
          while ((i_2a ~= i) and s0) do
            s0, i_2a = next(s0), (i_2a + 1)
          end
          return first(s0)
        else
          return nil
        end
      end
      local function cons(head, tail)
        do local _ = {head, tail} end
        local tp = gettype(tail)
        assert(allowed_types[tp], ("expected nil, cons, table, or string as a tail, got: %s"):format(tp))
        local function _138_(_241, _242)
          if _242 then
            return head
          else
            if (nil ~= tail) then
              local s = tail
              return s
            elseif (tail == nil) then
              return empty_cons
            else
              return nil
            end
          end
        end
        return setmetatable({}, {__call = _138_, ["__lazy-seq/type"] = "cons", __index = cons_index, __newindex = cons_newindex, __len = cons_len, __pairs = cons_pairs, __name = "cons", __eq = cons_eq, __fennelview = pp_seq, __fennelrest = cons_fennelrest})
      end
      local function _141_(s)
        local _142_ = gettype(s)
        if (_142_ == "cons") then
          return s
        elseif (_142_ == "lazy-cons") then
          return seq(realize(s))
        elseif (_142_ == "empty-cons") then
          return nil
        elseif (_142_ == "nil") then
          return nil
        elseif (_142_ == "table") then
          return cons_iter(s)
        elseif (_142_ == "string") then
          return cons_iter(s)
        else
          local _ = _142_
          return error(("expected table, string or sequence, got %s"):format(_), 2)
        end
      end
      seq = _141_
      local function lazy_seq(f)
        local lazy_cons = cons(nil, nil)
        local realize0
        local function _144_()
          local s = seq(f())
          if (nil ~= s) then
            return setmetatable(lazy_cons, getmetatable(s))
          else
            return setmetatable(lazy_cons, getmetatable(empty_cons))
          end
        end
        realize0 = _144_
        local function _146_(_241, _242)
          return realize0()(_242)
        end
        local function _147_(_241, _242)
          return realize0()[_242]
        end
        local function _148_(...)
          realize0()
          return pp_seq(...)
        end
        local function _149_()
          return length_2a(realize0())
        end
        local function _150_()
          return pairs_2a(realize0())
        end
        local function _151_(_241, _242)
          return (realize0() == _242)
        end
        return setmetatable(lazy_cons, {__call = _146_, __index = _147_, __newindex = cons_newindex, __fennelview = _148_, __fennelrest = cons_fennelrest, __len = _149_, __pairs = _150_, __name = "lazy cons", __eq = _151_, ["__lazy-seq/type"] = "lazy-cons"})
      end
      local function list(...)
        local args = table_pack(...)
        local l = empty_cons
        for i = args.n, 1, -1 do
          l = cons(args[i], l)
        end
        return l
      end
      local function spread(arglist)
        local arglist0 = seq(arglist)
        if (nil == arglist0) then
          return nil
        elseif (nil == next(arglist0)) then
          return seq(first(arglist0))
        elseif "else" then
          return cons(first(arglist0), spread(next(arglist0)))
        else
          return nil
        end
      end
      local function list_2a(...)
        local _153_, _154_, _155_, _156_, _157_ = select("#", ...), ...
        if ((_153_ == 1) and true) then
          local _3fargs = _154_
          return seq(_3fargs)
        elseif ((_153_ == 2) and true and true) then
          local _3fa = _154_
          local _3fargs = _155_
          return cons(_3fa, seq(_3fargs))
        elseif ((_153_ == 3) and true and true and true) then
          local _3fa = _154_
          local _3fb = _155_
          local _3fargs = _156_
          return cons(_3fa, cons(_3fb, seq(_3fargs)))
        elseif ((_153_ == 4) and true and true and true and true) then
          local _3fa = _154_
          local _3fb = _155_
          local _3fc = _156_
          local _3fargs = _157_
          return cons(_3fa, cons(_3fb, cons(_3fc, seq(_3fargs))))
        else
          local _ = _153_
          return spread(list(...))
        end
      end
      local function kind(t)
        local _159_ = type(t)
        if (_159_ == "table") then
          local len = length_2a(t)
          local nxt, t_2a, k = pairs_2a(t)
          local function _160_()
            if (len == 0) then
              return k
            else
              return len
            end
          end
          if (nil ~= nxt(t_2a, _160_())) then
            return "assoc"
          elseif (len > 0) then
            return "seq"
          else
            return "empty"
          end
        elseif (_159_ == "string") then
          local len
          if utf8 then
            len = utf8.len(t)
          else
            len = #t
          end
          if (len > 0) then
            return "string"
          else
            return "empty"
          end
        else
          local _ = _159_
          return "else"
        end
      end
      local function rseq(rev)
        local _165_ = gettype(rev)
        if (_165_ == "table") then
          local _166_ = kind(rev)
          if (_166_ == "seq") then
            local function wrap(nxt, t, i)
              local i0, v = nxt(t, i)
              if (nil ~= i0) then
                local function _167_()
                  return wrap(nxt, t, i0)
                end
                return cons(v, lazy_seq(_167_))
              else
                return empty_cons
              end
            end
            return wrap(rev_ipairs(rev))
          elseif (_166_ == "empty") then
            return nil
          else
            local _ = _166_
            return error("can't create an rseq from a non-sequential table")
          end
        else
          local _ = _165_
          return error(("can't create an rseq from a " .. _))
        end
      end
      local function _171_(t)
        local _172_ = kind(t)
        if (_172_ == "assoc") then
          local function wrap(nxt, t0, k)
            local k0, v = nxt(t0, k)
            if (nil ~= k0) then
              local function _173_()
                return wrap(nxt, t0, k0)
              end
              return cons({k0, v}, lazy_seq(_173_))
            else
              return empty_cons
            end
          end
          return wrap(pairs_2a(t))
        elseif (_172_ == "seq") then
          local function wrap(nxt, t0, i)
            local i0, v = nxt(t0, i)
            if (nil ~= i0) then
              local function _175_()
                return wrap(nxt, t0, i0)
              end
              return cons(v, lazy_seq(_175_))
            else
              return empty_cons
            end
          end
          return wrap(ipairs_2a(t))
        elseif (_172_ == "string") then
          local char
          if utf8 then
            char = utf8.char
          else
            char = string.char
          end
          local function wrap(nxt, t0, i)
            local i0, v = nxt(t0, i)
            if (nil ~= i0) then
              local function _178_()
                return wrap(nxt, t0, i0)
              end
              return cons(char(v), lazy_seq(_178_))
            else
              return empty_cons
            end
          end
          local function _180_()
            if utf8 then
              return utf8.codes(t)
            else
              return ipairs_2a({string.byte(t, 1, #t)})
            end
          end
          return wrap(_180_())
        elseif (_172_ == "empty") then
          return nil
        else
          return nil
        end
      end
      cons_iter = _171_
      local function every_3f(pred, coll)
        local _182_ = seq(coll)
        if (nil ~= _182_) then
          local s = _182_
          if pred(first(s)) then
            local _183_ = next(s)
            if (nil ~= _183_) then
              local r = _183_
              return every_3f(pred, r)
            else
              local _ = _183_
              return true
            end
          else
            return false
          end
        else
          local _ = _182_
          return false
        end
      end
      local function some_3f(pred, coll)
        local _187_ = seq(coll)
        if (nil ~= _187_) then
          local s = _187_
          local or_188_ = pred(first(s))
          if not or_188_ then
            local _189_ = next(s)
            if (nil ~= _189_) then
              local r = _189_
              or_188_ = some_3f(pred, r)
            else
              local _ = _189_
              or_188_ = nil
            end
          end
          return or_188_
        else
          local _ = _187_
          return nil
        end
      end
      local function pack(s)
        local res = {}
        local n = 0
        do
          local _195_ = seq(s)
          if (nil ~= _195_) then
            local s_2a = _195_
            for _, v in pairs_2a(s_2a) do
              n = (n + 1)
              res[n] = v
            end
          else
          end
        end
        res["n"] = n
        return res
      end
      local function count(s)
        local _197_ = seq(s)
        if (nil ~= _197_) then
          local s_2a = _197_
          return length_2a(s_2a)
        else
          local _ = _197_
          return 0
        end
      end
      local function unpack(s)
        local t = pack(s)
        return table_unpack(t, 1, t.n)
      end
      local function concat(...)
        local _199_ = select("#", ...)
        if (_199_ == 0) then
          return empty_cons
        elseif (_199_ == 1) then
          local x = ...
          local function _200_()
            return x
          end
          return lazy_seq(_200_)
        elseif (_199_ == 2) then
          local x, y = ...
          local function _201_()
            local _202_ = seq(x)
            if (nil ~= _202_) then
              local s = _202_
              return cons(first(s), concat(rest(s), y))
            elseif (_202_ == nil) then
              return y
            else
              return nil
            end
          end
          return lazy_seq(_201_)
        else
          local _ = _199_
          local pv_204_, pv_205_ = ...
          return concat(concat(pv_204_, pv_205_), select(3, ...))
        end
      end
      local function reverse(s)
        local function helper(s0, res)
          local _207_ = seq(s0)
          if (nil ~= _207_) then
            local s_2a = _207_
            return helper(rest(s_2a), cons(first(s_2a), res))
          else
            local _ = _207_
            return res
          end
        end
        return helper(s, empty_cons)
      end
      local function map(f, ...)
        local _209_ = select("#", ...)
        if (_209_ == 0) then
          return nil
        elseif (_209_ == 1) then
          local col = ...
          local function _210_()
            local _211_ = seq(col)
            if (nil ~= _211_) then
              local x = _211_
              return cons(f(first(x)), map(f, seq(rest(x))))
            else
              local _ = _211_
              return nil
            end
          end
          return lazy_seq(_210_)
        elseif (_209_ == 2) then
          local s1, s2 = ...
          local function _213_()
            local s10 = seq(s1)
            local s20 = seq(s2)
            if (s10 and s20) then
              return cons(f(first(s10), first(s20)), map(f, rest(s10), rest(s20)))
            else
              return nil
            end
          end
          return lazy_seq(_213_)
        elseif (_209_ == 3) then
          local s1, s2, s3 = ...
          local function _215_()
            local s10 = seq(s1)
            local s20 = seq(s2)
            local s30 = seq(s3)
            if (s10 and s20 and s30) then
              return cons(f(first(s10), first(s20), first(s30)), map(f, rest(s10), rest(s20), rest(s30)))
            else
              return nil
            end
          end
          return lazy_seq(_215_)
        else
          local _ = _209_
          local s = list(...)
          local function _217_()
            local function _218_(_2410)
              return (nil ~= seq(_2410))
            end
            if every_3f(_218_, s) then
              return cons(f(unpack(map(first, s))), map(f, unpack(map(rest, s))))
            else
              return nil
            end
          end
          return lazy_seq(_217_)
        end
      end
      local function map_indexed(f, coll)
        local mapi
        local function mapi0(idx, coll0)
          local function _221_()
            local _222_ = seq(coll0)
            if (nil ~= _222_) then
              local s = _222_
              return cons(f(idx, first(s)), mapi0((idx + 1), rest(s)))
            else
              local _ = _222_
              return nil
            end
          end
          return lazy_seq(_221_)
        end
        mapi = mapi0
        return mapi(1, coll)
      end
      local function mapcat(f, ...)
        local step
        local function step0(colls)
          local function _224_()
            local _225_ = seq(colls)
            if (nil ~= _225_) then
              local s = _225_
              local c = first(s)
              return concat(c, step0(rest(colls)))
            else
              local _ = _225_
              return nil
            end
          end
          return lazy_seq(_224_)
        end
        step = step0
        return step(map(f, ...))
      end
      local function take(n, coll)
        local function _227_()
          if (n > 0) then
            local _228_ = seq(coll)
            if (nil ~= _228_) then
              local s = _228_
              return cons(first(s), take((n - 1), rest(s)))
            else
              local _ = _228_
              return nil
            end
          else
            return nil
          end
        end
        return lazy_seq(_227_)
      end
      local function take_while(pred, coll)
        local function _231_()
          local _232_ = seq(coll)
          if (nil ~= _232_) then
            local s = _232_
            local v = first(s)
            if pred(v) then
              return cons(v, take_while(pred, rest(s)))
            else
              return nil
            end
          else
            local _ = _232_
            return nil
          end
        end
        return lazy_seq(_231_)
      end
      local function _235_(n, coll)
        local step
        local function step0(n0, coll0)
          local s = seq(coll0)
          if ((n0 > 0) and s) then
            return step0((n0 - 1), rest(s))
          else
            return s
          end
        end
        step = step0
        local function _237_()
          return step(n, coll)
        end
        return lazy_seq(_237_)
      end
      drop = _235_
      local function drop_while(pred, coll)
        local step
        local function step0(pred0, coll0)
          local s = seq(coll0)
          if (s and pred0(first(s))) then
            return step0(pred0, rest(s))
          else
            return s
          end
        end
        step = step0
        local function _239_()
          return step(pred, coll)
        end
        return lazy_seq(_239_)
      end
      local function drop_last(...)
        local _240_ = select("#", ...)
        if (_240_ == 0) then
          return empty_cons
        elseif (_240_ == 1) then
          return drop_last(1, ...)
        else
          local _ = _240_
          local n, coll = ...
          local function _241_(x)
            return x
          end
          return map(_241_, coll, drop(n, coll))
        end
      end
      local function take_last(n, coll)
        local function loop(s, lead)
          if lead then
            return loop(next(s), next(lead))
          else
            return s
          end
        end
        return loop(seq(coll), seq(drop(n, coll)))
      end
      local function take_nth(n, coll)
        local function _244_()
          local _245_ = seq(coll)
          if (nil ~= _245_) then
            local s = _245_
            return cons(first(s), take_nth(n, drop(n, s)))
          else
            return nil
          end
        end
        return lazy_seq(_244_)
      end
      local function split_at(n, coll)
        return {take(n, coll), drop(n, coll)}
      end
      local function split_with(pred, coll)
        return {take_while(pred, coll), drop_while(pred, coll)}
      end
      local function filter(pred, coll)
        local function _247_()
          local _248_ = seq(coll)
          if (nil ~= _248_) then
            local s = _248_
            local x = first(s)
            local r = rest(s)
            if pred(x) then
              return cons(x, filter(pred, r))
            else
              return filter(pred, r)
            end
          else
            local _ = _248_
            return nil
          end
        end
        return lazy_seq(_247_)
      end
      local function keep(f, coll)
        local function _251_()
          local _252_ = seq(coll)
          if (nil ~= _252_) then
            local s = _252_
            local _253_ = f(first(s))
            if (nil ~= _253_) then
              local x = _253_
              return cons(x, keep(f, rest(s)))
            elseif (_253_ == nil) then
              return keep(f, rest(s))
            else
              return nil
            end
          else
            local _ = _252_
            return nil
          end
        end
        return lazy_seq(_251_)
      end
      local function keep_indexed(f, coll)
        local keepi
        local function keepi0(idx, coll0)
          local function _256_()
            local _257_ = seq(coll0)
            if (nil ~= _257_) then
              local s = _257_
              local x = f(idx, first(s))
              if (nil == x) then
                return keepi0((1 + idx), rest(s))
              else
                return cons(x, keepi0((1 + idx), rest(s)))
              end
            else
              return nil
            end
          end
          return lazy_seq(_256_)
        end
        keepi = keepi0
        return keepi(1, coll)
      end
      local function remove(pred, coll)
        local function _260_(_241)
          return not pred(_241)
        end
        return filter(_260_, coll)
      end
      local function cycle(coll)
        local function _261_()
          return concat(seq(coll), cycle(coll))
        end
        return lazy_seq(_261_)
      end
      local function _repeat(x)
        local function step(x0)
          local function _262_()
            return cons(x0, step(x0))
          end
          return lazy_seq(_262_)
        end
        return step(x)
      end
      local function repeatedly(f, ...)
        local args = table_pack(...)
        local f0
        local function _263_()
          return f(table_unpack(args, 1, args.n))
        end
        f0 = _263_
        local function step(f1)
          local function _264_()
            return cons(f1(), step(f1))
          end
          return lazy_seq(_264_)
        end
        return step(f0)
      end
      local function iterate(f, x)
        local x_2a = f(x)
        local function _265_()
          return iterate(f, x_2a)
        end
        return cons(x, lazy_seq(_265_))
      end
      local function nthnext(coll, n)
        local function loop(n0, xs)
          local and_266_ = (nil ~= xs)
          if and_266_ then
            local xs_2a = xs
            and_266_ = (n0 > 0)
          end
          if and_266_ then
            local xs_2a = xs
            return loop((n0 - 1), next(xs_2a))
          else
            local _ = xs
            return xs
          end
        end
        return loop(n, seq(coll))
      end
      local function nthrest(coll, n)
        local function loop(n0, xs)
          local _269_ = seq(xs)
          local and_270_ = (nil ~= _269_)
          if and_270_ then
            local xs_2a = _269_
            and_270_ = (n0 > 0)
          end
          if and_270_ then
            local xs_2a = _269_
            return loop((n0 - 1), rest(xs_2a))
          else
            local _ = _269_
            return xs
          end
        end
        return loop(n, coll)
      end
      local function dorun(s)
        local _273_ = seq(s)
        if (nil ~= _273_) then
          local s_2a = _273_
          return dorun(next(s_2a))
        else
          local _ = _273_
          return nil
        end
      end
      local function doall(s)
        dorun(s)
        return s
      end
      local function partition(...)
        local _275_ = select("#", ...)
        if (_275_ == 2) then
          local n, coll = ...
          return partition(n, n, coll)
        elseif (_275_ == 3) then
          local n, step, coll = ...
          local function _276_()
            local _277_ = seq(coll)
            if (nil ~= _277_) then
              local s = _277_
              local p = take(n, s)
              if (n == length_2a(p)) then
                return cons(p, partition(n, step, nthrest(s, step)))
              else
                return nil
              end
            else
              local _ = _277_
              return nil
            end
          end
          return lazy_seq(_276_)
        elseif (_275_ == 4) then
          local n, step, pad, coll = ...
          local function _280_()
            local _281_ = seq(coll)
            if (nil ~= _281_) then
              local s = _281_
              local p = take(n, s)
              if (n == length_2a(p)) then
                return cons(p, partition(n, step, pad, nthrest(s, step)))
              else
                return list(take(n, concat(p, pad)))
              end
            else
              local _ = _281_
              return nil
            end
          end
          return lazy_seq(_280_)
        else
          local _ = _275_
          return error("wrong amount arguments to 'partition'")
        end
      end
      local function partition_by(f, coll)
        local function _285_()
          local _286_ = seq(coll)
          if (nil ~= _286_) then
            local s = _286_
            local v = first(s)
            local fv = f(v)
            local run
            local function _287_(_2410)
              return (fv == f(_2410))
            end
            run = cons(v, take_while(_287_, next(s)))
            local function _288_()
              return drop(length_2a(run), s)
            end
            return cons(run, partition_by(f, lazy_seq(_288_)))
          else
            return nil
          end
        end
        return lazy_seq(_285_)
      end
      local function partition_all(...)
        local _290_ = select("#", ...)
        if (_290_ == 2) then
          local n, coll = ...
          return partition_all(n, n, coll)
        elseif (_290_ == 3) then
          local n, step, coll = ...
          local function _291_()
            local _292_ = seq(coll)
            if (nil ~= _292_) then
              local s = _292_
              local p = take(n, s)
              return cons(p, partition_all(n, step, nthrest(s, step)))
            else
              local _ = _292_
              return nil
            end
          end
          return lazy_seq(_291_)
        else
          local _ = _290_
          return error("wrong amount arguments to 'partition-all'")
        end
      end
      local function reductions(...)
        local _295_ = select("#", ...)
        if (_295_ == 2) then
          local f, coll = ...
          local function _296_()
            local _297_ = seq(coll)
            if (nil ~= _297_) then
              local s = _297_
              return reductions(f, first(s), rest(s))
            else
              local _ = _297_
              return list(f())
            end
          end
          return lazy_seq(_296_)
        elseif (_295_ == 3) then
          local f, init, coll = ...
          local function _299_()
            local _300_ = seq(coll)
            if (nil ~= _300_) then
              local s = _300_
              return reductions(f, f(init, first(s)), rest(s))
            else
              return nil
            end
          end
          return cons(init, lazy_seq(_299_))
        else
          local _ = _295_
          return error("wrong amount arguments to 'reductions'")
        end
      end
      local function contains_3f(coll, elt)
        local _303_ = gettype(coll)
        if (_303_ == "table") then
          local _304_ = kind(coll)
          if (_304_ == "seq") then
            local res = false
            for _, v in ipairs_2a(coll) do
              if res then break end
              if (elt == v) then
                res = true
              else
                res = false
              end
            end
            return res
          elseif (_304_ == "assoc") then
            if coll[elt] then
              return true
            else
              return false
            end
          else
            return nil
          end
        else
          local _ = _303_
          local function loop(coll0)
            local _308_ = seq(coll0)
            if (nil ~= _308_) then
              local s = _308_
              if (elt == first(s)) then
                return true
              else
                return loop(rest(s))
              end
            elseif (_308_ == nil) then
              return false
            else
              return nil
            end
          end
          return loop(coll)
        end
      end
      local function distinct(coll)
        local function step(xs, seen)
          local loop
          local function loop0(_312_, seen0)
            local f = _312_[1]
            local xs0 = _312_
            local _313_ = seq(xs0)
            if (nil ~= _313_) then
              local s = _313_
              if seen0[f] then
                return loop0(rest(s), seen0)
              else
                local function _314_()
                  seen0[f] = true
                  return seen0
                end
                return cons(f, step(rest(s), _314_()))
              end
            else
              local _ = _313_
              return nil
            end
          end
          loop = loop0
          local function _317_()
            return loop(xs, seen)
          end
          return lazy_seq(_317_)
        end
        return step(coll, {})
      end
      local function inf_range(x, step)
        local function _318_()
          return cons(x, inf_range((x + step), step))
        end
        return lazy_seq(_318_)
      end
      local function fix_range(x, _end, step)
        local function _319_()
          if (((step >= 0) and (x < _end)) or ((step < 0) and (x > _end))) then
            return cons(x, fix_range((x + step), _end, step))
          elseif ((step == 0) and (x ~= _end)) then
            return cons(x, fix_range(x, _end, step))
          else
            return nil
          end
        end
        return lazy_seq(_319_)
      end
      local function range(...)
        local _321_ = select("#", ...)
        if (_321_ == 0) then
          return inf_range(0, 1)
        elseif (_321_ == 1) then
          local _end = ...
          return fix_range(0, _end, 1)
        elseif (_321_ == 2) then
          local x, _end = ...
          return fix_range(x, _end, 1)
        else
          local _ = _321_
          return fix_range(...)
        end
      end
      local function realized_3f(s)
        local _323_ = gettype(s)
        if (_323_ == "lazy-cons") then
          return false
        elseif (_323_ == "empty-cons") then
          return true
        elseif (_323_ == "cons") then
          return true
        else
          local _ = _323_
          return error(("expected a sequence, got: %s"):format(_))
        end
      end
      local function line_seq(file)
        local next_line = file:lines()
        local function step(f)
          local line = f()
          if ("string" == type(line)) then
            local function _325_()
              return step(f)
            end
            return cons(line, lazy_seq(_325_))
          else
            return nil
          end
        end
        return step(next_line)
      end
      local function tree_seq(branch_3f, children, root)
        local function walk(node)
          local function _327_()
            local function _328_()
              if branch_3f(node) then
                return mapcat(walk, children(node))
              else
                return nil
              end
            end
            return cons(node, _328_())
          end
          return lazy_seq(_327_)
        end
        return walk(root)
      end
      local function interleave(...)
        local _329_, _330_, _331_ = select("#", ...), ...
        if (_329_ == 0) then
          return empty_cons
        elseif ((_329_ == 1) and true) then
          local _3fs = _330_
          local function _332_()
            return _3fs
          end
          return lazy_seq(_332_)
        elseif ((_329_ == 2) and true and true) then
          local _3fs1 = _330_
          local _3fs2 = _331_
          local function _333_()
            local s1 = seq(_3fs1)
            local s2 = seq(_3fs2)
            if (s1 and s2) then
              return cons(first(s1), cons(first(s2), interleave(rest(s1), rest(s2))))
            else
              return nil
            end
          end
          return lazy_seq(_333_)
        elseif true then
          local _ = _329_
          local cols = list(...)
          local function _335_()
            local seqs = map(seq, cols)
            local function _336_(_2410)
              return (nil ~= seq(_2410))
            end
            if every_3f(_336_, seqs) then
              return concat(map(first, seqs), interleave(unpack(map(rest, seqs))))
            else
              return nil
            end
          end
          return lazy_seq(_335_)
        else
          return nil
        end
      end
      local function interpose(separator, coll)
        return drop(1, interleave(_repeat(separator), coll))
      end
      local function keys(t)
        assert(("assoc" == kind(t)), "expected an associative table")
        local function _339_(_241)
          return _241[1]
        end
        return map(_339_, t)
      end
      local function vals(t)
        assert(("assoc" == kind(t)), "expected an associative table")
        local function _340_(_241)
          return _241[2]
        end
        return map(_340_, t)
      end
      local function zipmap(keys0, vals0)
        local t = {}
        local function loop(s1, s2)
          if (s1 and s2) then
            t[first(s1)] = first(s2)
            return loop(next(s1), next(s2))
          else
            return nil
          end
        end
        loop(seq(keys0), seq(vals0))
        return t
      end
      local _local_342_ = require("reduced")
      local reduced = _local_342_["reduced"]
      local reduced_3f = _local_342_["reduced?"]
      local function reduce(f, ...)
        local _343_, _344_, _345_ = select("#", ...), ...
        if (_343_ == 0) then
          return error("expected a collection")
        elseif ((_343_ == 1) and true) then
          local _3fcoll = _344_
          local _346_ = count(_3fcoll)
          if (_346_ == 0) then
            return f()
          elseif (_346_ == 1) then
            return first(_3fcoll)
          else
            local _ = _346_
            return reduce(f, first(_3fcoll), rest(_3fcoll))
          end
        elseif ((_343_ == 2) and true and true) then
          local _3fval = _344_
          local _3fcoll = _345_
          local _348_ = seq(_3fcoll)
          if (nil ~= _348_) then
            local coll = _348_
            local done_3f = false
            local res = _3fval
            for _, v in pairs_2a(coll) do
              if done_3f then break end
              local res0 = f(res, v)
              if reduced_3f(res0) then
                done_3f = true
                res = res0:unbox()
              else
                res = res0
              end
            end
            return res
          else
            local _ = _348_
            return _3fval
          end
        else
          return nil
        end
      end
      return {first = first, rest = rest, nthrest = nthrest, next = next, nthnext = nthnext, cons = cons, seq = seq, rseq = rseq, ["seq?"] = seq_3f, ["empty?"] = empty_3f, ["lazy-seq"] = lazy_seq, list = list, ["list*"] = list_2a, ["every?"] = every_3f, ["some?"] = some_3f, pack = pack, unpack = unpack, count = count, concat = concat, map = map, ["map-indexed"] = map_indexed, mapcat = mapcat, take = take, ["take-while"] = take_while, ["take-last"] = take_last, ["take-nth"] = take_nth, drop = drop, ["drop-while"] = drop_while, ["drop-last"] = drop_last, remove = remove, ["split-at"] = split_at, ["split-with"] = split_with, partition = partition, ["partition-by"] = partition_by, ["partition-all"] = partition_all, filter = filter, keep = keep, ["keep-indexed"] = keep_indexed, ["contains?"] = contains_3f, distinct = distinct, cycle = cycle, ["repeat"] = _repeat, repeatedly = repeatedly, reductions = reductions, iterate = iterate, range = range, ["realized?"] = realized_3f, dorun = dorun, doall = doall, ["line-seq"] = line_seq, ["tree-seq"] = tree_seq, reverse = reverse, interleave = interleave, interpose = interpose, keys = keys, vals = vals, zipmap = zipmap, reduce = reduce, reduced = reduced, ["reduced?"] = reduced_3f}
    end
    or_105_ = _106_
  end
  package.preload["lazy-seq"] = or_105_
  local function _352_()
    return "#<namespace: core>"
  end
  --[[ "MIT License
  
  Copyright (c) 2022 Andrey Listopadov
  
  Permission is hereby granted‚ free of charge‚ to any person obtaining a copy
  of this software and associated documentation files (the “Software”)‚ to deal
  in the Software without restriction‚ including without limitation the rights
  to use‚ copy‚ modify‚ merge‚ publish‚ distribute‚ sublicense‚ and/or sell
  copies of the Software‚ and to permit persons to whom the Software is
  furnished to do so‚ subject to the following conditions：
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED “AS IS”‚ WITHOUT WARRANTY OF ANY KIND‚ EXPRESS OR
  IMPLIED‚ INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY‚
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM‚ DAMAGES OR OTHER
  LIABILITY‚ WHETHER IN AN ACTION OF CONTRACT‚ TORT OR OTHERWISE‚ ARISING FROM‚
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE." ]]
  local _local_353_ = {setmetatable({}, {__fennelview = _352_, __name = "namespace"}), require("lazy-seq"), require("itable")}, nil
  local core = _local_353_[1]
  local lazy = _local_353_[2]
  local itable = _local_353_[3]
  local function unpack_2a(x, ...)
    if core["seq?"](x) then
      return lazy.unpack(x)
    else
      return itable.unpack(x, ...)
    end
  end
  local function pack_2a(...)
    local tmp_9_auto = {...}
    tmp_9_auto["n"] = select("#", ...)
    return tmp_9_auto
  end
  local function pairs_2a(t)
    local _355_ = getmetatable(t)
    if ((_G.type(_355_) == "table") and (nil ~= _355_.__pairs)) then
      local p = _355_.__pairs
      return p(t)
    else
      local _ = _355_
      return pairs(t)
    end
  end
  local function ipairs_2a(t)
    local _357_ = getmetatable(t)
    if ((_G.type(_357_) == "table") and (nil ~= _357_.__ipairs)) then
      local i = _357_.__ipairs
      return i(t)
    else
      local _ = _357_
      return ipairs(t)
    end
  end
  local function length_2a(t)
    local _359_ = getmetatable(t)
    if ((_G.type(_359_) == "table") and (nil ~= _359_.__len)) then
      local l = _359_.__len
      return l(t)
    else
      local _ = _359_
      return #t
    end
  end
  local apply
  do
    local v_27_auto
    local function apply0(...)
      local _362_ = select("#", ...)
      if (_362_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "apply"))
      elseif (_362_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "apply"))
      elseif (_362_ == 2) then
        local f, args = ...
        return f(unpack_2a(args))
      elseif (_362_ == 3) then
        local f, a, args = ...
        return f(a, unpack_2a(args))
      elseif (_362_ == 4) then
        local f, a, b, args = ...
        return f(a, b, unpack_2a(args))
      elseif (_362_ == 5) then
        local f, a, b, c, args = ...
        return f(a, b, c, unpack_2a(args))
      else
        local _ = _362_
        local core_38_auto = require("cljlib")
        local _let_363_ = core_38_auto.list(...)
        local f = _let_363_[1]
        local a = _let_363_[2]
        local b = _let_363_[3]
        local c = _let_363_[4]
        local d = _let_363_[5]
        local args = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_363_, 6)
        local flat_args = {}
        local len = (length_2a(args) - 1)
        for i = 1, len do
          flat_args[i] = args[i]
        end
        for i, a0 in pairs_2a(args[(len + 1)]) do
          flat_args[(i + len)] = a0
        end
        return f(a, b, c, d, unpack_2a(flat_args))
      end
    end
    v_27_auto = apply0
    core["apply"] = v_27_auto
    apply = v_27_auto
  end
  local add
  do
    local v_27_auto
    local function add0(...)
      local _365_ = select("#", ...)
      if (_365_ == 0) then
        return 0
      elseif (_365_ == 1) then
        local a = ...
        return a
      elseif (_365_ == 2) then
        local a, b = ...
        return (a + b)
      elseif (_365_ == 3) then
        local a, b, c = ...
        return (a + b + c)
      elseif (_365_ == 4) then
        local a, b, c, d = ...
        return (a + b + c + d)
      else
        local _ = _365_
        local core_38_auto = require("cljlib")
        local _let_366_ = core_38_auto.list(...)
        local a = _let_366_[1]
        local b = _let_366_[2]
        local c = _let_366_[3]
        local d = _let_366_[4]
        local rest = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_366_, 5)
        return apply(add0, (a + b + c + d), rest)
      end
    end
    v_27_auto = add0
    core["add"] = v_27_auto
    add = v_27_auto
  end
  local sub
  do
    local v_27_auto
    local function sub0(...)
      local _368_ = select("#", ...)
      if (_368_ == 0) then
        return 0
      elseif (_368_ == 1) then
        local a = ...
        return ( - a)
      elseif (_368_ == 2) then
        local a, b = ...
        return (a - b)
      elseif (_368_ == 3) then
        local a, b, c = ...
        return (a - b - c)
      elseif (_368_ == 4) then
        local a, b, c, d = ...
        return (a - b - c - d)
      else
        local _ = _368_
        local core_38_auto = require("cljlib")
        local _let_369_ = core_38_auto.list(...)
        local a = _let_369_[1]
        local b = _let_369_[2]
        local c = _let_369_[3]
        local d = _let_369_[4]
        local rest = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_369_, 5)
        return apply(sub0, (a - b - c - d), rest)
      end
    end
    v_27_auto = sub0
    core["sub"] = v_27_auto
    sub = v_27_auto
  end
  local mul
  do
    local v_27_auto
    local function mul0(...)
      local _371_ = select("#", ...)
      if (_371_ == 0) then
        return 1
      elseif (_371_ == 1) then
        local a = ...
        return a
      elseif (_371_ == 2) then
        local a, b = ...
        return (a * b)
      elseif (_371_ == 3) then
        local a, b, c = ...
        return (a * b * c)
      elseif (_371_ == 4) then
        local a, b, c, d = ...
        return (a * b * c * d)
      else
        local _ = _371_
        local core_38_auto = require("cljlib")
        local _let_372_ = core_38_auto.list(...)
        local a = _let_372_[1]
        local b = _let_372_[2]
        local c = _let_372_[3]
        local d = _let_372_[4]
        local rest = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_372_, 5)
        return apply(mul0, (a * b * c * d), rest)
      end
    end
    v_27_auto = mul0
    core["mul"] = v_27_auto
    mul = v_27_auto
  end
  local div
  do
    local v_27_auto
    local function div0(...)
      local _374_ = select("#", ...)
      if (_374_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "div"))
      elseif (_374_ == 1) then
        local a = ...
        return (1 / a)
      elseif (_374_ == 2) then
        local a, b = ...
        return (a / b)
      elseif (_374_ == 3) then
        local a, b, c = ...
        return (a / b / c)
      elseif (_374_ == 4) then
        local a, b, c, d = ...
        return (a / b / c / d)
      else
        local _ = _374_
        local core_38_auto = require("cljlib")
        local _let_375_ = core_38_auto.list(...)
        local a = _let_375_[1]
        local b = _let_375_[2]
        local c = _let_375_[3]
        local d = _let_375_[4]
        local rest = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_375_, 5)
        return apply(div0, (a / b / c / d), rest)
      end
    end
    v_27_auto = div0
    core["div"] = v_27_auto
    div = v_27_auto
  end
  local le
  do
    local v_27_auto
    local function le0(...)
      local _377_ = select("#", ...)
      if (_377_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "le"))
      elseif (_377_ == 1) then
        local a = ...
        return true
      elseif (_377_ == 2) then
        local a, b = ...
        return (a <= b)
      else
        local _ = _377_
        local core_38_auto = require("cljlib")
        local _let_378_ = core_38_auto.list(...)
        local a = _let_378_[1]
        local b = _let_378_[2]
        local _let_379_ = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_378_, 3)
        local c = _let_379_[1]
        local d = _let_379_[2]
        local more = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_379_, 3)
        if (a <= b) then
          if d then
            return apply(le0, b, c, d, more)
          else
            return (b <= c)
          end
        else
          return false
        end
      end
    end
    v_27_auto = le0
    core["le"] = v_27_auto
    le = v_27_auto
  end
  local lt
  do
    local v_27_auto
    local function lt0(...)
      local _383_ = select("#", ...)
      if (_383_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "lt"))
      elseif (_383_ == 1) then
        local a = ...
        return true
      elseif (_383_ == 2) then
        local a, b = ...
        return (a < b)
      else
        local _ = _383_
        local core_38_auto = require("cljlib")
        local _let_384_ = core_38_auto.list(...)
        local a = _let_384_[1]
        local b = _let_384_[2]
        local _let_385_ = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_384_, 3)
        local c = _let_385_[1]
        local d = _let_385_[2]
        local more = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_385_, 3)
        if (a < b) then
          if d then
            return apply(lt0, b, c, d, more)
          else
            return (b < c)
          end
        else
          return false
        end
      end
    end
    v_27_auto = lt0
    core["lt"] = v_27_auto
    lt = v_27_auto
  end
  local ge
  do
    local v_27_auto
    local function ge0(...)
      local _389_ = select("#", ...)
      if (_389_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "ge"))
      elseif (_389_ == 1) then
        local a = ...
        return true
      elseif (_389_ == 2) then
        local a, b = ...
        return (a >= b)
      else
        local _ = _389_
        local core_38_auto = require("cljlib")
        local _let_390_ = core_38_auto.list(...)
        local a = _let_390_[1]
        local b = _let_390_[2]
        local _let_391_ = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_390_, 3)
        local c = _let_391_[1]
        local d = _let_391_[2]
        local more = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_391_, 3)
        if (a >= b) then
          if d then
            return apply(ge0, b, c, d, more)
          else
            return (b >= c)
          end
        else
          return false
        end
      end
    end
    v_27_auto = ge0
    core["ge"] = v_27_auto
    ge = v_27_auto
  end
  local gt
  do
    local v_27_auto
    local function gt0(...)
      local _395_ = select("#", ...)
      if (_395_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "gt"))
      elseif (_395_ == 1) then
        local a = ...
        return true
      elseif (_395_ == 2) then
        local a, b = ...
        return (a > b)
      else
        local _ = _395_
        local core_38_auto = require("cljlib")
        local _let_396_ = core_38_auto.list(...)
        local a = _let_396_[1]
        local b = _let_396_[2]
        local _let_397_ = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_396_, 3)
        local c = _let_397_[1]
        local d = _let_397_[2]
        local more = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_397_, 3)
        if (a > b) then
          if d then
            return apply(gt0, b, c, d, more)
          else
            return (b > c)
          end
        else
          return false
        end
      end
    end
    v_27_auto = gt0
    core["gt"] = v_27_auto
    gt = v_27_auto
  end
  local inc
  do
    local v_27_auto
    local function inc0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "inc"))
        else
        end
      end
      return (x + 1)
    end
    v_27_auto = inc0
    core["inc"] = v_27_auto
    inc = v_27_auto
  end
  local dec
  do
    local v_27_auto
    local function dec0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "dec"))
        else
        end
      end
      return (x - 1)
    end
    v_27_auto = dec0
    core["dec"] = v_27_auto
    dec = v_27_auto
  end
  local class
  do
    local v_27_auto
    local function class0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "class"))
        else
        end
      end
      local _404_ = type(x)
      if (_404_ == "table") then
        local _405_ = getmetatable(x)
        if ((_G.type(_405_) == "table") and (nil ~= _405_["cljlib/type"])) then
          local t = _405_["cljlib/type"]
          return t
        else
          local _ = _405_
          return "table"
        end
      elseif (nil ~= _404_) then
        local t = _404_
        return t
      else
        return nil
      end
    end
    v_27_auto = class0
    core["class"] = v_27_auto
    class = v_27_auto
  end
  local constantly
  do
    local v_27_auto
    local function constantly0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "constantly"))
        else
        end
      end
      local function _409_()
        return x
      end
      return _409_
    end
    v_27_auto = constantly0
    core["constantly"] = v_27_auto
    constantly = v_27_auto
  end
  local complement
  do
    local v_27_auto
    local function complement0(...)
      local f = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "complement"))
        else
        end
      end
      local function fn_411_(...)
        local _412_ = select("#", ...)
        if (_412_ == 0) then
          return not f()
        elseif (_412_ == 1) then
          local a = ...
          return not f(a)
        elseif (_412_ == 2) then
          local a, b = ...
          return not f(a, b)
        else
          local _ = _412_
          local core_38_auto = require("cljlib")
          local _let_413_ = core_38_auto.list(...)
          local a = _let_413_[1]
          local b = _let_413_[2]
          local cs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_413_, 3)
          return not apply(f, a, b, cs)
        end
      end
      return fn_411_
    end
    v_27_auto = complement0
    core["complement"] = v_27_auto
    complement = v_27_auto
  end
  local identity
  do
    local v_27_auto
    local function identity0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "identity"))
        else
        end
      end
      return x
    end
    v_27_auto = identity0
    core["identity"] = v_27_auto
    identity = v_27_auto
  end
  local comp
  do
    local v_27_auto
    local function comp0(...)
      local _416_ = select("#", ...)
      if (_416_ == 0) then
        return identity
      elseif (_416_ == 1) then
        local f = ...
        return f
      elseif (_416_ == 2) then
        local f, g = ...
        local function fn_417_(...)
          local _418_ = select("#", ...)
          if (_418_ == 0) then
            return f(g())
          elseif (_418_ == 1) then
            local x = ...
            return f(g(x))
          elseif (_418_ == 2) then
            local x, y = ...
            return f(g(x, y))
          elseif (_418_ == 3) then
            local x, y, z = ...
            return f(g(x, y, z))
          else
            local _ = _418_
            local core_38_auto = require("cljlib")
            local _let_419_ = core_38_auto.list(...)
            local x = _let_419_[1]
            local y = _let_419_[2]
            local z = _let_419_[3]
            local args = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_419_, 4)
            return f(apply(g, x, y, z, args))
          end
        end
        return fn_417_
      else
        local _ = _416_
        local core_38_auto = require("cljlib")
        local _let_421_ = core_38_auto.list(...)
        local f = _let_421_[1]
        local g = _let_421_[2]
        local fs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_421_, 3)
        return core.reduce(comp0, core.cons(f, core.cons(g, fs)))
      end
    end
    v_27_auto = comp0
    core["comp"] = v_27_auto
    comp = v_27_auto
  end
  local eq
  do
    local v_27_auto
    local function eq0(...)
      local _423_ = select("#", ...)
      if (_423_ == 0) then
        return true
      elseif (_423_ == 1) then
        local _ = ...
        return true
      elseif (_423_ == 2) then
        local a, b = ...
        if ((a == b) and (b == a)) then
          return true
        else
          local _424_ = type(a)
          if (("table" == _424_) and (_424_ == type(b))) then
            local res, count_a = true, 0
            for k, v in pairs_2a(a) do
              if not res then break end
              local function _425_(...)
                local res0, done = nil, nil
                for k_2a, v0 in pairs_2a(b) do
                  if done then break end
                  if eq0(k_2a, k) then
                    res0, done = v0, true
                  else
                  end
                end
                return res0
              end
              res = eq0(v, _425_(...))
              count_a = (count_a + 1)
            end
            if res then
              local count_b
              do
                local res0 = 0
                for _, _0 in pairs_2a(b) do
                  res0 = (res0 + 1)
                end
                count_b = res0
              end
              res = (count_a == count_b)
            else
            end
            return res
          else
            return false
          end
        end
      else
        local _ = _423_
        local core_38_auto = require("cljlib")
        local _let_429_ = core_38_auto.list(...)
        local a = _let_429_[1]
        local b = _let_429_[2]
        local cs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_429_, 3)
        return (eq0(a, b) and apply(eq0, b, cs))
      end
    end
    v_27_auto = eq0
    core["eq"] = v_27_auto
    eq = v_27_auto
  end
  local function deep_index(tbl, key)
    local res = nil
    for k, v in pairs_2a(tbl) do
      if res then break end
      if eq(k, key) then
        res = v
      else
        res = nil
      end
    end
    return res
  end
  local function deep_newindex(tbl, key, val)
    local done = false
    if ("table" == type(key)) then
      for k, _ in pairs_2a(tbl) do
        if done then break end
        if eq(k, key) then
          rawset(tbl, k, val)
          done = true
        else
        end
      end
    else
    end
    if not done then
      return rawset(tbl, key, val)
    else
      return nil
    end
  end
  local memoize
  do
    local v_27_auto
    local function memoize0(...)
      local f = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "memoize"))
        else
        end
      end
      local memo = setmetatable({}, {__index = deep_index})
      local function fn_436_(...)
        local core_38_auto = require("cljlib")
        local _let_437_ = core_38_auto.list(...)
        local args = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_437_, 1)
        local _438_ = memo[args]
        if (nil ~= _438_) then
          local res = _438_
          return unpack_2a(res, 1, res.n)
        else
          local _ = _438_
          local res = pack_2a(f(...))
          memo[args] = res
          return unpack_2a(res, 1, res.n)
        end
      end
      return fn_436_
    end
    v_27_auto = memoize0
    core["memoize"] = v_27_auto
    memoize = v_27_auto
  end
  local deref
  do
    local v_27_auto
    local function deref0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "deref"))
        else
        end
      end
      local _441_ = getmetatable(x)
      if ((_G.type(_441_) == "table") and (nil ~= _441_["cljlib/deref"])) then
        local f = _441_["cljlib/deref"]
        return f(x)
      else
        local _ = _441_
        return error("object doesn't implement cljlib/deref metamethod", 2)
      end
    end
    v_27_auto = deref0
    core["deref"] = v_27_auto
    deref = v_27_auto
  end
  local empty
  do
    local v_27_auto
    local function empty0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "empty"))
        else
        end
      end
      local _444_ = getmetatable(x)
      if ((_G.type(_444_) == "table") and (nil ~= _444_["cljlib/empty"])) then
        local f = _444_["cljlib/empty"]
        return f()
      else
        local _ = _444_
        local _445_ = type(x)
        if (_445_ == "table") then
          return {}
        elseif (_445_ == "string") then
          return ""
        else
          local _0 = _445_
          return error(("don't know how to create empty variant of type " .. _0))
        end
      end
    end
    v_27_auto = empty0
    core["empty"] = v_27_auto
    empty = v_27_auto
  end
  local nil_3f
  do
    local v_27_auto
    local function nil_3f0(...)
      local _448_ = select("#", ...)
      if (_448_ == 0) then
        return true
      elseif (_448_ == 1) then
        local x = ...
        return (x == nil)
      else
        local _ = _448_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "nil?"))
      end
    end
    v_27_auto = nil_3f0
    core["nil?"] = v_27_auto
    nil_3f = v_27_auto
  end
  local zero_3f
  do
    local v_27_auto
    local function zero_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "zero?"))
        else
        end
      end
      return (x == 0)
    end
    v_27_auto = zero_3f0
    core["zero?"] = v_27_auto
    zero_3f = v_27_auto
  end
  local pos_3f
  do
    local v_27_auto
    local function pos_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "pos?"))
        else
        end
      end
      return (x > 0)
    end
    v_27_auto = pos_3f0
    core["pos?"] = v_27_auto
    pos_3f = v_27_auto
  end
  local neg_3f
  do
    local v_27_auto
    local function neg_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "neg?"))
        else
        end
      end
      return (x < 0)
    end
    v_27_auto = neg_3f0
    core["neg?"] = v_27_auto
    neg_3f = v_27_auto
  end
  local even_3f
  do
    local v_27_auto
    local function even_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "even?"))
        else
        end
      end
      return ((x % 2) == 0)
    end
    v_27_auto = even_3f0
    core["even?"] = v_27_auto
    even_3f = v_27_auto
  end
  local odd_3f
  do
    local v_27_auto
    local function odd_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "odd?"))
        else
        end
      end
      return not even_3f(x)
    end
    v_27_auto = odd_3f0
    core["odd?"] = v_27_auto
    odd_3f = v_27_auto
  end
  local string_3f
  do
    local v_27_auto
    local function string_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "string?"))
        else
        end
      end
      return (type(x) == "string")
    end
    v_27_auto = string_3f0
    core["string?"] = v_27_auto
    string_3f = v_27_auto
  end
  local boolean_3f
  do
    local v_27_auto
    local function boolean_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "boolean?"))
        else
        end
      end
      return (type(x) == "boolean")
    end
    v_27_auto = boolean_3f0
    core["boolean?"] = v_27_auto
    boolean_3f = v_27_auto
  end
  local true_3f
  do
    local v_27_auto
    local function true_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "true?"))
        else
        end
      end
      return (x == true)
    end
    v_27_auto = true_3f0
    core["true?"] = v_27_auto
    true_3f = v_27_auto
  end
  local false_3f
  do
    local v_27_auto
    local function false_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "false?"))
        else
        end
      end
      return (x == false)
    end
    v_27_auto = false_3f0
    core["false?"] = v_27_auto
    false_3f = v_27_auto
  end
  local int_3f
  do
    local v_27_auto
    local function int_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "int?"))
        else
        end
      end
      return ((type(x) == "number") and (x == math.floor(x)))
    end
    v_27_auto = int_3f0
    core["int?"] = v_27_auto
    int_3f = v_27_auto
  end
  local pos_int_3f
  do
    local v_27_auto
    local function pos_int_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "pos-int?"))
        else
        end
      end
      return (int_3f(x) and pos_3f(x))
    end
    v_27_auto = pos_int_3f0
    core["pos-int?"] = v_27_auto
    pos_int_3f = v_27_auto
  end
  local neg_int_3f
  do
    local v_27_auto
    local function neg_int_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "neg-int?"))
        else
        end
      end
      return (int_3f(x) and neg_3f(x))
    end
    v_27_auto = neg_int_3f0
    core["neg-int?"] = v_27_auto
    neg_int_3f = v_27_auto
  end
  local double_3f
  do
    local v_27_auto
    local function double_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "double?"))
        else
        end
      end
      return ((type(x) == "number") and (x ~= math.floor(x)))
    end
    v_27_auto = double_3f0
    core["double?"] = v_27_auto
    double_3f = v_27_auto
  end
  local empty_3f
  do
    local v_27_auto
    local function empty_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "empty?"))
        else
        end
      end
      local _464_ = type(x)
      if (_464_ == "table") then
        local _465_ = getmetatable(x)
        if ((_G.type(_465_) == "table") and (_465_["cljlib/type"] == "seq")) then
          return nil_3f(core.seq(x))
        elseif ((_465_ == nil) or ((_G.type(_465_) == "table") and (_465_["cljlib/type"] == nil))) then
          local next_2a = pairs_2a(x)
          return (next_2a(x) == nil)
        else
          return nil
        end
      elseif (_464_ == "string") then
        return (x == "")
      elseif (_464_ == "nil") then
        return true
      else
        local _ = _464_
        return error("empty?: unsupported collection")
      end
    end
    v_27_auto = empty_3f0
    core["empty?"] = v_27_auto
    empty_3f = v_27_auto
  end
  local not_empty
  do
    local v_27_auto
    local function not_empty0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "not-empty"))
        else
        end
      end
      if not empty_3f(x) then
        return x
      else
        return nil
      end
    end
    v_27_auto = not_empty0
    core["not-empty"] = v_27_auto
    not_empty = v_27_auto
  end
  local map_3f
  do
    local v_27_auto
    local function map_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "map?"))
        else
        end
      end
      if ("table" == type(x)) then
        local _471_ = getmetatable(x)
        if ((_G.type(_471_) == "table") and (_471_["cljlib/type"] == "hash-map")) then
          return true
        elseif ((_G.type(_471_) == "table") and (_471_["cljlib/type"] == "sorted-map")) then
          return true
        elseif ((_471_ == nil) or ((_G.type(_471_) == "table") and (_471_["cljlib/type"] == nil))) then
          local len = length_2a(x)
          local nxt, t, k = pairs_2a(x)
          local function _472_(...)
            if (len == 0) then
              return k
            else
              return len
            end
          end
          return (nil ~= nxt(t, _472_(...)))
        else
          local _ = _471_
          return false
        end
      else
        return false
      end
    end
    v_27_auto = map_3f0
    core["map?"] = v_27_auto
    map_3f = v_27_auto
  end
  local vector_3f
  do
    local v_27_auto
    local function vector_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "vector?"))
        else
        end
      end
      if ("table" == type(x)) then
        local _476_ = getmetatable(x)
        if ((_G.type(_476_) == "table") and (_476_["cljlib/type"] == "vector")) then
          return true
        elseif ((_476_ == nil) or ((_G.type(_476_) == "table") and (_476_["cljlib/type"] == nil))) then
          local len = length_2a(x)
          local nxt, t, k = pairs_2a(x)
          local function _477_(...)
            if (len == 0) then
              return k
            else
              return len
            end
          end
          if (nil ~= nxt(t, _477_(...))) then
            return false
          elseif (len > 0) then
            return true
          else
            return false
          end
        else
          local _ = _476_
          return false
        end
      else
        return false
      end
    end
    v_27_auto = vector_3f0
    core["vector?"] = v_27_auto
    vector_3f = v_27_auto
  end
  local set_3f
  do
    local v_27_auto
    local function set_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "set?"))
        else
        end
      end
      local _482_ = getmetatable(x)
      if ((_G.type(_482_) == "table") and (_482_["cljlib/type"] == "hash-set")) then
        return true
      else
        local _ = _482_
        return false
      end
    end
    v_27_auto = set_3f0
    core["set?"] = v_27_auto
    set_3f = v_27_auto
  end
  local seq_3f
  do
    local v_27_auto
    local function seq_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "seq?"))
        else
        end
      end
      return lazy["seq?"](x)
    end
    v_27_auto = seq_3f0
    core["seq?"] = v_27_auto
    seq_3f = v_27_auto
  end
  local some_3f
  do
    local v_27_auto
    local function some_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "some?"))
        else
        end
      end
      return (x ~= nil)
    end
    v_27_auto = some_3f0
    core["some?"] = v_27_auto
    some_3f = v_27_auto
  end
  local function vec__3etransient(immutable)
    local function _486_(vec)
      local len = #vec
      local function _487_(_, i)
        if (i <= len) then
          return vec[i]
        else
          return nil
        end
      end
      local function _489_()
        return len
      end
      local function _490_()
        return error("can't `conj` onto transient vector, use `conj!`")
      end
      local function _491_()
        return error("can't `assoc` onto transient vector, use `assoc!`")
      end
      local function _492_()
        return error("can't `dissoc` onto transient vector, use `dissoc!`")
      end
      local function _493_(tvec, v)
        len = (len + 1)
        tvec[len] = v
        return tvec
      end
      local function _494_(tvec, ...)
        do
          local len0 = #tvec
          for i = 1, select("#", ...), 2 do
            local k, v = select(i, ...)
            if ((1 <= i) and (i <= len0)) then
              tvec[i] = v
            else
              error(("index " .. i .. " is out of bounds"))
            end
          end
        end
        return tvec
      end
      local function _496_(tvec)
        if (len == 0) then
          return error("transient vector is empty", 2)
        else
          local val = table.remove(tvec)
          len = (len - 1)
          return tvec
        end
      end
      local function _498_()
        return error("can't `dissoc!` with a transient vector")
      end
      local function _499_(tvec)
        local v
        do
          local tbl_21_auto = {}
          local i_22_auto = 0
          for i = 1, len do
            local val_23_auto = tvec[i]
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          v = tbl_21_auto
        end
        while (len > 0) do
          table.remove(tvec)
          len = (len - 1)
        end
        local function _501_()
          return error("attempt to use transient after it was persistet")
        end
        local function _502_()
          return error("attempt to use transient after it was persistet")
        end
        setmetatable(tvec, {__index = _501_, __newindex = _502_})
        return immutable(itable(v))
      end
      return setmetatable({}, {__index = _487_, __len = _489_, ["cljlib/type"] = "transient", ["cljlib/conj"] = _490_, ["cljlib/assoc"] = _491_, ["cljlib/dissoc"] = _492_, ["cljlib/conj!"] = _493_, ["cljlib/assoc!"] = _494_, ["cljlib/pop!"] = _496_, ["cljlib/dissoc!"] = _498_, ["cljlib/persistent!"] = _499_})
    end
    return _486_
  end
  local function vec_2a(v, len)
    do
      local _503_ = getmetatable(v)
      if (nil ~= _503_) then
        local mt = _503_
        mt["__len"] = constantly((len or length_2a(v)))
        mt["cljlib/type"] = "vector"
        mt["cljlib/editable"] = true
        local function _504_(t, v0)
          local len0 = length_2a(t)
          return vec_2a(itable.assoc(t, (len0 + 1), v0), (len0 + 1))
        end
        mt["cljlib/conj"] = _504_
        local function _505_(t)
          local len0 = (length_2a(t) - 1)
          local coll = {}
          if (len0 < 0) then
            error("can't pop empty vector", 2)
          else
          end
          for i = 1, len0 do
            coll[i] = t[i]
          end
          return vec_2a(itable(coll), len0)
        end
        mt["cljlib/pop"] = _505_
        local function _507_()
          return vec_2a(itable({}))
        end
        mt["cljlib/empty"] = _507_
        mt["cljlib/transient"] = vec__3etransient(vec_2a)
        local function _508_(coll, view, inspector, indent)
          if empty_3f(coll) then
            return "[]"
          else
            local lines
            do
              local tbl_21_auto = {}
              local i_22_auto = 0
              for i = 1, length_2a(coll) do
                local val_23_auto = (" " .. view(coll[i], inspector, indent))
                if (nil ~= val_23_auto) then
                  i_22_auto = (i_22_auto + 1)
                  tbl_21_auto[i_22_auto] = val_23_auto
                else
                end
              end
              lines = tbl_21_auto
            end
            lines[1] = ("[" .. string.gsub((lines[1] or ""), "^%s+", ""))
            lines[#lines] = (lines[#lines] .. "]")
            return lines
          end
        end
        mt["__fennelview"] = _508_
      elseif (_503_ == nil) then
        vec_2a(setmetatable(v, {}))
      else
      end
    end
    return v
  end
  local vec
  do
    local v_27_auto
    local function vec0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "vec"))
        else
        end
      end
      if empty_3f(coll) then
        return vec_2a(itable({}), 0)
      elseif vector_3f(coll) then
        return vec_2a(itable(coll), length_2a(coll))
      elseif "else" then
        local packed = lazy.pack(core.seq(coll))
        local len = packed.n
        local _513_
        do
          packed["n"] = nil
          _513_ = packed
        end
        return vec_2a(itable(_513_, {["fast-index?"] = true}), len)
      else
        return nil
      end
    end
    v_27_auto = vec0
    core["vec"] = v_27_auto
    vec = v_27_auto
  end
  local vector
  do
    local v_27_auto
    local function vector0(...)
      local core_38_auto = require("cljlib")
      local _let_515_ = core_38_auto.list(...)
      local args = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_515_, 1)
      return vec(args)
    end
    v_27_auto = vector0
    core["vector"] = v_27_auto
    vector = v_27_auto
  end
  local nth
  do
    local v_27_auto
    local function nth0(...)
      local _517_ = select("#", ...)
      if (_517_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "nth"))
      elseif (_517_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "nth"))
      elseif (_517_ == 2) then
        local coll, i = ...
        if vector_3f(coll) then
          if ((i < 1) or (length_2a(coll) < i)) then
            return error(string.format("index %d is out of bounds", i))
          else
            return coll[i]
          end
        elseif string_3f(coll) then
          return nth0(vec(coll), i)
        elseif seq_3f(coll) then
          return nth0(vec(coll), i)
        elseif "else" then
          return error("expected an indexed collection")
        else
          return nil
        end
      elseif (_517_ == 3) then
        local coll, i, not_found = ...
        assert(int_3f(i), "expected an integer key")
        if vector_3f(coll) then
          return (coll[i] or not_found)
        elseif string_3f(coll) then
          return nth0(vec(coll), i, not_found)
        elseif seq_3f(coll) then
          return nth0(vec(coll), i, not_found)
        elseif "else" then
          return error("expected an indexed collection")
        else
          return nil
        end
      else
        local _ = _517_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "nth"))
      end
    end
    v_27_auto = nth0
    core["nth"] = v_27_auto
    nth = v_27_auto
  end
  local seq_2a
  local function seq_2a0(...)
    local x = ...
    do
      local cnt_54_auto = select("#", ...)
      if (1 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "seq*"))
      else
      end
    end
    do
      local _523_ = getmetatable(x)
      if (nil ~= _523_) then
        local mt = _523_
        mt["cljlib/type"] = "seq"
        local function _524_(s, v)
          return core.cons(v, s)
        end
        mt["cljlib/conj"] = _524_
        local function _525_()
          return core.list()
        end
        mt["cljlib/empty"] = _525_
      else
      end
    end
    return x
  end
  seq_2a = seq_2a0
  local seq
  do
    local v_27_auto
    local function seq0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "seq"))
        else
        end
      end
      local function _529_(...)
        local _528_ = getmetatable(coll)
        if ((_G.type(_528_) == "table") and (nil ~= _528_["cljlib/seq"])) then
          local f = _528_["cljlib/seq"]
          return f(coll)
        else
          local _ = _528_
          if lazy["seq?"](coll) then
            return lazy.seq(coll)
          elseif map_3f(coll) then
            return lazy.map(vec, coll)
          elseif "else" then
            return lazy.seq(coll)
          else
            return nil
          end
        end
      end
      return seq_2a(_529_(...))
    end
    v_27_auto = seq0
    core["seq"] = v_27_auto
    seq = v_27_auto
  end
  local rseq
  do
    local v_27_auto
    local function rseq0(...)
      local rev = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "rseq"))
        else
        end
      end
      return seq_2a(lazy.rseq(rev))
    end
    v_27_auto = rseq0
    core["rseq"] = v_27_auto
    rseq = v_27_auto
  end
  local lazy_seq_2a
  do
    local v_27_auto
    local function lazy_seq_2a0(...)
      local f = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "lazy-seq*"))
        else
        end
      end
      return seq_2a(lazy["lazy-seq"](f))
    end
    v_27_auto = lazy_seq_2a0
    core["lazy-seq*"] = v_27_auto
    lazy_seq_2a = v_27_auto
  end
  local first
  do
    local v_27_auto
    local function first0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "first"))
        else
        end
      end
      return lazy.first(seq(coll))
    end
    v_27_auto = first0
    core["first"] = v_27_auto
    first = v_27_auto
  end
  local rest
  do
    local v_27_auto
    local function rest0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "rest"))
        else
        end
      end
      return seq_2a(lazy.rest(seq(coll)))
    end
    v_27_auto = rest0
    core["rest"] = v_27_auto
    rest = v_27_auto
  end
  local next_2a
  local function next_2a0(...)
    local s = ...
    do
      local cnt_54_auto = select("#", ...)
      if (1 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "next*"))
      else
      end
    end
    return seq_2a(lazy.next(s))
  end
  next_2a = next_2a0
  do
    core["next"] = next_2a
  end
  local count
  do
    local v_27_auto
    local function count0(...)
      local s = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "count"))
        else
        end
      end
      local _538_ = getmetatable(s)
      if ((_G.type(_538_) == "table") and (_538_["cljlib/type"] == "vector")) then
        return length_2a(s)
      else
        local _ = _538_
        return lazy.count(s)
      end
    end
    v_27_auto = count0
    core["count"] = v_27_auto
    count = v_27_auto
  end
  local cons
  do
    local v_27_auto
    local function cons0(...)
      local head, tail = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "cons"))
        else
        end
      end
      return seq_2a(lazy.cons(head, tail))
    end
    v_27_auto = cons0
    core["cons"] = v_27_auto
    cons = v_27_auto
  end
  local function list(...)
    return seq_2a(lazy.list(...))
  end
  core.list = list
  local list_2a
  do
    local v_27_auto
    local function list_2a0(...)
      local core_38_auto = require("cljlib")
      local _let_541_ = core_38_auto.list(...)
      local args = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_541_, 1)
      return seq_2a(apply(lazy["list*"], args))
    end
    v_27_auto = list_2a0
    core["list*"] = v_27_auto
    list_2a = v_27_auto
  end
  local last
  do
    local v_27_auto
    local function last0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "last"))
        else
        end
      end
      local _543_ = next_2a(coll)
      if (nil ~= _543_) then
        local coll_2a = _543_
        return last0(coll_2a)
      else
        local _ = _543_
        return first(coll)
      end
    end
    v_27_auto = last0
    core["last"] = v_27_auto
    last = v_27_auto
  end
  local butlast
  do
    local v_27_auto
    local function butlast0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "butlast"))
        else
        end
      end
      return seq(lazy["drop-last"](coll))
    end
    v_27_auto = butlast0
    core["butlast"] = v_27_auto
    butlast = v_27_auto
  end
  local map
  do
    local v_27_auto
    local function map0(...)
      local _546_ = select("#", ...)
      if (_546_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "map"))
      elseif (_546_ == 1) then
        local f = ...
        local function fn_547_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_547_"))
            else
            end
          end
          local function fn_549_(...)
            local _550_ = select("#", ...)
            if (_550_ == 0) then
              return rf()
            elseif (_550_ == 1) then
              local result = ...
              return rf(result)
            elseif (_550_ == 2) then
              local result, input = ...
              return rf(result, f(input))
            else
              local _ = _550_
              local core_38_auto = require("cljlib")
              local _let_551_ = core_38_auto.list(...)
              local result = _let_551_[1]
              local input = _let_551_[2]
              local inputs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_551_, 3)
              return rf(result, apply(f, input, inputs))
            end
          end
          return fn_549_
        end
        return fn_547_
      elseif (_546_ == 2) then
        local f, coll = ...
        return seq_2a(lazy.map(f, coll))
      else
        local _ = _546_
        local core_38_auto = require("cljlib")
        local _let_553_ = core_38_auto.list(...)
        local f = _let_553_[1]
        local coll = _let_553_[2]
        local colls = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_553_, 3)
        return seq_2a(apply(lazy.map, f, coll, colls))
      end
    end
    v_27_auto = map0
    core["map"] = v_27_auto
    map = v_27_auto
  end
  local mapv
  do
    local v_27_auto
    local function mapv0(...)
      local _556_ = select("#", ...)
      if (_556_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "mapv"))
      elseif (_556_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "mapv"))
      elseif (_556_ == 2) then
        local f, coll = ...
        return core["persistent!"](core.transduce(map(f), core["conj!"], core.transient(vector()), coll))
      else
        local _ = _556_
        local core_38_auto = require("cljlib")
        local _let_557_ = core_38_auto.list(...)
        local f = _let_557_[1]
        local coll = _let_557_[2]
        local colls = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_557_, 3)
        return vec(apply(map, f, coll, colls))
      end
    end
    v_27_auto = mapv0
    core["mapv"] = v_27_auto
    mapv = v_27_auto
  end
  local map_indexed
  do
    local v_27_auto
    local function map_indexed0(...)
      local _559_ = select("#", ...)
      if (_559_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "map-indexed"))
      elseif (_559_ == 1) then
        local f = ...
        local function fn_560_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_560_"))
            else
            end
          end
          local i = -1
          local function fn_562_(...)
            local _563_ = select("#", ...)
            if (_563_ == 0) then
              return rf()
            elseif (_563_ == 1) then
              local result = ...
              return rf(result)
            elseif (_563_ == 2) then
              local result, input = ...
              i = (i + 1)
              return rf(result, f(i, input))
            else
              local _ = _563_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_562_"))
            end
          end
          return fn_562_
        end
        return fn_560_
      elseif (_559_ == 2) then
        local f, coll = ...
        return seq_2a(lazy["map-indexed"](f, coll))
      else
        local _ = _559_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "map-indexed"))
      end
    end
    v_27_auto = map_indexed0
    core["map-indexed"] = v_27_auto
    map_indexed = v_27_auto
  end
  local mapcat
  do
    local v_27_auto
    local function mapcat0(...)
      local _566_ = select("#", ...)
      if (_566_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "mapcat"))
      elseif (_566_ == 1) then
        local f = ...
        return comp(map(f), core.cat)
      else
        local _ = _566_
        local core_38_auto = require("cljlib")
        local _let_567_ = core_38_auto.list(...)
        local f = _let_567_[1]
        local colls = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_567_, 2)
        return seq_2a(apply(lazy.mapcat, f, colls))
      end
    end
    v_27_auto = mapcat0
    core["mapcat"] = v_27_auto
    mapcat = v_27_auto
  end
  local filter
  do
    local v_27_auto
    local function filter0(...)
      local _569_ = select("#", ...)
      if (_569_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "filter"))
      elseif (_569_ == 1) then
        local pred = ...
        local function fn_570_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_570_"))
            else
            end
          end
          local function fn_572_(...)
            local _573_ = select("#", ...)
            if (_573_ == 0) then
              return rf()
            elseif (_573_ == 1) then
              local result = ...
              return rf(result)
            elseif (_573_ == 2) then
              local result, input = ...
              if pred(input) then
                return rf(result, input)
              else
                return result
              end
            else
              local _ = _573_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_572_"))
            end
          end
          return fn_572_
        end
        return fn_570_
      elseif (_569_ == 2) then
        local pred, coll = ...
        return seq_2a(lazy.filter(pred, coll))
      else
        local _ = _569_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "filter"))
      end
    end
    v_27_auto = filter0
    core["filter"] = v_27_auto
    filter = v_27_auto
  end
  local filterv
  do
    local v_27_auto
    local function filterv0(...)
      local pred, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "filterv"))
        else
        end
      end
      return vec(filter(pred, coll))
    end
    v_27_auto = filterv0
    core["filterv"] = v_27_auto
    filterv = v_27_auto
  end
  local every_3f
  do
    local v_27_auto
    local function every_3f0(...)
      local pred, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "every?"))
        else
        end
      end
      return lazy["every?"](pred, coll)
    end
    v_27_auto = every_3f0
    core["every?"] = v_27_auto
    every_3f = v_27_auto
  end
  local some
  do
    local v_27_auto
    local function some0(...)
      local pred, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "some"))
        else
        end
      end
      return lazy["some?"](pred, coll)
    end
    v_27_auto = some0
    core["some"] = v_27_auto
    some = v_27_auto
  end
  local not_any_3f
  do
    local v_27_auto
    local function not_any_3f0(...)
      local pred, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "not-any?"))
        else
        end
      end
      local function _581_(_241)
        return not pred(_241)
      end
      return some(_581_, coll)
    end
    v_27_auto = not_any_3f0
    core["not-any?"] = v_27_auto
    not_any_3f = v_27_auto
  end
  local range
  do
    local v_27_auto
    local function range0(...)
      local _582_ = select("#", ...)
      if (_582_ == 0) then
        return seq_2a(lazy.range())
      elseif (_582_ == 1) then
        local upper = ...
        return seq_2a(lazy.range(upper))
      elseif (_582_ == 2) then
        local lower, upper = ...
        return seq_2a(lazy.range(lower, upper))
      elseif (_582_ == 3) then
        local lower, upper, step = ...
        return seq_2a(lazy.range(lower, upper, step))
      else
        local _ = _582_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "range"))
      end
    end
    v_27_auto = range0
    core["range"] = v_27_auto
    range = v_27_auto
  end
  local concat
  do
    local v_27_auto
    local function concat0(...)
      local core_38_auto = require("cljlib")
      local _let_584_ = core_38_auto.list(...)
      local colls = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_584_, 1)
      return seq_2a(apply(lazy.concat, colls))
    end
    v_27_auto = concat0
    core["concat"] = v_27_auto
    concat = v_27_auto
  end
  local reverse
  do
    local v_27_auto
    local function reverse0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "reverse"))
        else
        end
      end
      return seq_2a(lazy.reverse(coll))
    end
    v_27_auto = reverse0
    core["reverse"] = v_27_auto
    reverse = v_27_auto
  end
  local take
  do
    local v_27_auto
    local function take0(...)
      local _586_ = select("#", ...)
      if (_586_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "take"))
      elseif (_586_ == 1) then
        local n = ...
        local function fn_587_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_587_"))
            else
            end
          end
          local n0 = n
          local function fn_589_(...)
            local _590_ = select("#", ...)
            if (_590_ == 0) then
              return rf()
            elseif (_590_ == 1) then
              local result = ...
              return rf(result)
            elseif (_590_ == 2) then
              local result, input = ...
              local result0
              if (0 < n0) then
                result0 = rf(result, input)
              else
                result0 = result
              end
              n0 = (n0 - 1)
              if not (0 < n0) then
                return core["ensure-reduced"](result0)
              else
                return result0
              end
            else
              local _ = _590_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_589_"))
            end
          end
          return fn_589_
        end
        return fn_587_
      elseif (_586_ == 2) then
        local n, coll = ...
        return seq_2a(lazy.take(n, coll))
      else
        local _ = _586_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "take"))
      end
    end
    v_27_auto = take0
    core["take"] = v_27_auto
    take = v_27_auto
  end
  local take_while
  do
    local v_27_auto
    local function take_while0(...)
      local _595_ = select("#", ...)
      if (_595_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "take-while"))
      elseif (_595_ == 1) then
        local pred = ...
        local function fn_596_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_596_"))
            else
            end
          end
          local function fn_598_(...)
            local _599_ = select("#", ...)
            if (_599_ == 0) then
              return rf()
            elseif (_599_ == 1) then
              local result = ...
              return rf(result)
            elseif (_599_ == 2) then
              local result, input = ...
              if pred(input) then
                return rf(result, input)
              else
                return core.reduced(result)
              end
            else
              local _ = _599_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_598_"))
            end
          end
          return fn_598_
        end
        return fn_596_
      elseif (_595_ == 2) then
        local pred, coll = ...
        return seq_2a(lazy["take-while"](pred, coll))
      else
        local _ = _595_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "take-while"))
      end
    end
    v_27_auto = take_while0
    core["take-while"] = v_27_auto
    take_while = v_27_auto
  end
  local drop
  do
    local v_27_auto
    local function drop0(...)
      local _603_ = select("#", ...)
      if (_603_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "drop"))
      elseif (_603_ == 1) then
        local n = ...
        local function fn_604_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_604_"))
            else
            end
          end
          local nv = n
          local function fn_606_(...)
            local _607_ = select("#", ...)
            if (_607_ == 0) then
              return rf()
            elseif (_607_ == 1) then
              local result = ...
              return rf(result)
            elseif (_607_ == 2) then
              local result, input = ...
              local n0 = nv
              nv = (nv - 1)
              if pos_3f(n0) then
                return result
              else
                return rf(result, input)
              end
            else
              local _ = _607_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_606_"))
            end
          end
          return fn_606_
        end
        return fn_604_
      elseif (_603_ == 2) then
        local n, coll = ...
        return seq_2a(lazy.drop(n, coll))
      else
        local _ = _603_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "drop"))
      end
    end
    v_27_auto = drop0
    core["drop"] = v_27_auto
    drop = v_27_auto
  end
  local drop_while
  do
    local v_27_auto
    local function drop_while0(...)
      local _611_ = select("#", ...)
      if (_611_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "drop-while"))
      elseif (_611_ == 1) then
        local pred = ...
        local function fn_612_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_612_"))
            else
            end
          end
          local dv = true
          local function fn_614_(...)
            local _615_ = select("#", ...)
            if (_615_ == 0) then
              return rf()
            elseif (_615_ == 1) then
              local result = ...
              return rf(result)
            elseif (_615_ == 2) then
              local result, input = ...
              local drop_3f = dv
              if (drop_3f and pred(input)) then
                return result
              else
                dv = nil
                return rf(result, input)
              end
            else
              local _ = _615_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_614_"))
            end
          end
          return fn_614_
        end
        return fn_612_
      elseif (_611_ == 2) then
        local pred, coll = ...
        return seq_2a(lazy["drop-while"](pred, coll))
      else
        local _ = _611_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "drop-while"))
      end
    end
    v_27_auto = drop_while0
    core["drop-while"] = v_27_auto
    drop_while = v_27_auto
  end
  local drop_last
  do
    local v_27_auto
    local function drop_last0(...)
      local _619_ = select("#", ...)
      if (_619_ == 0) then
        return seq_2a(lazy["drop-last"]())
      elseif (_619_ == 1) then
        local coll = ...
        return seq_2a(lazy["drop-last"](coll))
      elseif (_619_ == 2) then
        local n, coll = ...
        return seq_2a(lazy["drop-last"](n, coll))
      else
        local _ = _619_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "drop-last"))
      end
    end
    v_27_auto = drop_last0
    core["drop-last"] = v_27_auto
    drop_last = v_27_auto
  end
  local take_last
  do
    local v_27_auto
    local function take_last0(...)
      local n, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "take-last"))
        else
        end
      end
      return seq_2a(lazy["take-last"](n, coll))
    end
    v_27_auto = take_last0
    core["take-last"] = v_27_auto
    take_last = v_27_auto
  end
  local take_nth
  do
    local v_27_auto
    local function take_nth0(...)
      local _622_ = select("#", ...)
      if (_622_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "take-nth"))
      elseif (_622_ == 1) then
        local n = ...
        local function fn_623_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_623_"))
            else
            end
          end
          local iv = -1
          local function fn_625_(...)
            local _626_ = select("#", ...)
            if (_626_ == 0) then
              return rf()
            elseif (_626_ == 1) then
              local result = ...
              return rf(result)
            elseif (_626_ == 2) then
              local result, input = ...
              iv = (iv + 1)
              if (0 == (iv % n)) then
                return rf(result, input)
              else
                return result
              end
            else
              local _ = _626_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_625_"))
            end
          end
          return fn_625_
        end
        return fn_623_
      elseif (_622_ == 2) then
        local n, coll = ...
        return seq_2a(lazy["take-nth"](n, coll))
      else
        local _ = _622_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "take-nth"))
      end
    end
    v_27_auto = take_nth0
    core["take-nth"] = v_27_auto
    take_nth = v_27_auto
  end
  local split_at
  do
    local v_27_auto
    local function split_at0(...)
      local n, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "split-at"))
        else
        end
      end
      return vec(lazy["split-at"](n, coll))
    end
    v_27_auto = split_at0
    core["split-at"] = v_27_auto
    split_at = v_27_auto
  end
  local split_with
  do
    local v_27_auto
    local function split_with0(...)
      local pred, coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "split-with"))
        else
        end
      end
      return vec(lazy["split-with"](pred, coll))
    end
    v_27_auto = split_with0
    core["split-with"] = v_27_auto
    split_with = v_27_auto
  end
  local nthrest
  do
    local v_27_auto
    local function nthrest0(...)
      local coll, n = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "nthrest"))
        else
        end
      end
      return seq_2a(lazy.nthrest(coll, n))
    end
    v_27_auto = nthrest0
    core["nthrest"] = v_27_auto
    nthrest = v_27_auto
  end
  local nthnext
  do
    local v_27_auto
    local function nthnext0(...)
      local coll, n = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "nthnext"))
        else
        end
      end
      return lazy.nthnext(coll, n)
    end
    v_27_auto = nthnext0
    core["nthnext"] = v_27_auto
    nthnext = v_27_auto
  end
  local keep
  do
    local v_27_auto
    local function keep0(...)
      local _634_ = select("#", ...)
      if (_634_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "keep"))
      elseif (_634_ == 1) then
        local f = ...
        local function fn_635_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_635_"))
            else
            end
          end
          local function fn_637_(...)
            local _638_ = select("#", ...)
            if (_638_ == 0) then
              return rf()
            elseif (_638_ == 1) then
              local result = ...
              return rf(result)
            elseif (_638_ == 2) then
              local result, input = ...
              local v = f(input)
              if nil_3f(v) then
                return result
              else
                return rf(result, v)
              end
            else
              local _ = _638_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_637_"))
            end
          end
          return fn_637_
        end
        return fn_635_
      elseif (_634_ == 2) then
        local f, coll = ...
        return seq_2a(lazy.keep(f, coll))
      else
        local _ = _634_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "keep"))
      end
    end
    v_27_auto = keep0
    core["keep"] = v_27_auto
    keep = v_27_auto
  end
  local keep_indexed
  do
    local v_27_auto
    local function keep_indexed0(...)
      local _642_ = select("#", ...)
      if (_642_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "keep-indexed"))
      elseif (_642_ == 1) then
        local f = ...
        local function fn_643_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_643_"))
            else
            end
          end
          local iv = -1
          local function fn_645_(...)
            local _646_ = select("#", ...)
            if (_646_ == 0) then
              return rf()
            elseif (_646_ == 1) then
              local result = ...
              return rf(result)
            elseif (_646_ == 2) then
              local result, input = ...
              iv = (iv + 1)
              local v = f(iv, input)
              if nil_3f(v) then
                return result
              else
                return rf(result, v)
              end
            else
              local _ = _646_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_645_"))
            end
          end
          return fn_645_
        end
        return fn_643_
      elseif (_642_ == 2) then
        local f, coll = ...
        return seq_2a(lazy["keep-indexed"](f, coll))
      else
        local _ = _642_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "keep-indexed"))
      end
    end
    v_27_auto = keep_indexed0
    core["keep-indexed"] = v_27_auto
    keep_indexed = v_27_auto
  end
  local partition
  do
    local v_27_auto
    local function partition0(...)
      local _651_ = select("#", ...)
      if (_651_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "partition"))
      elseif (_651_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "partition"))
      elseif (_651_ == 2) then
        local n, coll = ...
        return map(seq_2a, lazy.partition(n, coll))
      elseif (_651_ == 3) then
        local n, step, coll = ...
        return map(seq_2a, lazy.partition(n, step, coll))
      elseif (_651_ == 4) then
        local n, step, pad, coll = ...
        return map(seq_2a, lazy.partition(n, step, pad, coll))
      else
        local _ = _651_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "partition"))
      end
    end
    v_27_auto = partition0
    core["partition"] = v_27_auto
    partition = v_27_auto
  end
  local function array()
    local len = 0
    local function _653_()
      return len
    end
    local function _654_(self)
      while (0 ~= len) do
        self[len] = nil
        len = (len - 1)
      end
      return nil
    end
    local function _655_(self, val)
      len = (len + 1)
      self[len] = val
      return self
    end
    return setmetatable({}, {__len = _653_, __index = {clear = _654_, add = _655_}})
  end
  local partition_by
  do
    local v_27_auto
    local function partition_by0(...)
      local _656_ = select("#", ...)
      if (_656_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "partition-by"))
      elseif (_656_ == 1) then
        local f = ...
        local function fn_657_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_657_"))
            else
            end
          end
          local a = array()
          local none = {}
          local pv = none
          local function fn_659_(...)
            local _660_ = select("#", ...)
            if (_660_ == 0) then
              return rf()
            elseif (_660_ == 1) then
              local result = ...
              local function _661_(...)
                if empty_3f(a) then
                  return result
                else
                  local v = vec(a)
                  a:clear()
                  return core.unreduced(rf(result, v))
                end
              end
              return rf(_661_(...))
            elseif (_660_ == 2) then
              local result, input = ...
              local pval = pv
              local val = f(input)
              pv = val
              if ((pval == none) or (val == pval)) then
                a:add(input)
                return result
              else
                local v = vec(a)
                a:clear()
                local ret = rf(result, v)
                if not core["reduced?"](ret) then
                  a:add(input)
                else
                end
                return ret
              end
            else
              local _ = _660_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_659_"))
            end
          end
          return fn_659_
        end
        return fn_657_
      elseif (_656_ == 2) then
        local f, coll = ...
        return map(seq_2a, lazy["partition-by"](f, coll))
      else
        local _ = _656_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "partition-by"))
      end
    end
    v_27_auto = partition_by0
    core["partition-by"] = v_27_auto
    partition_by = v_27_auto
  end
  local partition_all
  do
    local v_27_auto
    local function partition_all0(...)
      local _666_ = select("#", ...)
      if (_666_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "partition-all"))
      elseif (_666_ == 1) then
        local n = ...
        local function fn_667_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_667_"))
            else
            end
          end
          local a = array()
          local function fn_669_(...)
            local _670_ = select("#", ...)
            if (_670_ == 0) then
              return rf()
            elseif (_670_ == 1) then
              local result = ...
              local function _671_(...)
                if (0 == #a) then
                  return result
                else
                  local v = vec(a)
                  a:clear()
                  return core.unreduced(rf(result, v))
                end
              end
              return rf(_671_(...))
            elseif (_670_ == 2) then
              local result, input = ...
              a:add(input)
              if (n == #a) then
                local v = vec(a)
                a:clear()
                return rf(result, v)
              else
                return result
              end
            else
              local _ = _670_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_669_"))
            end
          end
          return fn_669_
        end
        return fn_667_
      elseif (_666_ == 2) then
        local n, coll = ...
        return map(seq_2a, lazy["partition-all"](n, coll))
      elseif (_666_ == 3) then
        local n, step, coll = ...
        return map(seq_2a, lazy["partition-all"](n, step, coll))
      else
        local _ = _666_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "partition-all"))
      end
    end
    v_27_auto = partition_all0
    core["partition-all"] = v_27_auto
    partition_all = v_27_auto
  end
  local reductions
  do
    local v_27_auto
    local function reductions0(...)
      local _676_ = select("#", ...)
      if (_676_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "reductions"))
      elseif (_676_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "reductions"))
      elseif (_676_ == 2) then
        local f, coll = ...
        return seq_2a(lazy.reductions(f, coll))
      elseif (_676_ == 3) then
        local f, init, coll = ...
        return seq_2a(lazy.reductions(f, init, coll))
      else
        local _ = _676_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "reductions"))
      end
    end
    v_27_auto = reductions0
    core["reductions"] = v_27_auto
    reductions = v_27_auto
  end
  local contains_3f
  do
    local v_27_auto
    local function contains_3f0(...)
      local coll, elt = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "contains?"))
        else
        end
      end
      return lazy["contains?"](coll, elt)
    end
    v_27_auto = contains_3f0
    core["contains?"] = v_27_auto
    contains_3f = v_27_auto
  end
  local distinct
  do
    local v_27_auto
    local function distinct0(...)
      local _679_ = select("#", ...)
      if (_679_ == 0) then
        local function fn_680_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_680_"))
            else
            end
          end
          local seen = setmetatable({}, {__index = deep_index})
          local function fn_682_(...)
            local _683_ = select("#", ...)
            if (_683_ == 0) then
              return rf()
            elseif (_683_ == 1) then
              local result = ...
              return rf(result)
            elseif (_683_ == 2) then
              local result, input = ...
              if seen[input] then
                return result
              else
                seen[input] = true
                return rf(result, input)
              end
            else
              local _ = _683_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_682_"))
            end
          end
          return fn_682_
        end
        return fn_680_
      elseif (_679_ == 1) then
        local coll = ...
        return seq_2a(lazy.distinct(coll))
      else
        local _ = _679_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "distinct"))
      end
    end
    v_27_auto = distinct0
    core["distinct"] = v_27_auto
    distinct = v_27_auto
  end
  local dedupe
  do
    local v_27_auto
    local function dedupe0(...)
      local _687_ = select("#", ...)
      if (_687_ == 0) then
        local function fn_688_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_688_"))
            else
            end
          end
          local none = {}
          local pv = none
          local function fn_690_(...)
            local _691_ = select("#", ...)
            if (_691_ == 0) then
              return rf()
            elseif (_691_ == 1) then
              local result = ...
              return rf(result)
            elseif (_691_ == 2) then
              local result, input = ...
              local prior = pv
              pv = input
              if (prior == input) then
                return result
              else
                return rf(result, input)
              end
            else
              local _ = _691_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_690_"))
            end
          end
          return fn_690_
        end
        return fn_688_
      elseif (_687_ == 1) then
        local coll = ...
        return core.sequence(dedupe0(), coll)
      else
        local _ = _687_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "dedupe"))
      end
    end
    v_27_auto = dedupe0
    core["dedupe"] = v_27_auto
    dedupe = v_27_auto
  end
  local random_sample
  do
    local v_27_auto
    local function random_sample0(...)
      local _695_ = select("#", ...)
      if (_695_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "random-sample"))
      elseif (_695_ == 1) then
        local prob = ...
        local function _696_()
          return (math.random() < prob)
        end
        return filter(_696_)
      elseif (_695_ == 2) then
        local prob, coll = ...
        local function _697_()
          return (math.random() < prob)
        end
        return filter(_697_, coll)
      else
        local _ = _695_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "random-sample"))
      end
    end
    v_27_auto = random_sample0
    core["random-sample"] = v_27_auto
    random_sample = v_27_auto
  end
  local doall
  do
    local v_27_auto
    local function doall0(...)
      local seq0 = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "doall"))
        else
        end
      end
      return seq_2a(lazy.doall(seq0))
    end
    v_27_auto = doall0
    core["doall"] = v_27_auto
    doall = v_27_auto
  end
  local dorun
  do
    local v_27_auto
    local function dorun0(...)
      local seq0 = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "dorun"))
        else
        end
      end
      return lazy.dorun(seq0)
    end
    v_27_auto = dorun0
    core["dorun"] = v_27_auto
    dorun = v_27_auto
  end
  local line_seq
  do
    local v_27_auto
    local function line_seq0(...)
      local file = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "line-seq"))
        else
        end
      end
      return seq_2a(lazy["line-seq"](file))
    end
    v_27_auto = line_seq0
    core["line-seq"] = v_27_auto
    line_seq = v_27_auto
  end
  local iterate
  do
    local v_27_auto
    local function iterate0(...)
      local f, x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "iterate"))
        else
        end
      end
      return seq_2a(lazy.iterate(f, x))
    end
    v_27_auto = iterate0
    core["iterate"] = v_27_auto
    iterate = v_27_auto
  end
  local remove
  do
    local v_27_auto
    local function remove0(...)
      local _703_ = select("#", ...)
      if (_703_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "remove"))
      elseif (_703_ == 1) then
        local pred = ...
        return filter(complement(pred))
      elseif (_703_ == 2) then
        local pred, coll = ...
        return seq_2a(lazy.remove(pred, coll))
      else
        local _ = _703_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "remove"))
      end
    end
    v_27_auto = remove0
    core["remove"] = v_27_auto
    remove = v_27_auto
  end
  local cycle
  do
    local v_27_auto
    local function cycle0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "cycle"))
        else
        end
      end
      return seq_2a(lazy.cycle(coll))
    end
    v_27_auto = cycle0
    core["cycle"] = v_27_auto
    cycle = v_27_auto
  end
  local _repeat
  do
    local v_27_auto
    local function _repeat0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "repeat"))
        else
        end
      end
      return seq_2a(lazy["repeat"](x))
    end
    v_27_auto = _repeat0
    core["repeat"] = v_27_auto
    _repeat = v_27_auto
  end
  local repeatedly
  do
    local v_27_auto
    local function repeatedly0(...)
      local core_38_auto = require("cljlib")
      local _let_707_ = core_38_auto.list(...)
      local f = _let_707_[1]
      local args = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_707_, 2)
      return seq_2a(apply(lazy.repeatedly, f, args))
    end
    v_27_auto = repeatedly0
    core["repeatedly"] = v_27_auto
    repeatedly = v_27_auto
  end
  local tree_seq
  do
    local v_27_auto
    local function tree_seq0(...)
      local branch_3f, children, root = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "tree-seq"))
        else
        end
      end
      return seq_2a(lazy["tree-seq"](branch_3f, children, root))
    end
    v_27_auto = tree_seq0
    core["tree-seq"] = v_27_auto
    tree_seq = v_27_auto
  end
  local interleave
  do
    local v_27_auto
    local function interleave0(...)
      local _709_ = select("#", ...)
      if (_709_ == 0) then
        return seq_2a(lazy.interleave())
      elseif (_709_ == 1) then
        local s = ...
        return seq_2a(lazy.interleave(s))
      elseif (_709_ == 2) then
        local s1, s2 = ...
        return seq_2a(lazy.interleave(s1, s2))
      else
        local _ = _709_
        local core_38_auto = require("cljlib")
        local _let_710_ = core_38_auto.list(...)
        local s1 = _let_710_[1]
        local s2 = _let_710_[2]
        local ss = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_710_, 3)
        return seq_2a(apply(lazy.interleave, s1, s2, ss))
      end
    end
    v_27_auto = interleave0
    core["interleave"] = v_27_auto
    interleave = v_27_auto
  end
  local interpose
  do
    local v_27_auto
    local function interpose0(...)
      local _712_ = select("#", ...)
      if (_712_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "interpose"))
      elseif (_712_ == 1) then
        local sep = ...
        local function fn_713_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_713_"))
            else
            end
          end
          local started = false
          local function fn_715_(...)
            local _716_ = select("#", ...)
            if (_716_ == 0) then
              return rf()
            elseif (_716_ == 1) then
              local result = ...
              return rf(result)
            elseif (_716_ == 2) then
              local result, input = ...
              if started then
                local sepr = rf(result, sep)
                if core["reduced?"](sepr) then
                  return sepr
                else
                  return rf(sepr, input)
                end
              else
                started = true
                return rf(result, input)
              end
            else
              local _ = _716_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_715_"))
            end
          end
          return fn_715_
        end
        return fn_713_
      elseif (_712_ == 2) then
        local separator, coll = ...
        return seq_2a(lazy.interpose(separator, coll))
      else
        local _ = _712_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "interpose"))
      end
    end
    v_27_auto = interpose0
    core["interpose"] = v_27_auto
    interpose = v_27_auto
  end
  local halt_when
  do
    local v_27_auto
    local function halt_when0(...)
      local _721_ = select("#", ...)
      if (_721_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "halt-when"))
      elseif (_721_ == 1) then
        local pred = ...
        return halt_when0(pred, nil)
      elseif (_721_ == 2) then
        local pred, retf = ...
        local function fn_722_(...)
          local rf = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_722_"))
            else
            end
          end
          local halt
          local function _724_()
            return "#<halt>"
          end
          halt = setmetatable({}, {__fennelview = _724_})
          local function fn_725_(...)
            local _726_ = select("#", ...)
            if (_726_ == 0) then
              return rf()
            elseif (_726_ == 1) then
              local result = ...
              if (map_3f(result) and contains_3f(result, halt)) then
                return result.value
              else
                return rf(result)
              end
            elseif (_726_ == 2) then
              local result, input = ...
              if pred(input) then
                local _728_
                if retf then
                  _728_ = retf(rf(result), input)
                else
                  _728_ = input
                end
                return core.reduced({[halt] = true, value = _728_})
              else
                return rf(result, input)
              end
            else
              local _ = _726_
              return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_725_"))
            end
          end
          return fn_725_
        end
        return fn_722_
      else
        local _ = _721_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "halt-when"))
      end
    end
    v_27_auto = halt_when0
    core["halt-when"] = v_27_auto
    halt_when = v_27_auto
  end
  local realized_3f
  do
    local v_27_auto
    local function realized_3f0(...)
      local s = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "realized?"))
        else
        end
      end
      return lazy["realized?"](s)
    end
    v_27_auto = realized_3f0
    core["realized?"] = v_27_auto
    realized_3f = v_27_auto
  end
  local keys
  do
    local v_27_auto
    local function keys0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "keys"))
        else
        end
      end
      assert((map_3f(coll) or empty_3f(coll)), "expected a map")
      if empty_3f(coll) then
        return lazy.list()
      else
        return lazy.keys(coll)
      end
    end
    v_27_auto = keys0
    core["keys"] = v_27_auto
    keys = v_27_auto
  end
  local vals
  do
    local v_27_auto
    local function vals0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "vals"))
        else
        end
      end
      assert((map_3f(coll) or empty_3f(coll)), "expected a map")
      if empty_3f(coll) then
        return lazy.list()
      else
        return lazy.vals(coll)
      end
    end
    v_27_auto = vals0
    core["vals"] = v_27_auto
    vals = v_27_auto
  end
  local find
  do
    local v_27_auto
    local function find0(...)
      local coll, key = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "find"))
        else
        end
      end
      assert((map_3f(coll) or empty_3f(coll)), "expected a map")
      local _739_ = coll[key]
      if (nil ~= _739_) then
        local v = _739_
        return {key, v}
      else
        return nil
      end
    end
    v_27_auto = find0
    core["find"] = v_27_auto
    find = v_27_auto
  end
  local sort
  do
    local v_27_auto
    local function sort0(...)
      local _741_ = select("#", ...)
      if (_741_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "sort"))
      elseif (_741_ == 1) then
        local coll = ...
        local _742_ = seq(coll)
        if (nil ~= _742_) then
          local s = _742_
          return seq(itable.sort(vec(s)))
        else
          local _ = _742_
          return list()
        end
      elseif (_741_ == 2) then
        local comparator, coll = ...
        local _744_ = seq(coll)
        if (nil ~= _744_) then
          local s = _744_
          return seq(itable.sort(vec(s), comparator))
        else
          local _ = _744_
          return list()
        end
      else
        local _ = _741_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "sort"))
      end
    end
    v_27_auto = sort0
    core["sort"] = v_27_auto
    sort = v_27_auto
  end
  local reduce
  do
    local v_27_auto
    local function reduce0(...)
      local _748_ = select("#", ...)
      if (_748_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "reduce"))
      elseif (_748_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "reduce"))
      elseif (_748_ == 2) then
        local f, coll = ...
        return lazy.reduce(f, seq(coll))
      elseif (_748_ == 3) then
        local f, val, coll = ...
        return lazy.reduce(f, val, seq(coll))
      else
        local _ = _748_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "reduce"))
      end
    end
    v_27_auto = reduce0
    core["reduce"] = v_27_auto
    reduce = v_27_auto
  end
  local reduced
  do
    local v_27_auto
    local function reduced0(...)
      local value = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "reduced"))
        else
        end
      end
      local tmp_9_auto = lazy.reduced(value)
      local function _751_(_241)
        return _241:unbox()
      end
      getmetatable(tmp_9_auto)["cljlib/deref"] = _751_
      return tmp_9_auto
    end
    v_27_auto = reduced0
    core["reduced"] = v_27_auto
    reduced = v_27_auto
  end
  local reduced_3f
  do
    local v_27_auto
    local function reduced_3f0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "reduced?"))
        else
        end
      end
      return lazy["reduced?"](x)
    end
    v_27_auto = reduced_3f0
    core["reduced?"] = v_27_auto
    reduced_3f = v_27_auto
  end
  local unreduced
  do
    local v_27_auto
    local function unreduced0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "unreduced"))
        else
        end
      end
      if reduced_3f(x) then
        return deref(x)
      else
        return x
      end
    end
    v_27_auto = unreduced0
    core["unreduced"] = v_27_auto
    unreduced = v_27_auto
  end
  local ensure_reduced
  do
    local v_27_auto
    local function ensure_reduced0(...)
      local x = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "ensure-reduced"))
        else
        end
      end
      if reduced_3f(x) then
        return x
      else
        return reduced(x)
      end
    end
    v_27_auto = ensure_reduced0
    core["ensure-reduced"] = v_27_auto
    ensure_reduced = v_27_auto
  end
  local preserving_reduced
  local function preserving_reduced0(...)
    local rf = ...
    do
      local cnt_54_auto = select("#", ...)
      if (1 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "preserving-reduced"))
      else
      end
    end
    local function fn_758_(...)
      local a, b = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_758_"))
        else
        end
      end
      local ret = rf(a, b)
      if reduced_3f(ret) then
        return reduced(ret)
      else
        return ret
      end
    end
    return fn_758_
  end
  preserving_reduced = preserving_reduced0
  local cat
  do
    local v_27_auto
    local function cat0(...)
      local rf = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "cat"))
        else
        end
      end
      local rrf = preserving_reduced(rf)
      local function fn_762_(...)
        local _763_ = select("#", ...)
        if (_763_ == 0) then
          return rf()
        elseif (_763_ == 1) then
          local result = ...
          return rf(result)
        elseif (_763_ == 2) then
          local result, input = ...
          return reduce(rrf, result, input)
        else
          local _ = _763_
          return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_762_"))
        end
      end
      return fn_762_
    end
    v_27_auto = cat0
    core["cat"] = v_27_auto
    cat = v_27_auto
  end
  local reduce_kv
  do
    local v_27_auto
    local function reduce_kv0(...)
      local f, val, s = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "reduce-kv"))
        else
        end
      end
      if map_3f(s) then
        local function _767_(res, _766_)
          local k = _766_[1]
          local v = _766_[2]
          return f(res, k, v)
        end
        return reduce(_767_, val, seq(s))
      else
        local function _769_(res, _768_)
          local k = _768_[1]
          local v = _768_[2]
          return f(res, k, v)
        end
        return reduce(_769_, val, map(vector, drop(1, range()), seq(s)))
      end
    end
    v_27_auto = reduce_kv0
    core["reduce-kv"] = v_27_auto
    reduce_kv = v_27_auto
  end
  local completing
  do
    local v_27_auto
    local function completing0(...)
      local _771_ = select("#", ...)
      if (_771_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "completing"))
      elseif (_771_ == 1) then
        local f = ...
        return completing0(f, identity)
      elseif (_771_ == 2) then
        local f, cf = ...
        local function fn_772_(...)
          local _773_ = select("#", ...)
          if (_773_ == 0) then
            return f()
          elseif (_773_ == 1) then
            local x = ...
            return cf(x)
          elseif (_773_ == 2) then
            local x, y = ...
            return f(x, y)
          else
            local _ = _773_
            return error(("Wrong number of args (%s) passed to %s"):format(_, "fn_772_"))
          end
        end
        return fn_772_
      else
        local _ = _771_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "completing"))
      end
    end
    v_27_auto = completing0
    core["completing"] = v_27_auto
    completing = v_27_auto
  end
  local transduce
  do
    local v_27_auto
    local function transduce0(...)
      local _779_ = select("#", ...)
      if (_779_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "transduce"))
      elseif (_779_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "transduce"))
      elseif (_779_ == 2) then
        return error(("Wrong number of args (%s) passed to %s"):format(2, "transduce"))
      elseif (_779_ == 3) then
        local xform, f, coll = ...
        return transduce0(xform, f, f(), coll)
      elseif (_779_ == 4) then
        local xform, f, init, coll = ...
        local f0 = xform(f)
        return f0(reduce(f0, init, seq(coll)))
      else
        local _ = _779_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "transduce"))
      end
    end
    v_27_auto = transduce0
    core["transduce"] = v_27_auto
    transduce = v_27_auto
  end
  local sequence
  do
    local v_27_auto
    local function sequence0(...)
      local _781_ = select("#", ...)
      if (_781_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "sequence"))
      elseif (_781_ == 1) then
        local coll = ...
        if seq_3f(coll) then
          return coll
        else
          return (seq(coll) or list())
        end
      elseif (_781_ == 2) then
        local xform, coll = ...
        local f
        local function _783_(_241, _242)
          return cons(_242, _241)
        end
        f = xform(completing(_783_))
        local function step(coll0)
          local val_100_auto = seq(coll0)
          if (nil ~= val_100_auto) then
            local s = val_100_auto
            local res = f(nil, first(s))
            if reduced_3f(res) then
              return f(deref(res))
            elseif seq_3f(res) then
              local function _784_()
                return step(rest(s))
              end
              return concat(res, lazy_seq_2a(_784_))
            elseif "else" then
              return step(rest(s))
            else
              return nil
            end
          else
            return f(nil)
          end
        end
        return (step(coll) or list())
      else
        local _ = _781_
        local core_38_auto = require("cljlib")
        local _let_787_ = core_38_auto.list(...)
        local xform = _let_787_[1]
        local coll = _let_787_[2]
        local colls = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_787_, 3)
        local f
        local function _788_(_241, _242)
          return cons(_242, _241)
        end
        f = xform(completing(_788_))
        local function step(colls0)
          if every_3f(seq, colls0) then
            local res = apply(f, nil, map(first, colls0))
            if reduced_3f(res) then
              return f(deref(res))
            elseif seq_3f(res) then
              local function _789_()
                return step(map(rest, colls0))
              end
              return concat(res, lazy_seq_2a(_789_))
            elseif "else" then
              return step(map(rest, colls0))
            else
              return nil
            end
          else
            return f(nil)
          end
        end
        return (step(cons(coll, colls)) or list())
      end
    end
    v_27_auto = sequence0
    core["sequence"] = v_27_auto
    sequence = v_27_auto
  end
  local function map__3etransient(immutable)
    local function _793_(map0)
      local removed = setmetatable({}, {__index = deep_index})
      local function _794_(_, k)
        if not removed[k] then
          return map0[k]
        else
          return nil
        end
      end
      local function _796_()
        return error("can't `conj` onto transient map, use `conj!`")
      end
      local function _797_()
        return error("can't `assoc` onto transient map, use `assoc!`")
      end
      local function _798_()
        return error("can't `dissoc` onto transient map, use `dissoc!`")
      end
      local function _800_(tmap, _799_)
        local k = _799_[1]
        local v = _799_[2]
        if (nil == v) then
          removed[k] = true
        else
          removed[k] = nil
        end
        tmap[k] = v
        return tmap
      end
      local function _802_(tmap, ...)
        for i = 1, select("#", ...), 2 do
          local k, v = select(i, ...)
          tmap[k] = v
          if (nil == v) then
            removed[k] = true
          else
            removed[k] = nil
          end
        end
        return tmap
      end
      local function _804_(tmap, ...)
        for i = 1, select("#", ...) do
          local k = select(i, ...)
          tmap[k] = nil
          removed[k] = true
        end
        return tmap
      end
      local function _805_(tmap)
        local t
        do
          local tbl_16_auto
          do
            local tbl_16_auto0 = {}
            for k, v in pairs(map0) do
              local k_17_auto, v_18_auto = k, v
              if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
                tbl_16_auto0[k_17_auto] = v_18_auto
              else
              end
            end
            tbl_16_auto = tbl_16_auto0
          end
          for k, v in pairs(tmap) do
            local k_17_auto, v_18_auto = k, v
            if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
              tbl_16_auto[k_17_auto] = v_18_auto
            else
            end
          end
          t = tbl_16_auto
        end
        for k in pairs(removed) do
          t[k] = nil
        end
        local function _808_()
          local tbl_21_auto = {}
          local i_22_auto = 0
          for k in pairs_2a(tmap) do
            local val_23_auto = k
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          return tbl_21_auto
        end
        for _, k in ipairs(_808_()) do
          tmap[k] = nil
        end
        local function _810_()
          return error("attempt to use transient after it was persistet")
        end
        local function _811_()
          return error("attempt to use transient after it was persistet")
        end
        setmetatable(tmap, {__index = _810_, __newindex = _811_})
        return immutable(itable(t))
      end
      return setmetatable({}, {__index = _794_, ["cljlib/type"] = "transient", ["cljlib/conj"] = _796_, ["cljlib/assoc"] = _797_, ["cljlib/dissoc"] = _798_, ["cljlib/conj!"] = _800_, ["cljlib/assoc!"] = _802_, ["cljlib/dissoc!"] = _804_, ["cljlib/persistent!"] = _805_})
    end
    return _793_
  end
  local function hash_map_2a(x)
    do
      local _812_ = getmetatable(x)
      if (nil ~= _812_) then
        local mt = _812_
        mt["cljlib/type"] = "hash-map"
        mt["cljlib/editable"] = true
        local function _814_(t, _813_, ...)
          local k = _813_[1]
          local v = _813_[2]
          local function _815_(...)
            local kvs = {}
            for _, _816_ in ipairs_2a({...}) do
              local k0 = _816_[1]
              local v0 = _816_[2]
              table.insert(kvs, k0)
              table.insert(kvs, v0)
              kvs = kvs
            end
            return kvs
          end
          return apply(core.assoc, t, k, v, _815_(...))
        end
        mt["cljlib/conj"] = _814_
        mt["cljlib/transient"] = map__3etransient(hash_map_2a)
        local function _817_()
          return hash_map_2a(itable({}))
        end
        mt["cljlib/empty"] = _817_
      else
        local _ = _812_
        hash_map_2a(setmetatable(x, {}))
      end
    end
    return x
  end
  local assoc
  do
    local v_27_auto
    local function assoc0(...)
      local _821_ = select("#", ...)
      if (_821_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "assoc"))
      elseif (_821_ == 1) then
        local tbl = ...
        return hash_map_2a(itable({}))
      elseif (_821_ == 2) then
        return error(("Wrong number of args (%s) passed to %s"):format(2, "assoc"))
      elseif (_821_ == 3) then
        local tbl, k, v = ...
        assert((nil_3f(tbl) or map_3f(tbl) or empty_3f(tbl)), "expected a map")
        assert(not nil_3f(k), "attempt to use nil as key")
        return hash_map_2a(itable.assoc((tbl or {}), k, v))
      else
        local _ = _821_
        local core_38_auto = require("cljlib")
        local _let_822_ = core_38_auto.list(...)
        local tbl = _let_822_[1]
        local k = _let_822_[2]
        local v = _let_822_[3]
        local kvs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_822_, 4)
        assert((nil_3f(tbl) or map_3f(tbl) or empty_3f(tbl)), "expected a map")
        assert(not nil_3f(k), "attempt to use nil as key")
        return hash_map_2a(apply(itable.assoc, (tbl or {}), k, v, kvs))
      end
    end
    v_27_auto = assoc0
    core["assoc"] = v_27_auto
    assoc = v_27_auto
  end
  local assoc_in
  do
    local v_27_auto
    local function assoc_in0(...)
      local tbl, key_seq, val = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "assoc-in"))
        else
        end
      end
      assert((nil_3f(tbl) or map_3f(tbl) or empty_3f(tbl)), "expected a map or nil")
      return hash_map_2a(itable["assoc-in"](tbl, key_seq, val))
    end
    v_27_auto = assoc_in0
    core["assoc-in"] = v_27_auto
    assoc_in = v_27_auto
  end
  local update
  do
    local v_27_auto
    local function update0(...)
      local tbl, key, f = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "update"))
        else
        end
      end
      assert((nil_3f(tbl) or map_3f(tbl) or empty_3f(tbl)), "expected a map")
      return hash_map_2a(itable.update(tbl, key, f))
    end
    v_27_auto = update0
    core["update"] = v_27_auto
    update = v_27_auto
  end
  local update_in
  do
    local v_27_auto
    local function update_in0(...)
      local tbl, key_seq, f = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "update-in"))
        else
        end
      end
      assert((nil_3f(tbl) or map_3f(tbl) or empty_3f(tbl)), "expected a map or nil")
      return hash_map_2a(itable["update-in"](tbl, key_seq, f))
    end
    v_27_auto = update_in0
    core["update-in"] = v_27_auto
    update_in = v_27_auto
  end
  local hash_map
  do
    local v_27_auto
    local function hash_map0(...)
      local core_38_auto = require("cljlib")
      local _let_827_ = core_38_auto.list(...)
      local kvs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_827_, 1)
      return apply(assoc, {}, kvs)
    end
    v_27_auto = hash_map0
    core["hash-map"] = v_27_auto
    hash_map = v_27_auto
  end
  local get
  do
    local v_27_auto
    local function get0(...)
      local _829_ = select("#", ...)
      if (_829_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "get"))
      elseif (_829_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "get"))
      elseif (_829_ == 2) then
        local tbl, key = ...
        return get0(tbl, key, nil)
      elseif (_829_ == 3) then
        local tbl, key, not_found = ...
        assert((map_3f(tbl) or empty_3f(tbl)), "expected a map")
        return (tbl[key] or not_found)
      else
        local _ = _829_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "get"))
      end
    end
    v_27_auto = get0
    core["get"] = v_27_auto
    get = v_27_auto
  end
  local get_in
  do
    local v_27_auto
    local function get_in0(...)
      local _832_ = select("#", ...)
      if (_832_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "get-in"))
      elseif (_832_ == 1) then
        return error(("Wrong number of args (%s) passed to %s"):format(1, "get-in"))
      elseif (_832_ == 2) then
        local tbl, keys0 = ...
        return get_in0(tbl, keys0, nil)
      elseif (_832_ == 3) then
        local tbl, keys0, not_found = ...
        assert((map_3f(tbl) or empty_3f(tbl)), "expected a map")
        local res, t, done = tbl, tbl, nil
        for _, k in ipairs_2a(keys0) do
          if done then break end
          local _833_ = t[k]
          if (nil ~= _833_) then
            local v = _833_
            res, t = v, v
          else
            local _0 = _833_
            res, done = not_found, true
          end
        end
        return res
      else
        local _ = _832_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "get-in"))
      end
    end
    v_27_auto = get_in0
    core["get-in"] = v_27_auto
    get_in = v_27_auto
  end
  local dissoc
  do
    local v_27_auto
    local function dissoc0(...)
      local _836_ = select("#", ...)
      if (_836_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "dissoc"))
      elseif (_836_ == 1) then
        local tbl = ...
        return tbl
      elseif (_836_ == 2) then
        local tbl, key = ...
        assert((map_3f(tbl) or empty_3f(tbl)), "expected a map")
        local function _837_(...)
          tbl[key] = nil
          return tbl
        end
        return hash_map_2a(_837_(...))
      else
        local _ = _836_
        local core_38_auto = require("cljlib")
        local _let_838_ = core_38_auto.list(...)
        local tbl = _let_838_[1]
        local key = _let_838_[2]
        local keys0 = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_838_, 3)
        return apply(dissoc0, dissoc0(tbl, key), keys0)
      end
    end
    v_27_auto = dissoc0
    core["dissoc"] = v_27_auto
    dissoc = v_27_auto
  end
  local merge
  do
    local v_27_auto
    local function merge0(...)
      local core_38_auto = require("cljlib")
      local _let_840_ = core_38_auto.list(...)
      local maps = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_840_, 1)
      if some(identity, maps) then
        local function _841_(a, b)
          local tbl_16_auto = a
          for k, v in pairs_2a(b) do
            local k_17_auto, v_18_auto = k, v
            if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
              tbl_16_auto[k_17_auto] = v_18_auto
            else
            end
          end
          return tbl_16_auto
        end
        return hash_map_2a(itable(reduce(_841_, {}, maps)))
      else
        return nil
      end
    end
    v_27_auto = merge0
    core["merge"] = v_27_auto
    merge = v_27_auto
  end
  local frequencies
  do
    local v_27_auto
    local function frequencies0(...)
      local t = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "frequencies"))
        else
        end
      end
      return hash_map_2a(itable.frequencies(t))
    end
    v_27_auto = frequencies0
    core["frequencies"] = v_27_auto
    frequencies = v_27_auto
  end
  local group_by
  do
    local v_27_auto
    local function group_by0(...)
      local f, t = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "group-by"))
        else
        end
      end
      return hash_map_2a((itable["group-by"](f, t)))
    end
    v_27_auto = group_by0
    core["group-by"] = v_27_auto
    group_by = v_27_auto
  end
  local zipmap
  do
    local v_27_auto
    local function zipmap0(...)
      local keys0, vals0 = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "zipmap"))
        else
        end
      end
      return hash_map_2a(itable(lazy.zipmap(keys0, vals0)))
    end
    v_27_auto = zipmap0
    core["zipmap"] = v_27_auto
    zipmap = v_27_auto
  end
  local replace
  do
    local v_27_auto
    local function replace0(...)
      local _847_ = select("#", ...)
      if (_847_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "replace"))
      elseif (_847_ == 1) then
        local smap = ...
        local function _848_(_241)
          local val_96_auto = find(smap, _241)
          if val_96_auto then
            local e = val_96_auto
            return e[2]
          else
            return _241
          end
        end
        return map(_848_)
      elseif (_847_ == 2) then
        local smap, coll = ...
        if vector_3f(coll) then
          local function _850_(res, v)
            local val_96_auto = find(smap, v)
            if val_96_auto then
              local e = val_96_auto
              table.insert(res, e[2])
              return res
            else
              table.insert(res, v)
              return res
            end
          end
          return vec_2a(itable(reduce(_850_, {}, coll)))
        else
          local function _852_(_241)
            local val_96_auto = find(smap, _241)
            if val_96_auto then
              local e = val_96_auto
              return e[2]
            else
              return _241
            end
          end
          return map(_852_, coll)
        end
      else
        local _ = _847_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "replace"))
      end
    end
    v_27_auto = replace0
    core["replace"] = v_27_auto
    replace = v_27_auto
  end
  local conj
  do
    local v_27_auto
    local function conj0(...)
      local _856_ = select("#", ...)
      if (_856_ == 0) then
        return vector()
      elseif (_856_ == 1) then
        local s = ...
        return s
      elseif (_856_ == 2) then
        local s, x = ...
        local _857_ = getmetatable(s)
        if ((_G.type(_857_) == "table") and (nil ~= _857_["cljlib/conj"])) then
          local f = _857_["cljlib/conj"]
          return f(s, x)
        else
          local _ = _857_
          if vector_3f(s) then
            return vec_2a(itable.insert(s, x))
          elseif map_3f(s) then
            return apply(assoc, s, x)
          elseif nil_3f(s) then
            return cons(x, s)
          elseif empty_3f(s) then
            return vector(x)
          else
            return error("expected collection, got", type(s))
          end
        end
      else
        local _ = _856_
        local core_38_auto = require("cljlib")
        local _let_860_ = core_38_auto.list(...)
        local s = _let_860_[1]
        local x = _let_860_[2]
        local xs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_860_, 3)
        return apply(conj0, conj0(s, x), xs)
      end
    end
    v_27_auto = conj0
    core["conj"] = v_27_auto
    conj = v_27_auto
  end
  local disj
  do
    local v_27_auto
    local function disj0(...)
      local _862_ = select("#", ...)
      if (_862_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "disj"))
      elseif (_862_ == 1) then
        local Set = ...
        return Set
      elseif (_862_ == 2) then
        local Set, key = ...
        local _863_ = getmetatable(Set)
        if ((_G.type(_863_) == "table") and (_863_["cljlib/type"] == "hash-set") and (nil ~= _863_["cljlib/disj"])) then
          local f = _863_["cljlib/disj"]
          return f(Set, key)
        else
          local _ = _863_
          return error(("disj is not supported on " .. class(Set)), 2)
        end
      else
        local _ = _862_
        local core_38_auto = require("cljlib")
        local _let_865_ = core_38_auto.list(...)
        local Set = _let_865_[1]
        local key = _let_865_[2]
        local keys0 = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_865_, 3)
        local _866_ = getmetatable(Set)
        if ((_G.type(_866_) == "table") and (_866_["cljlib/type"] == "hash-set") and (nil ~= _866_["cljlib/disj"])) then
          local f = _866_["cljlib/disj"]
          return apply(f, Set, key, keys0)
        else
          local _0 = _866_
          return error(("disj is not supported on " .. class(Set)), 2)
        end
      end
    end
    v_27_auto = disj0
    core["disj"] = v_27_auto
    disj = v_27_auto
  end
  local pop
  do
    local v_27_auto
    local function pop0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "pop"))
        else
        end
      end
      local _870_ = getmetatable(coll)
      if ((_G.type(_870_) == "table") and (_870_["cljlib/type"] == "seq")) then
        local _871_ = seq(coll)
        if (nil ~= _871_) then
          local s = _871_
          return drop(1, s)
        else
          local _ = _871_
          return error("can't pop empty list", 2)
        end
      elseif ((_G.type(_870_) == "table") and (nil ~= _870_["cljlib/pop"])) then
        local f = _870_["cljlib/pop"]
        return f(coll)
      else
        local _ = _870_
        return error(("pop is not supported on " .. class(coll)), 2)
      end
    end
    v_27_auto = pop0
    core["pop"] = v_27_auto
    pop = v_27_auto
  end
  local transient
  do
    local v_27_auto
    local function transient0(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "transient"))
        else
        end
      end
      local _875_ = getmetatable(coll)
      if ((_G.type(_875_) == "table") and (_875_["cljlib/editable"] == true) and (nil ~= _875_["cljlib/transient"])) then
        local f = _875_["cljlib/transient"]
        return f(coll)
      else
        local _ = _875_
        return error("expected editable collection", 2)
      end
    end
    v_27_auto = transient0
    core["transient"] = v_27_auto
    transient = v_27_auto
  end
  local conj_21
  do
    local v_27_auto
    local function conj_210(...)
      local _877_ = select("#", ...)
      if (_877_ == 0) then
        return transient(vec_2a({}))
      elseif (_877_ == 1) then
        local coll = ...
        return coll
      elseif (_877_ == 2) then
        local coll, x = ...
        do
          local _878_ = getmetatable(coll)
          if ((_G.type(_878_) == "table") and (_878_["cljlib/type"] == "transient") and (nil ~= _878_["cljlib/conj!"])) then
            local f = _878_["cljlib/conj!"]
            f(coll, x)
          elseif ((_G.type(_878_) == "table") and (_878_["cljlib/type"] == "transient")) then
            error("unsupported transient operation", 2)
          else
            local _ = _878_
            error("expected transient collection", 2)
          end
        end
        return coll
      else
        local _ = _877_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "conj!"))
      end
    end
    v_27_auto = conj_210
    core["conj!"] = v_27_auto
    conj_21 = v_27_auto
  end
  local assoc_21
  do
    local v_27_auto
    local function assoc_210(...)
      local core_38_auto = require("cljlib")
      local _let_881_ = core_38_auto.list(...)
      local map0 = _let_881_[1]
      local k = _let_881_[2]
      local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_881_, 3)
      do
        local _882_ = getmetatable(map0)
        if ((_G.type(_882_) == "table") and (_882_["cljlib/type"] == "transient") and (nil ~= _882_["cljlib/dissoc!"])) then
          local f = _882_["cljlib/dissoc!"]
          apply(f, map0, k, ks)
        elseif ((_G.type(_882_) == "table") and (_882_["cljlib/type"] == "transient")) then
          error("unsupported transient operation", 2)
        else
          local _ = _882_
          error("expected transient collection", 2)
        end
      end
      return map0
    end
    v_27_auto = assoc_210
    core["assoc!"] = v_27_auto
    assoc_21 = v_27_auto
  end
  local dissoc_21
  do
    local v_27_auto
    local function dissoc_210(...)
      local core_38_auto = require("cljlib")
      local _let_884_ = core_38_auto.list(...)
      local map0 = _let_884_[1]
      local k = _let_884_[2]
      local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_884_, 3)
      do
        local _885_ = getmetatable(map0)
        if ((_G.type(_885_) == "table") and (_885_["cljlib/type"] == "transient") and (nil ~= _885_["cljlib/dissoc!"])) then
          local f = _885_["cljlib/dissoc!"]
          apply(f, map0, k, ks)
        elseif ((_G.type(_885_) == "table") and (_885_["cljlib/type"] == "transient")) then
          error("unsupported transient operation", 2)
        else
          local _ = _885_
          error("expected transient collection", 2)
        end
      end
      return map0
    end
    v_27_auto = dissoc_210
    core["dissoc!"] = v_27_auto
    dissoc_21 = v_27_auto
  end
  local disj_21
  do
    local v_27_auto
    local function disj_210(...)
      local _887_ = select("#", ...)
      if (_887_ == 0) then
        return error(("Wrong number of args (%s) passed to %s"):format(0, "disj!"))
      elseif (_887_ == 1) then
        local Set = ...
        return Set
      else
        local _ = _887_
        local core_38_auto = require("cljlib")
        local _let_888_ = core_38_auto.list(...)
        local Set = _let_888_[1]
        local key = _let_888_[2]
        local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_888_, 3)
        local _889_ = getmetatable(Set)
        if ((_G.type(_889_) == "table") and (_889_["cljlib/type"] == "transient") and (nil ~= _889_["cljlib/disj!"])) then
          local f = _889_["cljlib/disj!"]
          return apply(f, Set, key, ks)
        elseif ((_G.type(_889_) == "table") and (_889_["cljlib/type"] == "transient")) then
          return error("unsupported transient operation", 2)
        else
          local _0 = _889_
          return error("expected transient collection", 2)
        end
      end
    end
    v_27_auto = disj_210
    core["disj!"] = v_27_auto
    disj_21 = v_27_auto
  end
  local pop_21
  do
    local v_27_auto
    local function pop_210(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "pop!"))
        else
        end
      end
      local _893_ = getmetatable(coll)
      if ((_G.type(_893_) == "table") and (_893_["cljlib/type"] == "transient") and (nil ~= _893_["cljlib/pop!"])) then
        local f = _893_["cljlib/pop!"]
        return f(coll)
      elseif ((_G.type(_893_) == "table") and (_893_["cljlib/type"] == "transient")) then
        return error("unsupported transient operation", 2)
      else
        local _ = _893_
        return error("expected transient collection", 2)
      end
    end
    v_27_auto = pop_210
    core["pop!"] = v_27_auto
    pop_21 = v_27_auto
  end
  local persistent_21
  do
    local v_27_auto
    local function persistent_210(...)
      local coll = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "persistent!"))
        else
        end
      end
      local _896_ = getmetatable(coll)
      if ((_G.type(_896_) == "table") and (_896_["cljlib/type"] == "transient") and (nil ~= _896_["cljlib/persistent!"])) then
        local f = _896_["cljlib/persistent!"]
        return f(coll)
      else
        local _ = _896_
        return error("expected transient collection", 2)
      end
    end
    v_27_auto = persistent_210
    core["persistent!"] = v_27_auto
    persistent_21 = v_27_auto
  end
  local into
  do
    local v_27_auto
    local function into0(...)
      local _898_ = select("#", ...)
      if (_898_ == 0) then
        return vector()
      elseif (_898_ == 1) then
        local to = ...
        return to
      elseif (_898_ == 2) then
        local to, from = ...
        local _899_ = getmetatable(to)
        if ((_G.type(_899_) == "table") and (_899_["cljlib/editable"] == true)) then
          return persistent_21(reduce(conj_21, transient(to), from))
        else
          local _ = _899_
          return reduce(conj, to, from)
        end
      elseif (_898_ == 3) then
        local to, xform, from = ...
        local _901_ = getmetatable(to)
        if ((_G.type(_901_) == "table") and (_901_["cljlib/editable"] == true)) then
          return persistent_21(transduce(xform, conj_21, transient(to), from))
        else
          local _ = _901_
          return transduce(xform, conj, to, from)
        end
      else
        local _ = _898_
        return error(("Wrong number of args (%s) passed to %s"):format(_, "into"))
      end
    end
    v_27_auto = into0
    core["into"] = v_27_auto
    into = v_27_auto
  end
  local function viewset(Set, view, inspector, indent)
    if inspector.seen[Set] then
      return ("@set" .. inspector.seen[Set] .. "{...}")
    else
      local prefix
      local _904_
      if inspector["visible-cycle?"](Set) then
        _904_ = inspector.seen[Set]
      else
        _904_ = ""
      end
      prefix = ("@set" .. _904_ .. "{")
      local set_indent = #prefix
      local indent_str = string.rep(" ", set_indent)
      local lines
      do
        local tbl_21_auto = {}
        local i_22_auto = 0
        for v in pairs_2a(Set) do
          local val_23_auto = (indent_str .. view(v, inspector, (indent + set_indent), true))
          if (nil ~= val_23_auto) then
            i_22_auto = (i_22_auto + 1)
            tbl_21_auto[i_22_auto] = val_23_auto
          else
          end
        end
        lines = tbl_21_auto
      end
      lines[1] = (prefix .. string.gsub((lines[1] or ""), "^%s+", ""))
      lines[#lines] = (lines[#lines] .. "}")
      return lines
    end
  end
  local function hash_set__3etransient(immutable)
    local function _908_(hset)
      local removed = setmetatable({}, {__index = deep_index})
      local function _909_(_, k)
        if not removed[k] then
          return hset[k]
        else
          return nil
        end
      end
      local function _911_()
        return error("can't `conj` onto transient set, use `conj!`")
      end
      local function _912_()
        return error("can't `disj` a transient set, use `disj!`")
      end
      local function _913_()
        return error("can't `assoc` onto transient set, use `assoc!`")
      end
      local function _914_()
        return error("can't `dissoc` onto transient set, use `dissoc!`")
      end
      local function _915_(thset, v)
        if (nil == v) then
          removed[v] = true
        else
          removed[v] = nil
        end
        thset[v] = v
        return thset
      end
      local function _917_()
        return error("can't `dissoc!` a transient set")
      end
      local function _918_(thset, ...)
        for i = 1, select("#", ...) do
          local k = select(i, ...)
          thset[k] = nil
          removed[k] = true
        end
        return thset
      end
      local function _919_(thset)
        local t
        do
          local tbl_16_auto
          do
            local tbl_16_auto0 = {}
            for k, v in pairs(hset) do
              local k_17_auto, v_18_auto = k, v
              if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
                tbl_16_auto0[k_17_auto] = v_18_auto
              else
              end
            end
            tbl_16_auto = tbl_16_auto0
          end
          for k, v in pairs(thset) do
            local k_17_auto, v_18_auto = k, v
            if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
              tbl_16_auto[k_17_auto] = v_18_auto
            else
            end
          end
          t = tbl_16_auto
        end
        for k in pairs(removed) do
          t[k] = nil
        end
        local function _922_()
          local tbl_21_auto = {}
          local i_22_auto = 0
          for k in pairs_2a(thset) do
            local val_23_auto = k
            if (nil ~= val_23_auto) then
              i_22_auto = (i_22_auto + 1)
              tbl_21_auto[i_22_auto] = val_23_auto
            else
            end
          end
          return tbl_21_auto
        end
        for _, k in ipairs(_922_()) do
          thset[k] = nil
        end
        local function _924_()
          return error("attempt to use transient after it was persistet")
        end
        local function _925_()
          return error("attempt to use transient after it was persistet")
        end
        setmetatable(thset, {__index = _924_, __newindex = _925_})
        return immutable(itable(t))
      end
      return setmetatable({}, {__index = _909_, ["cljlib/type"] = "transient", ["cljlib/conj"] = _911_, ["cljlib/disj"] = _912_, ["cljlib/assoc"] = _913_, ["cljlib/dissoc"] = _914_, ["cljlib/conj!"] = _915_, ["cljlib/assoc!"] = _917_, ["cljlib/disj!"] = _918_, ["cljlib/persistent!"] = _919_})
    end
    return _908_
  end
  local function hash_set_2a(x)
    do
      local _926_ = getmetatable(x)
      if (nil ~= _926_) then
        local mt = _926_
        mt["cljlib/type"] = "hash-set"
        local function _927_(s, v, ...)
          local function _928_(...)
            local res = {}
            for _, v0 in ipairs({...}) do
              table.insert(res, v0)
              table.insert(res, v0)
            end
            return res
          end
          return hash_set_2a(itable.assoc(s, v, v, unpack_2a(_928_(...))))
        end
        mt["cljlib/conj"] = _927_
        local function _929_(s, k, ...)
          local to_remove
          do
            local tbl_16_auto = setmetatable({[k] = true}, {__index = deep_index})
            for _, k0 in ipairs({...}) do
              local k_17_auto, v_18_auto = k0, true
              if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
                tbl_16_auto[k_17_auto] = v_18_auto
              else
              end
            end
            to_remove = tbl_16_auto
          end
          local function _931_(...)
            local res = {}
            for _, v in pairs(s) do
              if not to_remove[v] then
                table.insert(res, v)
                table.insert(res, v)
              else
              end
            end
            return res
          end
          return hash_set_2a(itable.assoc({}, unpack_2a(_931_(...))))
        end
        mt["cljlib/disj"] = _929_
        local function _933_()
          return hash_set_2a(itable({}))
        end
        mt["cljlib/empty"] = _933_
        mt["cljlib/editable"] = true
        mt["cljlib/transient"] = hash_set__3etransient(hash_set_2a)
        local function _934_(s)
          local function _935_(_241)
            if vector_3f(_241) then
              return _241[1]
            else
              return _241
            end
          end
          return map(_935_, s)
        end
        mt["cljlib/seq"] = _934_
        mt["__fennelview"] = viewset
        local function _937_(s, i)
          local j = 1
          local vals0 = {}
          for v in pairs_2a(s) do
            if (j >= i) then
              table.insert(vals0, v)
            else
              j = (j + 1)
            end
          end
          return core["hash-set"](unpack_2a(vals0))
        end
        mt["__fennelrest"] = _937_
      else
        local _ = _926_
        hash_set_2a(setmetatable(x, {}))
      end
    end
    return x
  end
  local hash_set
  do
    local v_27_auto
    local function hash_set0(...)
      local core_38_auto = require("cljlib")
      local _let_940_ = core_38_auto.list(...)
      local xs = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_940_, 1)
      local Set
      do
        local tbl_16_auto = setmetatable({}, {__newindex = deep_newindex})
        for _, val in pairs_2a(xs) do
          local k_17_auto, v_18_auto = val, val
          if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
            tbl_16_auto[k_17_auto] = v_18_auto
          else
          end
        end
        Set = tbl_16_auto
      end
      return hash_set_2a(itable(Set))
    end
    v_27_auto = hash_set0
    core["hash-set"] = v_27_auto
    hash_set = v_27_auto
  end
  local multifn_3f
  do
    local v_27_auto
    local function multifn_3f0(...)
      local mf = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "multifn?"))
        else
        end
      end
      local _943_ = getmetatable(mf)
      if ((_G.type(_943_) == "table") and (_943_["cljlib/type"] == "multifn")) then
        return true
      else
        local _ = _943_
        return false
      end
    end
    v_27_auto = multifn_3f0
    core["multifn?"] = v_27_auto
    multifn_3f = v_27_auto
  end
  local remove_method
  do
    local v_27_auto
    local function remove_method0(...)
      local multimethod, dispatch_value = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "remove-method"))
        else
        end
      end
      if multifn_3f(multimethod) then
        multimethod[dispatch_value] = nil
      else
        error((tostring(multimethod) .. " is not a multifn"), 2)
      end
      return multimethod
    end
    v_27_auto = remove_method0
    core["remove-method"] = v_27_auto
    remove_method = v_27_auto
  end
  local remove_all_methods
  do
    local v_27_auto
    local function remove_all_methods0(...)
      local multimethod = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "remove-all-methods"))
        else
        end
      end
      if multifn_3f(multimethod) then
        for k, _ in pairs(multimethod) do
          multimethod[k] = nil
        end
      else
        error((tostring(multimethod) .. " is not a multifn"), 2)
      end
      return multimethod
    end
    v_27_auto = remove_all_methods0
    core["remove-all-methods"] = v_27_auto
    remove_all_methods = v_27_auto
  end
  local methods
  do
    local v_27_auto
    local function methods0(...)
      local multimethod = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "methods"))
        else
        end
      end
      if multifn_3f(multimethod) then
        local m = {}
        for k, v in pairs(multimethod) do
          m[k] = v
        end
        return m
      else
        return error((tostring(multimethod) .. " is not a multifn"), 2)
      end
    end
    v_27_auto = methods0
    core["methods"] = v_27_auto
    methods = v_27_auto
  end
  local get_method
  do
    local v_27_auto
    local function get_method0(...)
      local multimethod, dispatch_value = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "get-method"))
        else
        end
      end
      if multifn_3f(multimethod) then
        return (multimethod[dispatch_value] or multimethod.default)
      else
        return error((tostring(multimethod) .. " is not a multifn"), 2)
      end
    end
    v_27_auto = get_method0
    core["get-method"] = v_27_auto
    get_method = v_27_auto
  end
  return core
end
package.preload["defaults"] = package.preload["defaults"] or function(...)
  local function _953_()
    return "#<namespace: defaults>"
  end
  local _local_954_ = {setmetatable({}, {__fennelview = _953_, __name = "namespace"})}
  local defaults = _local_954_[1]
  hs.hints.style = "vimperator"
  hs.hints.showTitleThresh = 4
  hs.hints.titleMaxSize = 10
  hs.hints.fontSize = 30
  hs.window.animationDuration = 0.2
  return defaults
end
package.preload["config"] = package.preload["config"] or function(...)
  local function _955_()
    return "#<namespace: config>"
  end
  local _local_1180_ = {setmetatable({}, {__fennelview = _955_, __name = "namespace"}), require("windows"), require("emacs"), require("slack"), require("lib.functional"), require("spoons"), require("active-space-indicator"), require("window-ops")}
  local config = _local_1180_[1]
  local windows = _local_1180_[2]
  local emacs = _local_1180_[3]
  local slack = _local_1180_[4]
  local _local_1181_ = _local_1180_[5]
  local concat = _local_1181_["concat"]
  local spoons = _local_1180_[6]
  local active_space_indicator = _local_1180_[7]
  local window_ops = _local_1180_[8]
  local function activator(app_name)
    local function _1182_()
      return windows["activate-app"](app_name)
    end
    return _1182_
  end
  local music_app = "Spotify"
  local _return = {key = "space", title = "Back", action = "previous"}
  local window_jumps = {{mods = {"cmd"}, key = "hjkl", title = "Jump"}, {mods = {"cmd"}, key = "h", action = "windows:jump-window-left", repeatable = true}, {mods = {"cmd"}, key = "j", action = "windows:jump-window-above", repeatable = true}, {mods = {"cmd"}, key = "k", action = "windows:jump-window-below", repeatable = true}, {mods = {"cmd"}, key = "l", action = "windows:jump-window-right", repeatable = true}}
  local window_halves = {{key = "hjkl", title = "Halves"}, {key = "h", action = "windows:resize-half-left", repeatable = true}, {key = "j", action = "windows:resize-half-bottom", repeatable = true}, {key = "k", action = "windows:resize-half-top", repeatable = true}, {key = "l", action = "windows:resize-half-right", repeatable = true}}
  local window_increments = {{mods = {"alt"}, key = "hjkl", title = "Increments"}, {mods = {"alt"}, key = "h", action = "windows:resize-inc-left", repeatable = true}, {mods = {"alt"}, key = "j", action = "windows:resize-inc-bottom", repeatable = true}, {mods = {"alt"}, key = "k", action = "windows:resize-inc-top", repeatable = true}, {mods = {"alt"}, key = "l", action = "windows:resize-inc-right", repeatable = true}}
  local window_resize = {{mods = {"shift"}, key = "hjkl", title = "Resize"}, {mods = {"shift"}, key = "h", action = "windows:resize-left", repeatable = true}, {mods = {"shift"}, key = "j", action = "windows:resize-down", repeatable = true}, {mods = {"shift"}, key = "k", action = "windows:resize-up", repeatable = true}, {mods = {"shift"}, key = "l", action = "windows:resize-right", repeatable = true}}
  local window_move_screens = {{key = "n, p", title = "Move next\\previous screen"}, {mods = {"shift"}, key = "n, p", title = "Move up\\down screens"}, {key = "n", action = "windows:move-south", repeatable = true}, {key = "p", action = "windows:move-north", repeatable = true}, {mods = {"shift"}, key = "n", action = "windows:move-west", repeatable = true}, {mods = {"shift"}, key = "p", action = "windows:move-east", repeatable = true}}
  local window_bindings = concat({_return, {key = "w", title = "Last Window", action = "windows:jump-to-last-window"}}, window_jumps, window_halves, window_increments, window_resize, window_move_screens, {{key = "m", title = "Maximize", action = "windows:maximize-window-frame"}, {key = "c", title = "Center", action = "windows:center-window-frame"}, {key = "g", title = "Grid", action = "windows:show-grid"}, {key = "u", title = "Undo", action = "windows:undo"}})
  local app_bindings = {_return, {key = "e", title = "Emacs", action = activator("Emacs")}, {key = "g", title = "Chrome", action = activator("Google Chrome")}, {key = "f", title = "Firefox", action = activator("Firefox")}, {key = "i", title = "iTerm", action = activator("iterm")}, {key = "s", title = "Slack", action = activator("Slack")}, {key = "b", title = "Brave", action = activator("brave browser")}, {key = "m", title = music_app, action = activator(music_app)}}
  local media_bindings = {_return, {key = "s", title = "Play or Pause", action = "multimedia:play-or-pause"}, {key = "h", title = "Prev Track", action = "multimedia:prev-track"}, {key = "l", title = "Next Track", action = "multimedia:next-track"}, {key = "j", title = "Volume Down", action = "multimedia:volume-down", repeatable = true}, {key = "k", title = "Volume Up", action = "multimedia:volume-up", repeatable = true}, {key = "a", title = ("Launch " .. music_app), action = activator(music_app)}}
  local emacs_bindings
  local function _1183_()
    return emacs.capture()
  end
  local function _1184_()
    return emacs.note()
  end
  emacs_bindings = {_return, {key = "c", title = "Capture", action = _1183_}, {key = "z", title = "Note", action = _1184_}, {key = "v", title = "Split", action = "emacs:vertical-split-with-emacs"}, {key = "f", title = "Full Screen", action = "emacs:full-screen"}}
  local yabai_bindings
  local function _1185_()
    return hs.execute("yabai --start-service", true)
  end
  local function _1186_()
    return hs.execute("yabai --stop-service", true)
  end
  local function _1187_()
    return hs.execute("yabai --restart-service", true)
  end
  yabai_bindings = {_return, {key = "e", title = "Enable", action = _1185_}, {key = "d", title = "Disable", action = _1186_}, {key = "r", title = "Restart", action = _1187_}}
  local menu_items = {{key = "space", title = "Alfred", action = activator("Alfred 4")}, {key = "w", title = "Window", enter = "windows:enter-window-menu", exit = "windows:exit-window-menu", items = window_bindings}, {key = "a", title = "Apps", items = app_bindings}, {key = "j", title = "Jump", action = "windows:jump"}, {key = "m", title = "Media", items = media_bindings}, {key = "x", title = "Emacs", items = emacs_bindings}, {key = "y", title = "Yabai", items = yabai_bindings}}
  local common_keys = {{mods = {"alt"}, key = "space", action = "lib.modal:activate-modal"}, {mods = {"cmd", "alt"}, key = "n", action = "app-switcher:next-app"}, {mods = {"cmd", "alt"}, key = "p", action = "app-switcher:prev-app"}, {mods = {"cmd", "ctrl"}, key = "`", action = hs.toggleConsole}, {mods = {"cmd", "ctrl"}, key = "o", action = "emacs:edit-with-emacs"}}
  local browser_keys = {{mods = {"cmd", "shift"}, key = "l", action = "chrome:open-location"}, {mods = {"alt"}, key = "k", action = "chrome:next-tab", ["repeat"] = true}, {mods = {"alt"}, key = "j", action = "chrome:prev-tab", ["repeat"] = true}}
  local browser_items = concat(menu_items, {{key = "'", title = "Edit with Emacs", action = "emacs:edit-with-emacs"}})
  local brave_config = {key = "Brave Browser", keys = browser_keys, items = browser_items}
  local chrome_config = {key = "Google Chrome", keys = browser_keys, items = browser_items}
  local firefox_config = {key = "Firefox", keys = browser_keys, items = browser_items}
  local grammarly_config = {key = "Grammarly", items = concat(menu_items, {{mods = {"ctrl"}, key = "c", title = "Return to Emacs", action = "grammarly:back-to-emacs"}}), keys = ""}
  local hammerspoon_config = {key = "Hammerspoon", items = concat(menu_items, {{key = "r", title = "Reload Console", action = hs.reload}, {key = "c", title = "Clear Console", action = hs.console.clearConsole}}), keys = {}}
  local slack_config = {key = "Slack", keys = {{mods = {"cmd"}, key = "g", action = "slack:scroll-to-bottom"}, {mods = {"ctrl"}, key = "r", action = "slack:add-reaction"}, {mods = {"ctrl"}, key = "h", action = "slack:prev-element"}, {mods = {"ctrl"}, key = "l", action = "slack:next-element"}, {mods = {"ctrl"}, key = "t", action = "slack:thread"}, {mods = {"ctrl"}, key = "p", action = "slack:prev-day"}, {mods = {"ctrl"}, key = "n", action = "slack:next-day"}, {mods = {"ctrl"}, key = "e", action = "slack:scroll-up", ["repeat"] = true}, {mods = {"ctrl"}, key = "y", action = "slack:scroll-down", ["repeat"] = true}, {mods = {"ctrl"}, key = "i", action = "slack:next-history", ["repeat"] = true}, {mods = {"ctrl"}, key = "o", action = "slack:prev-history", ["repeat"] = true}, {mods = {"ctrl"}, key = "j", action = "slack:down", ["repeat"] = true}, {mods = {"ctrl"}, key = "k", action = "slack:up", ["repeat"] = true}}}
  local apps = {brave_config, chrome_config, firefox_config, grammarly_config, hammerspoon_config, slack_config}
  local config0
  local function _1188_()
    return windows["hide-display-numbers"]()
  end
  local function _1189_()
    return windows["hide-display-numbers"]()
  end
  config0 = {title = "Main Menu", items = menu_items, keys = common_keys, enter = _1188_, exit = _1189_, apps = apps, modules = {windows = {["center-ratio"] = "80:50"}}}
  repl = require("repl")
  repl.run(repl.start())
  return config0
end
package.preload["windows"] = package.preload["windows"] or function(...)
  local function _956_()
    return "#<namespace: window>"
  end
  local _local_985_ = {setmetatable({}, {__fennelview = _956_, __name = "namespace"}), require("lib.functional"), require("lib.utils"), require("lib.atom"), require("hs.canvas")}
  local window = _local_985_[1]
  local _local_986_ = _local_985_[2]
  local concat = _local_986_["concat"]
  local contains_3f = _local_986_["contains?"]
  local count = _local_986_["count"]
  local filter = _local_986_["filter"]
  local for_each = _local_986_["for-each"]
  local get_in = _local_986_["get-in"]
  local map = _local_986_["map"]
  local split = _local_986_["split"]
  local _local_987_ = _local_985_[3]
  local global_filter = _local_987_["global-filter"]
  local _local_988_ = _local_985_[4]
  local atom = _local_988_["atom"]
  local deref = _local_988_["deref"]
  local reset_21 = _local_988_["reset!"]
  local swap_21 = _local_988_["swap!"]
  local canvas = _local_985_[5]
  history = {}
  history.push = function(self)
    local win = hs.window.focusedWindow()
    local id
    if win then
      id = win:id()
    else
      id = nil
    end
    local tbl = self[id]
    if win then
      if (type(tbl) == "nil") then
        self[id] = {win:frame()}
        return nil
      else
        local last_el = tbl[#tbl]
        if (last_el ~= win:frame()) then
          return table.insert(tbl, win:frame())
        else
          return nil
        end
      end
    else
      return nil
    end
  end
  history.pop = function(self)
    local win = hs.window.focusedWindow()
    local id
    if win then
      id = win:id()
    else
      id = nil
    end
    local tbl = self[id]
    if (win and tbl) then
      local el = table.remove(tbl)
      local num_of_undos = #tbl
      if el then
        win:setFrame(el)
        if (0 < num_of_undos) then
          return hs.alert((num_of_undos .. " undo steps available"))
        else
          return nil
        end
      else
        return hs.alert("nothing to undo")
      end
    else
      return nil
    end
  end
  local function undo()
    return history:pop()
  end
  local highlight_active_window
  do
    local adv_1_auto = require("lib.advice")
    local function _1024_()
      local rect = hs.drawing.rectangle(hs.window.focusedWindow():frame())
      rect:setStrokeColor({red = 1, blue = 0, green = 1, alpha = 1})
      rect:setStrokeWidth(5)
      rect:setFill(false)
      rect:show()
      local function _1025_()
        return rect:delete()
      end
      return hs.timer.doAfter(0.3, _1025_)
    end
    highlight_active_window = adv_1_auto["make-advisable"]("highlight-active-window", _1024_)
  end
  local function maximize_window_frame()
    history:push()
    hs.window.focusedWindow():maximize(0)
    return highlight_active_window()
  end
  local position_window_center
  do
    local adv_1_auto = require("lib.advice")
    local function _1026_(ratio_str, window0, screen)
      local frame = screen:fullFrame()
      local _let_1027_ = split(":", ratio_str)
      local w_percent = _let_1027_[1]
      local h_percent = _let_1027_[2]
      local w_percent0 = (tonumber(w_percent) / 100)
      local h_percent0 = (tonumber(h_percent) / 100)
      local update = {w = (w_percent0 * frame.w), h = (h_percent0 * frame.h), x = 0, y = 0}
      do
        window0:setFrameInScreenBounds(update)
        window0:centerOnScreen()
      end
      return highlight_active_window()
    end
    position_window_center = adv_1_auto["make-advisable"]("position-window-center", _1026_)
  end
  local function center_window_frame()
    history:push()
    local win = hs.window.focusedWindow()
    local prev_duration = hs.window.animationDuration
    local config = require("config")
    local ratio
    local _1029_
    do
      local t_1028_ = config
      if (nil ~= t_1028_) then
        t_1028_ = t_1028_.modules
      else
      end
      if (nil ~= t_1028_) then
        t_1028_ = t_1028_.windows
      else
      end
      if (nil ~= t_1028_) then
        t_1028_ = t_1028_["center-ratio"]
      else
      end
      _1029_ = t_1028_
    end
    ratio = (_1029_ or "80:50")
    local screen = hs.screen.primaryScreen()
    hs.window["animationDuration"] = 0
    position_window_center(ratio, win, screen)
    hs.window["animationDuration"] = prev_duration
    return nil
  end
  local function activate_app(app_name)
    hs.application.launchOrFocus(app_name)
    local app = hs.application.find(app_name)
    if app then
      app:activate()
      hs.timer.doAfter(0.05, highlight_active_window)
      return app:unhide()
    else
      return nil
    end
  end
  local function set_mouse_cursor_at(app_title)
    local sf = hs.application.find(app_title):focusedWindow():frame()
    local desired_point = hs.geometry.point(((sf._x + sf._w) - (sf._w / 2)), ((sf._y + sf._h) - (sf._h / 2)))
    return hs.mouse.setAbsolutePosition(desired_point)
  end
  local function show_grid()
    history:push()
    return hs.grid.show()
  end
  local function jump_to_last_window()
    return global_filter():getWindows(hs.window.filter.sortByFocusedLast)[2]:focus()
  end
  local function jump_window(arrow)
    local dir = {h = "West", j = "South", k = "North", l = "East"}
    local frontmost_win = hs.window.frontmostWindow()
    local focus_dir = ("focusWindow" .. dir[arrow])
    hs.window.filter.defaultCurrentSpace[focus_dir](hs.window.filter.defaultCurrentSpace, frontmost_win, true, true)
    return highlight_active_window()
  end
  local function jump_window_left()
    return jump_window("h")
  end
  local function jump_window_above()
    return jump_window("j")
  end
  local function jump_window_below()
    return jump_window("k")
  end
  local function jump_window_right()
    return jump_window("l")
  end
  local function allowed_app_3f(window0)
    return window0:isStandard()
  end
  local function jump()
    local wns = filter(allowed_app_3f, hs.window.allWindows())
    return hs.hints.windowHints(wns, nil, true)
  end
  local arrow_map = {k = {half = {0, 0, 1, 0.5}, movement = {0, -20}, complement = "h", resize = "Shorter"}, j = {half = {0, 0.5, 1, 0.5}, movement = {0, 20}, complement = "l", resize = "Taller"}, h = {half = {0, 0, 0.5, 1}, movement = {-20, 0}, complement = "j", resize = "Thinner"}, l = {half = {0.5, 0, 0.5, 1}, movement = {20, 0}, complement = "k", resize = "Wider"}}
  local function grid(method, direction)
    local fn_name = (method .. direction)
    local f = hs.grid[fn_name]
    return f(hs.window.focusedWindow())
  end
  local function rect(rct)
    history:push()
    local win = hs.window.focusedWindow()
    if win then
      return win:move(rct)
    else
      return nil
    end
  end
  local function resize_window_halve(arrow)
    history:push()
    return rect(arrow_map[arrow].half)
  end
  local function resize_half_left()
    return resize_window_halve("h")
  end
  local function resize_half_right()
    return resize_window_halve("l")
  end
  local function resize_half_top()
    return resize_window_halve("k")
  end
  local function resize_half_bottom()
    return resize_window_halve("j")
  end
  local function resize_by_increment(arrow)
    local directions = {h = "Left", j = "Down", k = "Up", l = "Right"}
    history:push()
    if ((arrow == "h") or (arrow == "l")) then
      hs.grid.resizeWindowThinner(hs.window.focusedWindow())
    else
    end
    if ((arrow == "j") or (arrow == "k")) then
      hs.grid.resizeWindowShorter(hs.window.focusedWindow())
    else
    end
    return grid("pushWindow", directions[arrow])
  end
  local function resize_inc_left()
    return resize_by_increment("h")
  end
  local function resize_inc_bottom()
    return resize_by_increment("j")
  end
  local function resize_inc_top()
    return resize_by_increment("k")
  end
  local function resize_inc_right()
    return resize_by_increment("l")
  end
  local function resize_window(arrow)
    history:push()
    return grid("resizeWindow", arrow_map[arrow].resize)
  end
  local function resize_left()
    return resize_window("h")
  end
  local function resize_up()
    return resize_window("j")
  end
  local function resize_down()
    return resize_window("k")
  end
  local function resize_right()
    return resize_window("l")
  end
  local function resize_to_grid(grid0)
    history:push()
    return hs.grid.set(hs.window.focusedWindow(), grid0)
  end
  local function move_to_screen(screen)
    local w = hs.window.focusedWindow()
    local no_resize = true
    return w:moveToScreen(screen, no_resize)
  end
  local function move_screen(method)
    local window0 = hs.window.focusedWindow()
    return window0[method](window0, nil, true)
  end
  local function move_north()
    return move_screen("moveOneScreenNorth")
  end
  local function move_south()
    return move_screen("moveOneScreenSouth")
  end
  local function move_east()
    return move_screen("moveOneScreenEast")
  end
  local function move_west()
    return move_screen("moveOneScreenWest")
  end
  local screen_number_canvases = atom({})
  local function show_display_number(idx, screen)
    local cs = canvas.new({})
    local font_size = (screen:frame().w / 10)
    local function _1037_(t)
      return concat(t, {cs})
    end
    swap_21(screen_number_canvases, _1037_)
    cs:frame(screen:frame())
    cs:appendElements({{action = "fill", type = "text", frame = {x = "0.93", y = 0, h = "1", w = "1"}, text = hs.styledtext.new(idx, {font = {size = font_size}, color = {red = 1, green = 0.5, blue = 0, alpha = 1}}), withShadow = true}})
    cs:show()
    return cs
  end
  local function show_display_numbers(screens)
    local ss = hs.screen.allScreens()
    if (1 < count(ss)) then
      for idx, display in ipairs(hs.screen.allScreens()) do
        show_display_number(idx, display)
      end
      return nil
    else
      return nil
    end
  end
  local function hide_display_numbers()
    local function _1039_(c)
      return c:delete(0.4)
    end
    for_each(_1039_, deref(screen_number_canvases))
    return reset_21(screen_number_canvases, {})
  end
  local function monitor_item(screen, i)
    local function _1040_()
      if screen then
        return move_to_screen(screen)
      else
        return nil
      end
    end
    return {title = ("Monitor " .. i), key = tostring(i), group = "monitor", action = _1040_}
  end
  local function remove_monitor_items(menu)
    local function _1042_(_241)
      return not (_241.group == "monitor")
    end
    menu["items"] = filter(_1042_, menu.items)
    return menu
  end
  local function add_monitor_items(menu, screens)
    menu["items"] = concat(menu.items, map(monitor_item, screens))
    return menu
  end
  local function enter_window_menu(menu)
    do
      local screens = hs.screen.allScreens()
      hide_display_numbers()
      show_display_numbers(screens)
      remove_monitor_items(menu)
      add_monitor_items(menu, screens)
    end
    return menu
  end
  local function exit_window_menu(menu)
    hide_display_numbers()
    return menu
  end
  local function init(config)
    hs.grid.setMargins((get_in({"grid", "margins"}, config) or {0, 0}))
    return hs.grid.setGrid((get_in({"grid", "size"}, config) or "3x2"))
  end
  return {["activate-app"] = activate_app, ["center-window-frame"] = center_window_frame, ["enter-window-menu"] = enter_window_menu, ["exit-window-menu"] = exit_window_menu, ["hide-display-numbers"] = hide_display_numbers, ["highlight-active-window"] = highlight_active_window, init = init, jump = jump, ["jump-to-last-window"] = jump_to_last_window, ["jump-window-above"] = jump_window_above, ["jump-window-below"] = jump_window_below, ["jump-window-left"] = jump_window_left, ["jump-window-right"] = jump_window_right, ["maximize-window-frame"] = maximize_window_frame, ["move-east"] = move_east, ["move-north"] = move_north, ["move-south"] = move_south, ["move-to-screen"] = move_to_screen, ["move-west"] = move_west, ["position-window-center"] = position_window_center, rect = rect, ["resize-down"] = resize_down, ["resize-half-bottom"] = resize_half_bottom, ["resize-half-left"] = resize_half_left, ["resize-half-right"] = resize_half_right, ["resize-half-top"] = resize_half_top, ["resize-inc-bottom"] = resize_inc_bottom, ["resize-inc-left"] = resize_inc_left, ["resize-inc-right"] = resize_inc_right, ["resize-inc-top"] = resize_inc_top, ["resize-left"] = resize_left, ["resize-right"] = resize_right, ["resize-up"] = resize_up, ["resize-to-grid"] = resize_to_grid, ["set-mouse-cursor-at"] = set_mouse_cursor_at, ["show-display-numbers"] = show_display_numbers, ["show-grid"] = show_grid, undo = undo}
end
package.preload["lib.functional"] = package.preload["lib.functional"] or function(...)
  local function _957_()
    return "#<namespace: functional>"
  end
  local _local_958_ = {setmetatable({}, {__fennelview = _957_, __name = "namespace"})}
  local functional = _local_958_[1]
  local fu = hs.fnutils
  local function call_when(f, ...)
    if (f and (type(f) == "function")) then
      return f(...)
    else
      return nil
    end
  end
  local function compose(...)
    local fs = {...}
    local total = #fs
    local function _960_(v)
      local res = v
      for i = 0, (total - 1) do
        local f = fs[(total - i)]
        res = f(res)
      end
      return res
    end
    return _960_
  end
  local function contains_3f(x, xs)
    return (xs and fu.contains(xs, x))
  end
  local function find(f, tbl)
    return fu.find(tbl, f)
  end
  local function get(prop_name, tbl)
    if tbl then
      return prop_name[tbl]
    else
      local function _961_(tbl0)
        return tbl0[prop_name]
      end
      return _961_
    end
  end
  local function has_some_3f(list)
    return (list and (0 < #list))
  end
  local function identity(x)
    return x
  end
  local function join(sep, list)
    return table.concat(list, sep)
  end
  local function first(list)
    return list[1]
  end
  local function last(list)
    return list[#list]
  end
  local function logf(...)
    local prefixes = {...}
    local function _963_(x)
      return print(table.unpack(prefixes), hs.inspect(x))
    end
    return _963_
  end
  local function noop()
    return nil
  end
  local function range(start, _end)
    local t = {}
    for i = start, _end do
      table.insert(t, i)
    end
    return t
  end
  local function slice_end_idx(end_pos, list)
    if (end_pos < 0) then
      return (#list + end_pos)
    else
      return end_pos
    end
  end
  local function slice_start_end(start, _end, list)
    local end_2b
    if (_end < 0) then
      end_2b = (#list + _end)
    else
      end_2b = _end
    end
    local sliced = {}
    for i = start, end_2b do
      table.insert(sliced, list[i])
    end
    return sliced
  end
  local function slice_start(start, list)
    local _966_
    if (start < 0) then
      _966_ = (#list + start)
    else
      _966_ = start
    end
    return slice_start_end(_966_, #list, list)
  end
  local function slice(start, _end, list)
    if ((type(_end) == "table") and not list) then
      return slice_start(start, _end)
    else
      return slice_start_end(start, _end, list)
    end
  end
  local function split(separator, str)
    return fu.split(str, separator)
  end
  local function tap(f, x, ...)
    f(x, table.unpack({...}))
    return x
  end
  local function count(tbl)
    local ct = 0
    local function _969_()
      ct = (ct + 1)
      return nil
    end
    fu.each(tbl, _969_)
    return ct
  end
  local function seq_3f(tbl)
    return (tbl[1] ~= nil)
  end
  local function seq(tbl)
    if seq_3f(tbl) then
      return ipairs(tbl)
    else
      return pairs(tbl)
    end
  end
  local function reduce(f, acc, tbl)
    local result = acc
    for k, v in seq(tbl) do
      result = f(result, v, k)
    end
    return result
  end
  local function for_each(f, tbl)
    return fu.each(tbl, f)
  end
  local function get_in(paths, tbl)
    local function _971_(tbl0, path)
      if (nil ~= tbl0) then
        return tbl0[path]
      else
        return nil
      end
    end
    return reduce(_971_, tbl, paths)
  end
  local function map(f, tbl)
    local function _973_(new_tbl, v, k)
      table.insert(new_tbl, f(v, k))
      return new_tbl
    end
    return reduce(_973_, {}, tbl)
  end
  local function merge(...)
    local tbls = {...}
    local function merger(merged, tbl)
      for k, v in pairs(tbl) do
        merged[k] = v
      end
      return merged
    end
    return reduce(merger, {}, tbls)
  end
  local function filter(f, tbl)
    local function _974_(xs, v, k)
      if f(v, k) then
        table.insert(xs, v)
      else
      end
      return xs
    end
    return reduce(_974_, {}, tbl)
  end
  local function concat(...)
    local function _976_(cat, tbl)
      for _, v in ipairs(tbl) do
        table.insert(cat, v)
      end
      return cat
    end
    return reduce(_976_, {}, {...})
  end
  local function some(f, tbl)
    local filtered = filter(f, tbl)
    return (1 <= #filtered)
  end
  local function conj(tbl, e)
    return concat(tbl, {e})
  end
  local function butlast(tbl)
    return slice(1, -1, tbl)
  end
  local function eq_3f(l1, l2)
    local _977_ = type(l2)
    if (((type(l1) == _977_) and (_977_ == "table")) and (#l1 == #l2)) then
      local function _978_(v)
        return contains_3f(v, l2)
      end
      return fu.every(l1, _978_)
    elseif (type(l1) == type(l2)) then
      return (l1 == l2)
    else
      return false
    end
  end
  return {butlast = butlast, ["call-when"] = call_when, compose = compose, concat = concat, conj = conj, ["contains?"] = contains_3f, count = count, ["eq?"] = eq_3f, filter = filter, find = find, first = first, ["for-each"] = for_each, get = get, ["get-in"] = get_in, ["has-some?"] = has_some_3f, identity = identity, join = join, last = last, logf = logf, map = map, merge = merge, noop = noop, reduce = reduce, seq = seq, ["seq?"] = seq_3f, some = some, slice = slice, split = split, tap = tap}
end
package.preload["lib.utils"] = package.preload["lib.utils"] or function(...)
  local function _980_()
    return "#<namespace: utils>"
  end
  local _local_981_ = {setmetatable({}, {__fennelview = _980_, __name = "namespace"})}
  local utils = _local_981_[1]
  local global_filter
  do
    local v_27_auto
    local function global_filter0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "global-filter"))
        else
        end
      end
      local filter = hs.window.filter.new()
      return filter:setAppFilter("Emacs", {allowRoles = {"AXUnknown", "AXStandardWindow", "AXDialog", "AXSystemDialog"}})
    end
    v_27_auto = global_filter0
    utils["global-filter"] = v_27_auto
    global_filter = v_27_auto
  end
  return utils
end
package.preload["lib.atom"] = package.preload["lib.atom"] or function(...)
  local function atom(initial)
    return {state = initial, watchers = {}}
  end
  local function copy(tbl, copies)
    local copies0 = (copies or {})
    if (type(tbl) ~= "table") then
      return tbl
    elseif copies0[tbl] then
      return copies0[tbl]
    else
      local copy_tbl = {}
      copies0[tbl] = copy_tbl
      for k, v in pairs(tbl) do
        copy_tbl[copy(k, copies0)] = copy(v, copies0)
      end
      setmetatable(copy_tbl, copy(getmetatable(tbl), copies0))
      return copy_tbl
    end
  end
  local function deref(atom0)
    return atom0.state
  end
  local function notify_watchers(atom0, next_value, prev_value)
    local watchers = atom0.watchers
    for _, f in pairs(watchers) do
      f(next_value, prev_value)
    end
    return nil
  end
  local function add_watch(atom0, key, f)
    atom0["watchers"][key] = f
    return nil
  end
  local function remove_watch(atom0, key)
    return table.remove(atom0.watchers, key)
  end
  local function swap_21(atom0, f, ...)
    local prev_value = deref(atom0)
    local next_value = f(copy(prev_value), table.unpack({...}))
    atom0.state = next_value
    notify_watchers(atom0, next_value, prev_value)
    return atom0
  end
  local function reset_21(atom0, v)
    local function _984_()
      return v
    end
    return swap_21(atom0, _984_)
  end
  return {atom = atom, new = atom, deref = deref, ["notify-watchers"] = notify_watchers, ["add-watch"] = add_watch, ["remove-watch"] = remove_watch, ["reset!"] = reset_21, ["swap!"] = swap_21}
end
package.preload["lib.advice"] = package.preload["lib.advice"] or function(...)
  local fennel = require("fennel")
  local _local_997_ = require("lib.functional")
  local contains_3f = _local_997_["contains?"]
  local compose = _local_997_["compose"]
  local filter = _local_997_["filter"]
  local first = _local_997_["first"]
  local join = _local_997_["join"]
  local last = _local_997_["last"]
  local map = _local_997_["map"]
  local reduce = _local_997_["reduce"]
  local seq = _local_997_["seq"]
  local slice = _local_997_["slice"]
  local split = _local_997_["split"]
  local advice = {}
  local advisable = {}
  local function register_advisable(key, f)
    local advice_entry = advice[key]
    if (advice_entry and advice_entry.original and not (advice_entry.original == f)) then
      error(("Advisable function " .. key .. " already exists"))
    else
    end
    if advice_entry then
      advice_entry["original"] = f
    else
      advice[key] = {original = f, advice = {}}
    end
    return advice[key]
  end
  local function get_or_create_advice_entry(key)
    local advice_entry = advice[key]
    if advice_entry then
      return advice_entry
    else
      advice[key] = {advice = {}}
      return advice[key]
    end
  end
  local function advisable_keys()
    return slice(0, advisable)
  end
  local function get_module_name()
    return first(split("%.", join("/", slice(-1, split("/", debug.getinfo(3, "S").short_src)))))
  end
  local function advisor(type, f, orig_f)
    if (type == "override") then
      local function _1001_(args)
        return f(table.unpack(args))
      end
      return _1001_
    elseif (type == "around") then
      local function _1002_(args)
        return f(orig_f, table.unpack(args))
      end
      return _1002_
    elseif (type == "before") then
      local function _1003_(args)
        f(table.unpack(args))
        return orig_f(table.unpack(args))
      end
      return _1003_
    elseif (type == "before-while") then
      local function _1004_(args)
        return (f(table.unpack(args)) and orig_f(table.unpack(args)))
      end
      return _1004_
    elseif (type == "before-until") then
      local function _1005_(args)
        return (f(table.unpack(args)) or orig_f(table.unpack(args)))
      end
      return _1005_
    elseif (type == "after") then
      local function _1006_(args)
        local ret = orig_f(table.unpack(args))
        f(table.unpack(args))
        return ret
      end
      return _1006_
    elseif (type == "after-while") then
      local function _1007_(args)
        return (orig_f(table.unpack(args)) and f(table.unpack(args)))
      end
      return _1007_
    elseif (type == "after-until") then
      local function _1008_(args)
        return (orig_f(table.unpack(args)) or f(table.unpack(args)))
      end
      return _1008_
    elseif (type == "filter-args") then
      local function _1009_(args)
        return orig_f(table.unpack(f(table.unpack(args))))
      end
      return _1009_
    elseif (type == "filter-return") then
      local function _1010_(args)
        return f(orig_f(table.unpack(args)))
      end
      return _1010_
    else
      return nil
    end
  end
  local function apply_advice(entry, args)
    local function _1013_(_1012_)
      local f = _1012_["f"]
      local type = _1012_["type"]
      local function _1014_(next_f)
        return advisor(type, f, next_f)
      end
      return _1014_
    end
    local function _1015_(...)
      return entry.original(table.unpack({...}))
    end
    return compose(table.unpack(map(_1013_, entry.advice)))(_1015_)(args)
  end
  local function count(tbl)
    local function _1016_(acc, _x, _key)
      return (acc + 1)
    end
    return reduce(_1016_, 0, tbl)
  end
  local function dispatch_advice(entry, args)
    if (count(entry.advice) > 0) then
      return apply_advice(entry, args)
    else
      return entry.original(table.unpack(args))
    end
  end
  local function make_advisable(fn_name, f)
    local module = get_module_name()
    local key = (module .. "/" .. fn_name)
    local advice_entry = register_advisable(key, f)
    local ret = {key = key, advice = advice_entry}
    local function _1018_(_tbl, ...)
      return dispatch_advice(advice_entry, {...})
    end
    local function _1019_(tbl, key0)
      return tbl[key0]
    end
    setmetatable(ret, {__name = fn_name, __call = _1018_, __index = _1019_})
    for k, v in pairs((fennel.metadata[f] or {})) do
      fennel.metadata:set(ret, k, v)
    end
    return ret
  end
  local function add_advice(f, advice_type, advice_fn)
    local key = (f.key or f)
    local advice_entry = get_or_create_advice_entry(key)
    if advice_entry then
      return table.insert(advice_entry.advice, {type = advice_type, f = advice_fn})
    else
      return nil
    end
  end
  local function remove_advice(f, advice_type, advice_fn)
    local key = (f.key or f)
    local advice_entry = advice[key]
    local function _1021_(_241)
      return not ((_241.type == advice_type) and (_241.f == advice_fn))
    end
    advice_entry["advice"] = filter(_1021_, advice_entry.advice)
    return nil
  end
  local function reset()
    advice = {}
    advisable = {}
    return nil
  end
  local function print_advisable_keys()
    print("\nAdvisable functions:\n")
    for i, key in ipairs(advisable_keys()) do
      print(("  :" .. key))
    end
    return nil
  end
  local function get_advice(f_or_key)
    local advice_entry = advice[(f_or_key.key or f_or_key)]
    if advice_entry then
      local function _1022_(adv)
        return {f = tostring(adv.f), type = adv.type}
      end
      return map(_1022_, slice(0, advice_entry.advice))
    else
      return {}
    end
  end
  return {reset = reset, ["make-advisable"] = make_advisable, ["add-advice"] = add_advice, ["remove-advice"] = remove_advice, ["get-advice"] = get_advice, ["print-advisable-keys"] = print_advisable_keys}
end
package.preload["fennel"] = package.preload["fennel"] or function(...)
  -- SPDX-License-Identifier: MIT
  -- SPDX-FileCopyrightText: Calvin Rose and contributors
  package.preload["fennel.repl"] = package.preload["fennel.repl"] or function(...)
    local utils = require("fennel.utils")
    local parser = require("fennel.parser")
    local compiler = require("fennel.compiler")
    local specials = require("fennel.specials")
    local view = require("fennel.view")
    local depth = 0
    local function prompt_for(top_3f)
      if top_3f then
        return (string.rep(">", (depth + 1)) .. " ")
      else
        return (string.rep(".", (depth + 1)) .. " ")
      end
    end
    local function default_read_chunk(parser_state)
      io.write(prompt_for((0 == parser_state["stack-size"])))
      io.flush()
      local input = io.read()
      return (input and (input .. "\n"))
    end
    local function default_on_values(xs)
      io.write(table.concat(xs, "\9"))
      return io.write("\n")
    end
    local function default_on_error(errtype, err)
      local function _702_()
        local _701_0 = errtype
        if (_701_0 == "Runtime") then
          return (compiler.traceback(tostring(err), 4) .. "\n")
        else
          local _ = _701_0
          return ("%s error: %s\n"):format(errtype, tostring(err))
        end
      end
      return io.write(_702_())
    end
    local function splice_save_locals(env, lua_source, scope)
      local saves = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for name in pairs(env.___replLocals___) do
          local val_19_ = ("local %s = ___replLocals___[%q]"):format((scope.manglings[name] or name), name)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        saves = tbl_17_
      end
      local binds = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for raw, name in pairs(scope.manglings) do
          local val_19_ = nil
          if not scope.gensyms[name] then
            val_19_ = ("___replLocals___[%q] = %s"):format(raw, name)
          else
          val_19_ = nil
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        binds = tbl_17_
      end
      local gap = nil
      if lua_source:find("\n") then
        gap = "\n"
      else
        gap = " "
      end
      local function _708_()
        if next(saves) then
          return (table.concat(saves, " ") .. gap)
        else
          return ""
        end
      end
      local function _711_()
        local _709_0, _710_0 = lua_source:match("^(.*)[\n ](return .*)$")
        if ((nil ~= _709_0) and (nil ~= _710_0)) then
          local body = _709_0
          local _return = _710_0
          return (body .. gap .. table.concat(binds, " ") .. gap .. _return)
        else
          local _ = _709_0
          return lua_source
        end
      end
      return (_708_() .. _711_())
    end
    local commands = {}
    local function completer(env, scope, text, _3ffulltext, _from, _to)
      local max_items = 2000
      local seen = {}
      local matches = {}
      local input_fragment = text:gsub(".*[%s)(]+", "")
      local stop_looking_3f = false
      local function add_partials(input, tbl, prefix)
        local scope_first_3f = ((tbl == env) or (tbl == env.___replLocals___))
        local tbl_17_ = matches
        local i_18_ = #tbl_17_
        local function _713_()
          if scope_first_3f then
            return scope.manglings
          else
            return tbl
          end
        end
        for k, is_mangled in utils.allpairs(_713_()) do
          if (max_items <= #matches) then break end
          local val_19_ = nil
          do
            local lookup_k = nil
            if scope_first_3f then
              lookup_k = is_mangled
            else
              lookup_k = k
            end
            if ((type(k) == "string") and (input == k:sub(0, #input)) and not seen[k] and ((":" ~= prefix:sub(-1)) or ("function" == type(tbl[lookup_k])))) then
              seen[k] = true
              val_19_ = (prefix .. k)
            else
            val_19_ = nil
            end
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        return tbl_17_
      end
      local function descend(input, tbl, prefix, add_matches, method_3f)
        local splitter = nil
        if method_3f then
          splitter = "^([^:]+):(.*)"
        else
          splitter = "^([^.]+)%.(.*)"
        end
        local head, tail = input:match(splitter)
        local raw_head = (scope.manglings[head] or head)
        if (type(tbl[raw_head]) == "table") then
          stop_looking_3f = true
          if method_3f then
            return add_partials(tail, tbl[raw_head], (prefix .. head .. ":"))
          else
            return add_matches(tail, tbl[raw_head], (prefix .. head))
          end
        end
      end
      local function add_matches(input, tbl, prefix)
        local prefix0 = nil
        if prefix then
          prefix0 = (prefix .. ".")
        else
          prefix0 = ""
        end
        if (not input:find("%.") and input:find(":")) then
          return descend(input, tbl, prefix0, add_matches, true)
        elseif not input:find("%.") then
          return add_partials(input, tbl, prefix0)
        else
          return descend(input, tbl, prefix0, add_matches, false)
        end
      end
      do
        local _722_0 = tostring((_3ffulltext or text)):match("^%s*,([^%s()[%]]*)$")
        if (nil ~= _722_0) then
          local cmd_fragment = _722_0
          add_partials(cmd_fragment, commands, ",")
        else
          local _ = _722_0
          for _0, source in ipairs({scope.specials, scope.macros, (env.___replLocals___ or {}), env, env._G}) do
            if stop_looking_3f then break end
            add_matches(input_fragment, source)
          end
        end
      end
      return matches
    end
    local function command_3f(input)
      return input:match("^%s*,")
    end
    local function command_docs()
      local _724_
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for name, f in utils.stablepairs(commands) do
          local val_19_ = ("  ,%s - %s"):format(name, ((compiler.metadata):get(f, "fnl/docstring") or "undocumented"))
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        _724_ = tbl_17_
      end
      return table.concat(_724_, "\n")
    end
    commands.help = function(_, _0, on_values)
      return on_values({("Welcome to Fennel.\nThis is the REPL where you can enter code to be evaluated.\nYou can also run these repl commands:\n\n" .. command_docs() .. "\n  ,return FORM - Evaluate FORM and return its value to the REPL's caller.\n  ,exit - Leave the repl.\n\nUse ,doc something to see descriptions for individual macros and special forms.\nValues from previous inputs are kept in *1, *2, and *3.\n\nFor more information about the language, see https://fennel-lang.org/reference")})
    end
    do end (compiler.metadata):set(commands.help, "fnl/docstring", "Show this message.")
    local function reload(module_name, env, on_values, on_error)
      local _726_0, _727_0 = pcall(specials["load-code"]("return require(...)", env), module_name)
      if ((_726_0 == true) and (nil ~= _727_0)) then
        local old = _727_0
        local _ = nil
        package.loaded[module_name] = nil
        _ = nil
        local new = nil
        do
          local _728_0, _729_0 = pcall(require, module_name)
          if ((_728_0 == true) and (nil ~= _729_0)) then
            local new0 = _729_0
            new = new0
          elseif (true and (nil ~= _729_0)) then
            local _0 = _728_0
            local msg = _729_0
            on_error("Repl", msg)
            new = old
          else
          new = nil
          end
        end
        specials["macro-loaded"][module_name] = nil
        if ((type(old) == "table") and (type(new) == "table")) then
          for k, v in pairs(new) do
            old[k] = v
          end
          for k in pairs(old) do
            if (nil == new[k]) then
              old[k] = nil
            end
          end
          package.loaded[module_name] = old
        end
        return on_values({"ok"})
      elseif ((_726_0 == false) and (nil ~= _727_0)) then
        local msg = _727_0
        if msg:match("loop or previous error loading module") then
          package.loaded[module_name] = nil
          return reload(module_name, env, on_values, on_error)
        elseif specials["macro-loaded"][module_name] then
          specials["macro-loaded"][module_name] = nil
          return nil
        else
          local function _734_()
            local _733_0 = msg:gsub("\n.*", "")
            return _733_0
          end
          return on_error("Runtime", _734_())
        end
      end
    end
    local function run_command(read, on_error, f)
      local _737_0, _738_0, _739_0 = pcall(read)
      if ((_737_0 == true) and (_738_0 == true) and (nil ~= _739_0)) then
        local val = _739_0
        local _740_0, _741_0 = pcall(f, val)
        if ((_740_0 == false) and (nil ~= _741_0)) then
          local msg = _741_0
          return on_error("Runtime", msg)
        end
      elseif (_737_0 == false) then
        return on_error("Parse", "Couldn't parse input.")
      end
    end
    commands.reload = function(env, read, on_values, on_error)
      local function _744_(_241)
        return reload(tostring(_241), env, on_values, on_error)
      end
      return run_command(read, on_error, _744_)
    end
    do end (compiler.metadata):set(commands.reload, "fnl/docstring", "Reload the specified module.")
    commands.reset = function(env, _, on_values)
      env.___replLocals___ = {}
      return on_values({"ok"})
    end
    do end (compiler.metadata):set(commands.reset, "fnl/docstring", "Erase all repl-local scope.")
    commands.complete = function(env, read, on_values, on_error, scope, chars)
      local function _745_()
        return on_values(completer(env, scope, table.concat(chars):gsub("^%s*,complete%s+", ""):sub(1, -2)))
      end
      return run_command(read, on_error, _745_)
    end
    do end (compiler.metadata):set(commands.complete, "fnl/docstring", "Print all possible completions for a given input symbol.")
    local function apropos_2a(pattern, tbl, prefix, seen, names)
      for name, subtbl in pairs(tbl) do
        if (("string" == type(name)) and (package ~= subtbl)) then
          local _746_0 = type(subtbl)
          if (_746_0 == "function") then
            if ((prefix .. name)):match(pattern) then
              table.insert(names, (prefix .. name))
            end
          elseif (_746_0 == "table") then
            if not seen[subtbl] then
              local _748_
              do
                seen[subtbl] = true
                _748_ = seen
              end
              apropos_2a(pattern, subtbl, (prefix .. name:gsub("%.", "/") .. "."), _748_, names)
            end
          end
        end
      end
      return names
    end
    local function apropos(pattern)
      return apropos_2a(pattern:gsub("^_G%.", ""), package.loaded, "", {}, {})
    end
    commands.apropos = function(_env, read, on_values, on_error, _scope)
      local function _752_(_241)
        return on_values(apropos(tostring(_241)))
      end
      return run_command(read, on_error, _752_)
    end
    do end (compiler.metadata):set(commands.apropos, "fnl/docstring", "Print all functions matching a pattern in all loaded modules.")
    local function apropos_follow_path(path)
      local paths = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for p in path:gmatch("[^%.]+") do
          local val_19_ = p
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        paths = tbl_17_
      end
      local tgt = package.loaded
      for _, path0 in ipairs(paths) do
        if (nil == tgt) then break end
        local _755_
        do
          local _754_0 = path0:gsub("%/", ".")
          _755_ = _754_0
        end
        tgt = tgt[_755_]
      end
      return tgt
    end
    local function apropos_doc(pattern)
      local tbl_17_ = {}
      local i_18_ = #tbl_17_
      for _, path in ipairs(apropos(".*")) do
        local val_19_ = nil
        do
          local tgt = apropos_follow_path(path)
          if ("function" == type(tgt)) then
            local _756_0 = (compiler.metadata):get(tgt, "fnl/docstring")
            if (nil ~= _756_0) then
              local docstr = _756_0
              val_19_ = (docstr:match(pattern) and path)
            else
            val_19_ = nil
            end
          else
          val_19_ = nil
          end
        end
        if (nil ~= val_19_) then
          i_18_ = (i_18_ + 1)
          tbl_17_[i_18_] = val_19_
        end
      end
      return tbl_17_
    end
    commands["apropos-doc"] = function(_env, read, on_values, on_error, _scope)
      local function _760_(_241)
        return on_values(apropos_doc(tostring(_241)))
      end
      return run_command(read, on_error, _760_)
    end
    do end (compiler.metadata):set(commands["apropos-doc"], "fnl/docstring", "Print all functions that match the pattern in their docs")
    local function apropos_show_docs(on_values, pattern)
      for _, path in ipairs(apropos(pattern)) do
        local tgt = apropos_follow_path(path)
        if (("function" == type(tgt)) and (compiler.metadata):get(tgt, "fnl/docstring")) then
          on_values({specials.doc(tgt, path)})
          on_values({})
        end
      end
      return nil
    end
    commands["apropos-show-docs"] = function(_env, read, on_values, on_error)
      local function _762_(_241)
        return apropos_show_docs(on_values, tostring(_241))
      end
      return run_command(read, on_error, _762_)
    end
    do end (compiler.metadata):set(commands["apropos-show-docs"], "fnl/docstring", "Print all documentations matching a pattern in function name")
    local function resolve(identifier, _763_0, scope)
      local _764_ = _763_0
      local env = _764_
      local ___replLocals___ = _764_["___replLocals___"]
      local e = nil
      local function _765_(_241, _242)
        return (___replLocals___[scope.unmanglings[_242]] or env[_242])
      end
      e = setmetatable({}, {__index = _765_})
      local function _766_(...)
        local _767_0, _768_0 = ...
        if ((_767_0 == true) and (nil ~= _768_0)) then
          local code = _768_0
          local function _769_(...)
            local _770_0, _771_0 = ...
            if ((_770_0 == true) and (nil ~= _771_0)) then
              local val = _771_0
              return val
            else
              local _ = _770_0
              return nil
            end
          end
          return _769_(pcall(specials["load-code"](code, e)))
        else
          local _ = _767_0
          return nil
        end
      end
      return _766_(pcall(compiler["compile-string"], tostring(identifier), {scope = scope}))
    end
    commands.find = function(env, read, on_values, on_error, scope)
      local function _774_(_241)
        local _775_0 = nil
        do
          local _776_0 = utils["sym?"](_241)
          if (nil ~= _776_0) then
            local _777_0 = resolve(_776_0, env, scope)
            if (nil ~= _777_0) then
              _775_0 = debug.getinfo(_777_0)
            else
              _775_0 = _777_0
            end
          else
            _775_0 = _776_0
          end
        end
        if ((_G.type(_775_0) == "table") and (nil ~= _775_0.linedefined) and (nil ~= _775_0.short_src) and (nil ~= _775_0.source) and (_775_0.what == "Lua")) then
          local line = _775_0.linedefined
          local src = _775_0.short_src
          local source = _775_0.source
          local fnlsrc = nil
          do
            local _780_0 = compiler.sourcemap
            if (nil ~= _780_0) then
              _780_0 = _780_0[source]
            end
            if (nil ~= _780_0) then
              _780_0 = _780_0[line]
            end
            if (nil ~= _780_0) then
              _780_0 = _780_0[2]
            end
            fnlsrc = _780_0
          end
          return on_values({string.format("%s:%s", src, (fnlsrc or line))})
        elseif (_775_0 == nil) then
          return on_error("Repl", "Unknown value")
        else
          local _ = _775_0
          return on_error("Repl", "No source info")
        end
      end
      return run_command(read, on_error, _774_)
    end
    do end (compiler.metadata):set(commands.find, "fnl/docstring", "Print the filename and line number for a given function")
    commands.doc = function(env, read, on_values, on_error, scope)
      local function _785_(_241)
        local name = tostring(_241)
        local path = (utils["multi-sym?"](name) or {name})
        local ok_3f, target = nil, nil
        local function _786_()
          return (scope.specials[name] or utils["get-in"](scope.macros, path) or resolve(name, env, scope))
        end
        ok_3f, target = pcall(_786_)
        if ok_3f then
          return on_values({specials.doc(target, name)})
        else
          return on_error("Repl", ("Could not find " .. name .. " for docs."))
        end
      end
      return run_command(read, on_error, _785_)
    end
    do end (compiler.metadata):set(commands.doc, "fnl/docstring", "Print the docstring and arglist for a function, macro, or special form.")
    commands.compile = function(_, read, on_values, on_error, _0, _1, opts)
      local function _788_(_241)
        local _789_0, _790_0 = pcall(compiler.compile, _241, opts)
        if ((_789_0 == true) and (nil ~= _790_0)) then
          local result = _790_0
          return on_values({result})
        elseif (true and (nil ~= _790_0)) then
          local _2 = _789_0
          local msg = _790_0
          return on_error("Repl", ("Error compiling expression: " .. msg))
        end
      end
      return run_command(read, on_error, _788_)
    end
    do end (compiler.metadata):set(commands.compile, "fnl/docstring", "compiles the expression into lua and prints the result.")
    local function load_plugin_commands(plugins)
      for i = #(plugins or {}), 1, -1 do
        for name, f in pairs(plugins[i]) do
          local _792_0 = name:match("^repl%-command%-(.*)")
          if (nil ~= _792_0) then
            local cmd_name = _792_0
            commands[cmd_name] = f
          end
        end
      end
      return nil
    end
    local function run_command_loop(input, read, loop, env, on_values, on_error, scope, chars, opts)
      local command_name = input:match(",([^%s/]+)")
      do
        local _794_0 = commands[command_name]
        if (nil ~= _794_0) then
          local command = _794_0
          command(env, read, on_values, on_error, scope, chars, opts)
        else
          local _ = _794_0
          if ((command_name ~= "exit") and (command_name ~= "return")) then
            on_values({"Unknown command", command_name})
          end
        end
      end
      if ("exit" ~= command_name) then
        return loop((command_name == "return"))
      end
    end
    local function try_readline_21(opts, ok, readline)
      if ok then
        if readline.set_readline_name then
          readline.set_readline_name("fennel")
        end
        readline.set_options({histfile = "", keeplines = 1000})
        opts.readChunk = function(parser_state)
          local prompt = nil
          if (0 < parser_state["stack-size"]) then
            prompt = ".. "
          else
            prompt = ">> "
          end
          local str = readline.readline(prompt)
          if str then
            return (str .. "\n")
          end
        end
        local completer0 = nil
        opts.registerCompleter = function(repl_completer)
          completer0 = repl_completer
          return nil
        end
        local function repl_completer(text, from, to)
          if completer0 then
            readline.set_completion_append_character("")
            return completer0(text:sub(from, to), text, from, to)
          else
            return {}
          end
        end
        readline.set_complete_function(repl_completer)
        return readline
      end
    end
    local function should_use_readline_3f(opts)
      return (("dumb" ~= os.getenv("TERM")) and not opts.readChunk and not opts.registerCompleter)
    end
    local function repl(_3foptions)
      local old_root_options = utils.root.options
      local _803_ = utils.copy(_3foptions)
      local opts = _803_
      local _3ffennelrc = _803_["fennelrc"]
      local _ = nil
      opts.fennelrc = nil
      _ = nil
      local readline = (should_use_readline_3f(opts) and try_readline_21(opts, pcall(require, "readline")))
      local _0 = nil
      if _3ffennelrc then
        _0 = _3ffennelrc()
      else
      _0 = nil
      end
      local env = specials["wrap-env"]((opts.env or rawget(_G, "_ENV") or _G))
      local callbacks = {["view-opts"] = (opts["view-opts"] or {depth = 4}), env = env, onError = (opts.onError or default_on_error), onValues = (opts.onValues or default_on_values), pp = (opts.pp or view), readChunk = (opts.readChunk or default_read_chunk)}
      local save_locals_3f = (opts.saveLocals ~= false)
      local byte_stream, clear_stream = nil, nil
      local function _805_(_241)
        return callbacks.readChunk(_241)
      end
      byte_stream, clear_stream = parser.granulate(_805_)
      local chars = {}
      local read, reset = nil, nil
      local function _806_(parser_state)
        local b = byte_stream(parser_state)
        if b then
          table.insert(chars, string.char(b))
        end
        return b
      end
      read, reset = parser.parser(_806_)
      depth = (depth + 1)
      if opts.message then
        callbacks.onValues({opts.message})
      end
      env.___repl___ = callbacks
      opts.env, opts.scope = env, compiler["make-scope"]()
      opts.useMetadata = (opts.useMetadata ~= false)
      if (opts.allowedGlobals == nil) then
        opts.allowedGlobals = specials["current-global-names"](env)
      end
      if opts.init then
        opts.init(opts, depth)
      end
      if opts.registerCompleter then
        local function _812_()
          local _811_0 = opts.scope
          local function _813_(...)
            return completer(env, _811_0, ...)
          end
          return _813_
        end
        opts.registerCompleter(_812_())
      end
      load_plugin_commands(opts.plugins)
      if save_locals_3f then
        local function newindex(t, k, v)
          if opts.scope.manglings[k] then
            return rawset(t, k, v)
          end
        end
        env.___replLocals___ = setmetatable({}, {__newindex = newindex})
      end
      local function print_values(...)
        local vals = {...}
        local out = {}
        local pp = callbacks.pp
        env._, env.__ = vals[1], vals
        for i = 1, select("#", ...) do
          table.insert(out, pp(vals[i], callbacks["view-opts"]))
        end
        return callbacks.onValues(out)
      end
      local function save_value(...)
        env.___replLocals___["*3"] = env.___replLocals___["*2"]
        env.___replLocals___["*2"] = env.___replLocals___["*1"]
        env.___replLocals___["*1"] = ...
        return ...
      end
      opts.scope.manglings["*1"], opts.scope.unmanglings._1 = "_1", "*1"
      opts.scope.manglings["*2"], opts.scope.unmanglings._2 = "_2", "*2"
      opts.scope.manglings["*3"], opts.scope.unmanglings._3 = "_3", "*3"
      local function loop(exit_next_3f)
        for k in pairs(chars) do
          chars[k] = nil
        end
        reset()
        local ok, parser_not_eof_3f, form = pcall(read)
        local src_string = table.concat(chars)
        local readline_not_eof_3f = (not readline or (src_string ~= "(null)"))
        local not_eof_3f = (readline_not_eof_3f and parser_not_eof_3f)
        if not ok then
          callbacks.onError("Parse", not_eof_3f)
          clear_stream()
          return loop()
        elseif command_3f(src_string) then
          return run_command_loop(src_string, read, loop, env, callbacks.onValues, callbacks.onError, opts.scope, chars, opts)
        else
          if not_eof_3f then
            local function _817_(...)
              local _818_0, _819_0 = ...
              if ((_818_0 == true) and (nil ~= _819_0)) then
                local src = _819_0
                local function _820_(...)
                  local _821_0, _822_0 = ...
                  if ((_821_0 == true) and (nil ~= _822_0)) then
                    local chunk = _822_0
                    local function _823_()
                      return print_values(save_value(chunk()))
                    end
                    local function _824_(...)
                      return callbacks.onError("Runtime", ...)
                    end
                    return xpcall(_823_, _824_)
                  elseif ((_821_0 == false) and (nil ~= _822_0)) then
                    local msg = _822_0
                    clear_stream()
                    return callbacks.onError("Compile", msg)
                  end
                end
                local function _827_(...)
                  local src0 = nil
                  if save_locals_3f then
                    src0 = splice_save_locals(env, src, opts.scope)
                  else
                    src0 = src
                  end
                  return pcall(specials["load-code"], src0, env)
                end
                return _820_(_827_(...))
              elseif ((_818_0 == false) and (nil ~= _819_0)) then
                local msg = _819_0
                clear_stream()
                return callbacks.onError("Compile", msg)
              end
            end
            local function _829_()
              opts["source"] = src_string
              return opts
            end
            _817_(pcall(compiler.compile, form, _829_()))
            utils.root.options = old_root_options
            if exit_next_3f then
              return env.___replLocals___["*1"]
            else
              return loop()
            end
          end
        end
      end
      local value = loop()
      depth = (depth - 1)
      if readline then
        readline.save_history()
      end
      if opts.exit then
        opts.exit(opts, depth)
      end
      return value
    end
    local function _835_(overrides, _3fopts)
      return repl(utils.copy(_3fopts, utils.copy(overrides)))
    end
    return setmetatable({}, {__call = _835_, __index = {repl = repl}})
  end
  package.preload["fennel.specials"] = package.preload["fennel.specials"] or function(...)
    local utils = require("fennel.utils")
    local view = require("fennel.view")
    local parser = require("fennel.parser")
    local compiler = require("fennel.compiler")
    local unpack = (table.unpack or _G.unpack)
    local SPECIALS = compiler.scopes.global.specials
    local function str1(x)
      return tostring(x[1])
    end
    local function wrap_env(env)
      local function _475_(_, key)
        if utils["string?"](key) then
          return env[compiler["global-unmangling"](key)]
        else
          return env[key]
        end
      end
      local function _477_(_, key, value)
        if utils["string?"](key) then
          env[compiler["global-unmangling"](key)] = value
          return nil
        else
          env[key] = value
          return nil
        end
      end
      local function _479_()
        local _480_
        do
          local tbl_14_ = {}
          for k, v in utils.stablepairs(env) do
            local k_15_, v_16_ = nil, nil
            local _481_
            if utils["string?"](k) then
              _481_ = compiler["global-unmangling"](k)
            else
              _481_ = k
            end
            k_15_, v_16_ = _481_, v
            if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
              tbl_14_[k_15_] = v_16_
            end
          end
          _480_ = tbl_14_
        end
        return next, _480_, nil
      end
      return setmetatable({}, {__index = _475_, __newindex = _477_, __pairs = _479_})
    end
    local function fennel_module_name()
      return (utils.root.options.moduleName or "fennel")
    end
    local function current_global_names(_3fenv)
      local mt = nil
      do
        local _484_0 = getmetatable(_3fenv)
        if ((_G.type(_484_0) == "table") and (nil ~= _484_0.__pairs)) then
          local mtpairs = _484_0.__pairs
          local tbl_14_ = {}
          for k, v in mtpairs(_3fenv) do
            local k_15_, v_16_ = k, v
            if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
              tbl_14_[k_15_] = v_16_
            end
          end
          mt = tbl_14_
        elseif (_484_0 == nil) then
          mt = (_3fenv or _G)
        else
        mt = nil
        end
      end
      local function _487_()
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for k in utils.stablepairs(mt) do
          local val_19_ = compiler["global-unmangling"](k)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        return tbl_17_
      end
      return (mt and _487_())
    end
    local function load_code(code, _3fenv, _3ffilename)
      local env = (_3fenv or rawget(_G, "_ENV") or _G)
      local _489_0, _490_0 = rawget(_G, "setfenv"), rawget(_G, "loadstring")
      if ((nil ~= _489_0) and (nil ~= _490_0)) then
        local setfenv = _489_0
        local loadstring = _490_0
        local f = assert(loadstring(code, _3ffilename))
        setfenv(f, env)
        return f
      else
        local _ = _489_0
        return assert(load(code, _3ffilename, "t", env))
      end
    end
    local function v__3edocstring(tgt)
      return (((compiler.metadata):get(tgt, "fnl/docstring") or "#<undocumented>")):gsub("\n$", ""):gsub("\n", "\n  ")
    end
    local function doc_2a(tgt, name)
      assert(("string" == type(name)), "name must be a string")
      if not tgt then
        return (name .. " not found")
      else
        local function _493_()
          local _492_0 = getmetatable(tgt)
          if ((_G.type(_492_0) == "table") and true) then
            local __call = _492_0.__call
            return ("function" == type(__call))
          end
        end
        if ((type(tgt) == "function") or _493_()) then
          local elts = {name, unpack(((compiler.metadata):get(tgt, "fnl/arglist") or {"#<unknown-arguments>"}))}
          return string.format("(%s)\n  %s", table.concat(elts, " "), v__3edocstring(tgt))
        else
          return string.format("%s\n  %s", name, v__3edocstring(tgt))
        end
      end
    end
    local function doc_special(name, arglist, docstring, body_form_3f)
      compiler.metadata[SPECIALS[name]] = {["fnl/arglist"] = arglist, ["fnl/body-form?"] = body_form_3f, ["fnl/docstring"] = docstring}
      return nil
    end
    local function compile_do(ast, scope, parent, _3fstart)
      local start = (_3fstart or 2)
      local len = #ast
      local sub_scope = compiler["make-scope"](scope)
      for i = start, len do
        compiler.compile1(ast[i], sub_scope, parent, {nval = 0})
      end
      return nil
    end
    SPECIALS["do"] = function(ast, scope, parent, opts, _3fstart, _3fchunk, _3fsub_scope, _3fpre_syms)
      local start = (_3fstart or 2)
      local sub_scope = (_3fsub_scope or compiler["make-scope"](scope))
      local chunk = (_3fchunk or {})
      local len = #ast
      local retexprs = {returned = true}
      utils.hook("pre-do", ast, sub_scope)
      local function compile_body(outer_target, outer_tail, outer_retexprs)
        for i = start, len do
          local subopts = {nval = (((i ~= len) and 0) or opts.nval), tail = (((i == len) and outer_tail) or nil), target = (((i == len) and outer_target) or nil)}
          local _ = utils["propagate-options"](opts, subopts)
          local subexprs = compiler.compile1(ast[i], sub_scope, chunk, subopts)
          if (i ~= len) then
            compiler["keep-side-effects"](subexprs, parent, nil, ast[i])
          end
        end
        compiler.emit(parent, chunk, ast)
        compiler.emit(parent, "end", ast)
        utils.hook("do", ast, sub_scope)
        return (outer_retexprs or retexprs)
      end
      if (opts.target or (opts.nval == 0) or opts.tail) then
        compiler.emit(parent, "do", ast)
        return compile_body(opts.target, opts.tail)
      elseif opts.nval then
        local syms = {}
        for i = 1, opts.nval do
          local s = ((_3fpre_syms and _3fpre_syms[i]) or compiler.gensym(scope))
          syms[i] = s
          retexprs[i] = utils.expr(s, "sym")
        end
        local outer_target = table.concat(syms, ", ")
        compiler.emit(parent, string.format("local %s", outer_target), ast)
        compiler.emit(parent, "do", ast)
        return compile_body(outer_target, opts.tail)
      else
        local fname = compiler.gensym(scope)
        local fargs = nil
        if scope.vararg then
          fargs = "..."
        else
          fargs = ""
        end
        compiler.emit(parent, string.format("local function %s(%s)", fname, fargs), ast)
        return compile_body(nil, true, utils.expr((fname .. "(" .. fargs .. ")"), "statement"))
      end
    end
    doc_special("do", {"..."}, "Evaluate multiple forms; return last value.", true)
    local function iter_args(ast)
      local ast0, len, i = ast, #ast, 1
      local function _499_()
        i = (1 + i)
        while ((i == len) and utils["call-of?"](ast0[i], "values")) do
          ast0 = ast0[i]
          len = #ast0
          i = 2
        end
        return ast0[i], (nil == ast0[(i + 1)])
      end
      return _499_
    end
    SPECIALS.values = function(ast, scope, parent)
      local exprs = {}
      for subast, last_3f in iter_args(ast) do
        local subexprs = compiler.compile1(subast, scope, parent, {nval = (not last_3f and 1)})
        table.insert(exprs, subexprs[1])
        if last_3f then
          for j = 2, #subexprs do
            table.insert(exprs, subexprs[j])
          end
        end
      end
      return exprs
    end
    doc_special("values", {"..."}, "Return multiple values from a function. Must be in tail position.")
    local function __3estack(stack, tbl)
      for k, v in pairs(tbl) do
        table.insert(stack, k)
        table.insert(stack, v)
      end
      return stack
    end
    local function literal_3f(val)
      local res = true
      if utils["list?"](val) then
        res = false
      elseif utils["table?"](val) then
        local stack = __3estack({}, val)
        for _, elt in ipairs(stack) do
          if not res then break end
          if utils["list?"](elt) then
            res = false
          elseif utils["table?"](elt) then
            __3estack(stack, elt)
          end
        end
      end
      return res
    end
    local function compile_value(v)
      local opts = {nval = 1, tail = false}
      local scope = compiler["make-scope"]()
      local chunk = {}
      local _503_ = compiler.compile1(v, scope, chunk, opts)
      local _504_ = _503_[1]
      local v0 = _504_[1]
      return v0
    end
    local function insert_meta(meta, k, v)
      local view_opts = {["escape-newlines?"] = true, ["line-length"] = math.huge, ["one-line?"] = true}
      compiler.assert((type(k) == "string"), ("expected string keys in metadata table, got: %s"):format(view(k, view_opts)))
      compiler.assert(literal_3f(v), ("expected literal value in metadata table, got: %s %s"):format(view(k, view_opts), view(v, view_opts)))
      table.insert(meta, view(k))
      local function _505_()
        if ("string" == type(v)) then
          return view(v, view_opts)
        else
          return compile_value(v)
        end
      end
      table.insert(meta, _505_())
      return meta
    end
    local function insert_arglist(meta, arg_list)
      local opts = {["escape-newlines?"] = true, ["line-length"] = math.huge, ["one-line?"] = true}
      local view_args = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _, arg in ipairs(arg_list) do
          local val_19_ = view(view(arg, opts))
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        view_args = tbl_17_
      end
      table.insert(meta, "\"fnl/arglist\"")
      table.insert(meta, ("{" .. table.concat(view_args, ", ") .. "}"))
      return meta
    end
    local function set_fn_metadata(f_metadata, parent, fn_name)
      if utils.root.options.useMetadata then
        local meta_fields = {}
        for k, v in utils.stablepairs(f_metadata) do
          if (k == "fnl/arglist") then
            insert_arglist(meta_fields, v)
          else
            insert_meta(meta_fields, k, v)
          end
        end
        local meta_str = ("require(\"%s\").metadata"):format(fennel_module_name())
        return compiler.emit(parent, ("pcall(function() %s:setall(%s, %s) end)"):format(meta_str, fn_name, table.concat(meta_fields, ", ")))
      end
    end
    local function get_fn_name(ast, scope, fn_name, multi)
      if (fn_name and (fn_name[1] ~= "nil")) then
        local _509_
        if not multi then
          _509_ = compiler["declare-local"](fn_name, scope, ast)
        else
          _509_ = compiler["symbol-to-expression"](fn_name, scope)[1]
        end
        return _509_, not multi, 3
      else
        return nil, true, 2
      end
    end
    local function compile_named_fn(ast, f_scope, f_chunk, parent, index, fn_name, local_3f, arg_name_list, f_metadata)
      utils.hook("pre-fn", ast, f_scope)
      for i = (index + 1), #ast do
        compiler.compile1(ast[i], f_scope, f_chunk, {nval = (((i ~= #ast) and 0) or nil), tail = (i == #ast)})
      end
      local _512_
      if local_3f then
        _512_ = "local function %s(%s)"
      else
        _512_ = "%s = function(%s)"
      end
      compiler.emit(parent, string.format(_512_, fn_name, table.concat(arg_name_list, ", ")), ast)
      compiler.emit(parent, f_chunk, ast)
      compiler.emit(parent, "end", ast)
      set_fn_metadata(f_metadata, parent, fn_name)
      utils.hook("fn", ast, f_scope)
      return utils.expr(fn_name, "sym")
    end
    local function compile_anonymous_fn(ast, f_scope, f_chunk, parent, index, arg_name_list, f_metadata, scope)
      local fn_name = compiler.gensym(scope)
      return compile_named_fn(ast, f_scope, f_chunk, parent, index, fn_name, true, arg_name_list, f_metadata)
    end
    local function maybe_metadata(ast, pred, handler, mt, index)
      local index_2a = (index + 1)
      local index_2a_before_ast_end_3f = (index_2a < #ast)
      local expr = ast[index_2a]
      if (index_2a_before_ast_end_3f and pred(expr)) then
        return handler(mt, expr), index_2a
      else
        return mt, index
      end
    end
    local function get_function_metadata(ast, arg_list, index)
      local function _515_(_241, _242)
        local tbl_14_ = _241
        for k, v in pairs(_242) do
          local k_15_, v_16_ = k, v
          if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
            tbl_14_[k_15_] = v_16_
          end
        end
        return tbl_14_
      end
      local function _517_(_241, _242)
        _241["fnl/docstring"] = _242
        return _241
      end
      return maybe_metadata(ast, utils["kv-table?"], _515_, maybe_metadata(ast, utils["string?"], _517_, {["fnl/arglist"] = arg_list}, index))
    end
    SPECIALS.fn = function(ast, scope, parent, opts)
      local f_scope = nil
      do
        local _518_0 = compiler["make-scope"](scope)
        _518_0["vararg"] = false
        f_scope = _518_0
      end
      local f_chunk = {}
      local fn_sym = utils["sym?"](ast[2])
      local multi = (fn_sym and utils["multi-sym?"](fn_sym[1]))
      local fn_name, local_3f, index = get_fn_name(ast, scope, fn_sym, multi, opts)
      local arg_list = compiler.assert(utils["table?"](ast[index]), "expected parameters table", ast)
      compiler.assert((not multi or not multi["multi-sym-method-call"]), ("unexpected multi symbol " .. tostring(fn_name)), fn_sym)
      if (multi and not scope.symmeta[multi[1]] and not compiler["global-allowed?"](multi[1])) then
        compiler.assert(nil, ("expected local table " .. multi[1]), ast[2])
      end
      local function destructure_arg(arg)
        local raw = utils.sym(compiler.gensym(scope))
        local declared = compiler["declare-local"](raw, f_scope, ast)
        compiler.destructure(arg, raw, ast, f_scope, f_chunk, {declaration = true, nomulti = true, symtype = "arg"})
        return declared
      end
      local function destructure_amp(i)
        compiler.assert((i == (#arg_list - 1)), "expected rest argument before last parameter", arg_list[(i + 1)], arg_list)
        f_scope.vararg = true
        compiler.destructure(arg_list[#arg_list], {utils.varg()}, ast, f_scope, f_chunk, {declaration = true, nomulti = true, symtype = "arg"})
        return "..."
      end
      local function get_arg_name(arg, i)
        if f_scope.vararg then
          return nil
        elseif utils["varg?"](arg) then
          compiler.assert((arg == arg_list[#arg_list]), "expected vararg as last parameter", ast)
          f_scope.vararg = true
          return "..."
        elseif utils["sym?"](arg, "&") then
          return destructure_amp(i)
        elseif (utils["sym?"](arg) and (tostring(arg) ~= "nil") and not utils["multi-sym?"](tostring(arg))) then
          return compiler["declare-local"](arg, f_scope, ast)
        elseif utils["table?"](arg) then
          return destructure_arg(arg)
        else
          return compiler.assert(false, ("expected symbol for function parameter: %s"):format(tostring(arg)), ast[index])
        end
      end
      local arg_name_list = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i, a in ipairs(arg_list) do
          local val_19_ = get_arg_name(a, i)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        arg_name_list = tbl_17_
      end
      local f_metadata, index0 = get_function_metadata(ast, arg_list, index)
      if fn_name then
        return compile_named_fn(ast, f_scope, f_chunk, parent, index0, fn_name, local_3f, arg_name_list, f_metadata)
      else
        return compile_anonymous_fn(ast, f_scope, f_chunk, parent, index0, arg_name_list, f_metadata, scope)
      end
    end
    doc_special("fn", {"name?", "args", "docstring?", "..."}, "Function syntax. May optionally include a name and docstring or a metadata table.\nIf a name is provided, the function will be bound in the current scope.\nWhen called with the wrong number of args, excess args will be discarded\nand lacking args will be nil, use lambda for arity-checked functions.", true)
    SPECIALS.lua = function(ast, _, parent)
      compiler.assert(((#ast == 2) or (#ast == 3)), "expected 1 or 2 arguments", ast)
      local _524_
      do
        local _523_0 = utils["sym?"](ast[2])
        if (nil ~= _523_0) then
          _524_ = tostring(_523_0)
        else
          _524_ = _523_0
        end
      end
      if ("nil" ~= _524_) then
        table.insert(parent, {ast = ast, leaf = tostring(ast[2])})
      end
      local _528_
      do
        local _527_0 = utils["sym?"](ast[3])
        if (nil ~= _527_0) then
          _528_ = tostring(_527_0)
        else
          _528_ = _527_0
        end
      end
      if ("nil" ~= _528_) then
        return tostring(ast[3])
      end
    end
    local function dot(ast, scope, parent)
      compiler.assert((1 < #ast), "expected table argument", ast)
      local len = #ast
      local lhs_node = compiler.macroexpand(ast[2], scope)
      local _531_ = compiler.compile1(lhs_node, scope, parent, {nval = 1})
      local lhs = _531_[1]
      if (len == 2) then
        return tostring(lhs)
      else
        local indices = {}
        for i = 3, len do
          local index = ast[i]
          if (utils["string?"](index) and utils["valid-lua-identifier?"](index)) then
            table.insert(indices, ("." .. index))
          else
            local _532_ = compiler.compile1(index, scope, parent, {nval = 1})
            local index0 = _532_[1]
            table.insert(indices, ("[" .. tostring(index0) .. "]"))
          end
        end
        if (not (utils["sym?"](lhs_node) or utils["list?"](lhs_node)) or ("nil" == tostring(lhs_node))) then
          return ("(" .. tostring(lhs) .. ")" .. table.concat(indices))
        else
          return (tostring(lhs) .. table.concat(indices))
        end
      end
    end
    SPECIALS["."] = dot
    doc_special(".", {"tbl", "key1", "..."}, "Look up key1 in tbl table. If more args are provided, do a nested lookup.")
    SPECIALS.global = function(ast, scope, parent)
      compiler.assert((#ast == 3), "expected name and value", ast)
      compiler.destructure(ast[2], ast[3], ast, scope, parent, {forceglobal = true, nomulti = true, symtype = "global"})
      return nil
    end
    doc_special("global", {"name", "val"}, "Set name as a global with val. Deprecated.")
    SPECIALS.set = function(ast, scope, parent)
      compiler.assert((#ast == 3), "expected name and value", ast)
      compiler.destructure(ast[2], ast[3], ast, scope, parent, {noundef = true, symtype = "set"})
      return nil
    end
    doc_special("set", {"name", "val"}, "Set a local variable to a new value. Only works on locals using var.")
    local function set_forcibly_21_2a(ast, scope, parent)
      compiler.assert((#ast == 3), "expected name and value", ast)
      compiler.destructure(ast[2], ast[3], ast, scope, parent, {forceset = true, symtype = "set"})
      return nil
    end
    SPECIALS["set-forcibly!"] = set_forcibly_21_2a
    local function local_2a(ast, scope, parent, opts)
      compiler.assert(((0 == opts.nval) or opts.tail), "can't introduce local here", ast)
      compiler.assert((#ast == 3), "expected name and value", ast)
      compiler.destructure(ast[2], ast[3], ast, scope, parent, {declaration = true, nomulti = true, symtype = "local"})
      return nil
    end
    SPECIALS["local"] = local_2a
    doc_special("local", {"name", "val"}, "Introduce new top-level immutable local.")
    SPECIALS.var = function(ast, scope, parent, opts)
      compiler.assert(((0 == opts.nval) or opts.tail), "can't introduce var here", ast)
      compiler.assert((#ast == 3), "expected name and value", ast)
      compiler.destructure(ast[2], ast[3], ast, scope, parent, {declaration = true, isvar = true, nomulti = true, symtype = "var"})
      return nil
    end
    doc_special("var", {"name", "val"}, "Introduce new mutable local.")
    local function kv_3f(t)
      local _536_
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for k in pairs(t) do
          local val_19_ = nil
          if ("number" ~= type(k)) then
            val_19_ = k
          else
          val_19_ = nil
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        _536_ = tbl_17_
      end
      return _536_[1]
    end
    SPECIALS.let = function(_539_0, scope, parent, opts)
      local _540_ = _539_0
      local _ = _540_[1]
      local bindings = _540_[2]
      local ast = _540_
      compiler.assert((utils["table?"](bindings) and not kv_3f(bindings)), "expected binding sequence", (bindings or ast[1]))
      compiler.assert(((#bindings % 2) == 0), "expected even number of name/value bindings", bindings)
      compiler.assert((3 <= #ast), "expected body expression", ast[1])
      local pre_syms = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _0 = 1, (opts.nval or 0) do
          local val_19_ = compiler.gensym(scope)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        pre_syms = tbl_17_
      end
      local sub_scope = compiler["make-scope"](scope)
      local sub_chunk = {}
      for i = 1, #bindings, 2 do
        compiler.destructure(bindings[i], bindings[(i + 1)], ast, sub_scope, sub_chunk, {declaration = true, nomulti = true, symtype = "let"})
      end
      return SPECIALS["do"](ast, scope, parent, opts, 3, sub_chunk, sub_scope, pre_syms)
    end
    doc_special("let", {"[name1 val1 ... nameN valN]", "..."}, "Introduces a new scope in which a given set of local bindings are used.", true)
    local function get_prev_line(parent)
      if ("table" == type(parent)) then
        return get_prev_line((parent.leaf or parent[#parent]))
      else
        return (parent or "")
      end
    end
    local function needs_separator_3f(root, prev_line)
      return (root:match("^%(") and prev_line and not prev_line:find(" end$"))
    end
    SPECIALS.tset = function(ast, scope, parent)
      compiler.assert((3 < #ast), "expected table, key, and value arguments", ast)
      compiler.assert(((type(ast[2]) ~= "boolean") and (type(ast[2]) ~= "number")), "cannot set field of literal value", ast)
      local root = str1(compiler.compile1(ast[2], scope, parent, {nval = 1}))
      local root0 = nil
      if root:match("^[.{\"]") then
        root0 = string.format("(%s)", root)
      else
        root0 = root
      end
      local keys = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i = 3, (#ast - 1) do
          local val_19_ = str1(compiler.compile1(ast[i], scope, parent, {nval = 1}))
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        keys = tbl_17_
      end
      local value = str1(compiler.compile1(ast[#ast], scope, parent, {nval = 1}))
      local fmtstr = nil
      if needs_separator_3f(root0, get_prev_line(parent)) then
        fmtstr = "do end %s[%s] = %s"
      else
        fmtstr = "%s[%s] = %s"
      end
      return compiler.emit(parent, fmtstr:format(root0, table.concat(keys, "]["), value), ast)
    end
    doc_special("tset", {"tbl", "key1", "...", "keyN", "val"}, "Set the value of a table field. Deprecated in favor of set.")
    local function calculate_if_target(scope, opts)
      if not (opts.tail or opts.target or opts.nval) then
        return "iife", true, nil
      elseif (opts.nval and (opts.nval ~= 0) and not opts.target) then
        local accum = {}
        local target_exprs = {}
        for i = 1, opts.nval do
          local s = compiler.gensym(scope)
          accum[i] = s
          target_exprs[i] = utils.expr(s, "sym")
        end
        return "target", opts.tail, table.concat(accum, ", "), target_exprs
      else
        return "none", opts.tail, opts.target
      end
    end
    local function if_2a(ast, scope, parent, opts)
      compiler.assert((2 < #ast), "expected condition and body", ast)
      if ((1 == (#ast % 2)) and (ast[(#ast - 1)] == true)) then
        table.remove(ast, (#ast - 1))
      end
      if (1 == (#ast % 2)) then
        table.insert(ast, utils.sym("nil"))
      end
      if (#ast == 2) then
        return SPECIALS["do"](utils.list(utils.sym("do"), ast[2]), scope, parent, opts)
      else
        local do_scope = compiler["make-scope"](scope)
        local branches = {}
        local wrapper, inner_tail, inner_target, target_exprs = calculate_if_target(scope, opts)
        local body_opts = {nval = opts.nval, tail = inner_tail, target = inner_target}
        local function compile_body(i)
          local chunk = {}
          local cscope = compiler["make-scope"](do_scope)
          compiler["keep-side-effects"](compiler.compile1(ast[i], cscope, chunk, body_opts), chunk, nil, ast[i])
          return {chunk = chunk, scope = cscope}
        end
        for i = 2, (#ast - 1), 2 do
          local condchunk = {}
          local _549_ = compiler.compile1(ast[i], do_scope, condchunk, {nval = 1})
          local cond = _549_[1]
          local branch = compile_body((i + 1))
          branch.cond = cond
          branch.condchunk = condchunk
          branch.nested = ((i ~= 2) and (next(condchunk, nil) == nil))
          table.insert(branches, branch)
        end
        local else_branch = compile_body(#ast)
        local s = compiler.gensym(scope)
        local buffer = {}
        local last_buffer = buffer
        for i = 1, #branches do
          local branch = branches[i]
          local fstr = nil
          if not branch.nested then
            fstr = "if %s then"
          else
            fstr = "elseif %s then"
          end
          local cond = tostring(branch.cond)
          local cond_line = fstr:format(cond)
          if branch.nested then
            compiler.emit(last_buffer, branch.condchunk, ast)
          else
            for _, v in ipairs(branch.condchunk) do
              compiler.emit(last_buffer, v, ast)
            end
          end
          compiler.emit(last_buffer, cond_line, ast)
          compiler.emit(last_buffer, branch.chunk, ast)
          if (i == #branches) then
            compiler.emit(last_buffer, "else", ast)
            compiler.emit(last_buffer, else_branch.chunk, ast)
            compiler.emit(last_buffer, "end", ast)
          elseif not branches[(i + 1)].nested then
            local next_buffer = {}
            compiler.emit(last_buffer, "else", ast)
            compiler.emit(last_buffer, next_buffer, ast)
            compiler.emit(last_buffer, "end", ast)
            last_buffer = next_buffer
          end
        end
        if (wrapper == "iife") then
          local iifeargs = ((scope.vararg and "...") or "")
          compiler.emit(parent, ("local function %s(%s)"):format(tostring(s), iifeargs), ast)
          compiler.emit(parent, buffer, ast)
          compiler.emit(parent, "end", ast)
          return utils.expr(("%s(%s)"):format(tostring(s), iifeargs), "statement")
        elseif (wrapper == "none") then
          for i = 1, #buffer do
            compiler.emit(parent, buffer[i], ast)
          end
          return {returned = true}
        else
          compiler.emit(parent, ("local %s"):format(inner_target), ast)
          for i = 1, #buffer do
            compiler.emit(parent, buffer[i], ast)
          end
          return target_exprs
        end
      end
    end
    SPECIALS["if"] = if_2a
    doc_special("if", {"cond1", "body1", "...", "condN", "bodyN"}, "Conditional form.\nTakes any number of condition/body pairs and evaluates the first body where\nthe condition evaluates to truthy. Similar to cond in other lisps.")
    local function clause_3f(v)
      return (utils["string?"](v) or (utils["sym?"](v) and not utils["multi-sym?"](v) and tostring(v):match("^&(.+)")))
    end
    local function remove_until_condition(bindings, ast)
      local _until = nil
      for i = (#bindings - 1), 3, -1 do
        local _555_0 = clause_3f(bindings[i])
        if ((_555_0 == false) or (_555_0 == nil)) then
        elseif (nil ~= _555_0) then
          local clause = _555_0
          compiler.assert(((clause == "until") and not _until), ("unexpected iterator clause: " .. clause), ast)
          table.remove(bindings, i)
          _until = table.remove(bindings, i)
        end
      end
      return _until
    end
    local function compile_until(_3fcondition, scope, chunk)
      if _3fcondition then
        local _557_ = compiler.compile1(_3fcondition, scope, chunk, {nval = 1})
        local condition_lua = _557_[1]
        return compiler.emit(chunk, ("if %s then break end"):format(tostring(condition_lua)), utils.expr(_3fcondition, "expression"))
      end
    end
    local function iterator_bindings(ast)
      local bindings = utils.copy(ast)
      local _3funtil = remove_until_condition(bindings, ast)
      local iter = table.remove(bindings)
      local bindings0 = nil
      if (1 == #bindings) then
        bindings0 = (utils["list?"](bindings[1]) or bindings)
      else
        for _, b in ipairs(bindings) do
          if utils["list?"](b) then
            utils.warn("unexpected parens in iterator", b)
          end
        end
        bindings0 = bindings
      end
      return bindings0, iter, _3funtil
    end
    SPECIALS.each = function(ast, scope, parent)
      compiler.assert((3 <= #ast), "expected body expression", ast[1])
      compiler.assert(utils["table?"](ast[2]), "expected binding table", ast)
      local sub_scope = compiler["make-scope"](scope)
      local binding, iter, _3funtil_condition = iterator_bindings(ast[2])
      local destructures = {}
      local deferred_scope_changes = {manglings = {}, symmeta = {}}
      utils.hook("pre-each", ast, sub_scope, binding, iter, _3funtil_condition)
      local function destructure_binding(v)
        if utils["sym?"](v) then
          return compiler["declare-local"](v, sub_scope, ast, nil, deferred_scope_changes)
        else
          local raw = utils.sym(compiler.gensym(sub_scope))
          destructures[raw] = v
          return compiler["declare-local"](raw, sub_scope, ast)
        end
      end
      local bind_vars = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _, b in ipairs(binding) do
          local val_19_ = destructure_binding(b)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        bind_vars = tbl_17_
      end
      local vals = compiler.compile1(iter, scope, parent)
      local val_names = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _, v in ipairs(vals) do
          local val_19_ = tostring(v)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        val_names = tbl_17_
      end
      local chunk = {}
      compiler.assert(bind_vars[1], "expected binding and iterator", ast)
      compiler.emit(parent, ("for %s in %s do"):format(table.concat(bind_vars, ", "), table.concat(val_names, ", ")), ast)
      for raw, args in utils.stablepairs(destructures) do
        compiler.destructure(args, raw, ast, sub_scope, chunk, {declaration = true, nomulti = true, symtype = "each"})
      end
      compiler["apply-deferred-scope-changes"](sub_scope, deferred_scope_changes, ast)
      compile_until(_3funtil_condition, sub_scope, chunk)
      compile_do(ast, sub_scope, chunk, 3)
      compiler.emit(parent, chunk, ast)
      return compiler.emit(parent, "end", ast)
    end
    doc_special("each", {"[key value (iterator)]", "..."}, "Runs the body once for each set of values provided by the given iterator.\nMost commonly used with ipairs for sequential tables or pairs for  undefined\norder, but can be used with any iterator.", true)
    local function while_2a(ast, scope, parent)
      local len1 = #parent
      local condition = compiler.compile1(ast[2], scope, parent, {nval = 1})[1]
      local len2 = #parent
      local sub_chunk = {}
      if (len1 ~= len2) then
        for i = (len1 + 1), len2 do
          table.insert(sub_chunk, parent[i])
          parent[i] = nil
        end
        compiler.emit(parent, "while true do", ast)
        compiler.emit(sub_chunk, ("if not %s then break end"):format(condition[1]), ast)
      else
        compiler.emit(parent, ("while " .. tostring(condition) .. " do"), ast)
      end
      compile_do(ast, compiler["make-scope"](scope), sub_chunk, 3)
      compiler.emit(parent, sub_chunk, ast)
      return compiler.emit(parent, "end", ast)
    end
    SPECIALS["while"] = while_2a
    doc_special("while", {"condition", "..."}, "The classic while loop. Evaluates body until a condition is non-truthy.", true)
    local function for_2a(ast, scope, parent)
      compiler.assert(utils["table?"](ast[2]), "expected binding table", ast)
      local ranges = setmetatable(utils.copy(ast[2]), getmetatable(ast[2]))
      local until_condition = remove_until_condition(ranges, ast)
      local binding_sym = table.remove(ranges, 1)
      local sub_scope = compiler["make-scope"](scope)
      local range_args = {}
      local chunk = {}
      compiler.assert(utils["sym?"](binding_sym), ("unable to bind %s %s"):format(type(binding_sym), tostring(binding_sym)), ast[2])
      compiler.assert((3 <= #ast), "expected body expression", ast[1])
      compiler.assert((#ranges <= 3), "unexpected arguments", ranges)
      compiler.assert((1 < #ranges), "expected range to include start and stop", ranges)
      utils.hook("pre-for", ast, sub_scope, binding_sym)
      for i = 1, math.min(#ranges, 3) do
        range_args[i] = str1(compiler.compile1(ranges[i], scope, parent, {nval = 1}))
      end
      compiler.emit(parent, ("for %s = %s do"):format(compiler["declare-local"](binding_sym, sub_scope, ast), table.concat(range_args, ", ")), ast)
      compile_until(until_condition, sub_scope, chunk)
      compile_do(ast, sub_scope, chunk, 3)
      compiler.emit(parent, chunk, ast)
      return compiler.emit(parent, "end", ast)
    end
    SPECIALS["for"] = for_2a
    doc_special("for", {"[index start stop step?]", "..."}, "Numeric loop construct.\nEvaluates body once for each value between start and stop (inclusive).", true)
    local function method_special_type(ast)
      if (utils["string?"](ast[3]) and utils["valid-lua-identifier?"](ast[3])) then
        return "native"
      elseif utils["sym?"](ast[2]) then
        return "nonnative"
      else
        return "binding"
      end
    end
    local function native_method_call(ast, _scope, _parent, target, args)
      local _566_ = ast
      local _ = _566_[1]
      local _0 = _566_[2]
      local method_string = _566_[3]
      local call_string = nil
      if ((target.type == "literal") or (target.type == "varg") or ((target.type == "expression") and not (target[1]):match("[%)%]]$") and not (target[1]):match("%.[%a_][%w_]*$"))) then
        call_string = "(%s):%s(%s)"
      else
        call_string = "%s:%s(%s)"
      end
      return utils.expr(string.format(call_string, tostring(target), method_string, table.concat(args, ", ")), "statement")
    end
    local function nonnative_method_call(ast, scope, parent, target, args)
      local method_string = str1(compiler.compile1(ast[3], scope, parent, {nval = 1}))
      local args0 = {tostring(target), unpack(args)}
      return utils.expr(string.format("%s[%s](%s)", tostring(target), method_string, table.concat(args0, ", ")), "statement")
    end
    local function binding_method_call(ast, scope, parent, target, args)
      local method_string = str1(compiler.compile1(ast[3], scope, parent, {nval = 1}))
      local target_local = compiler.gensym(scope, "tgt")
      local args0 = {target_local, unpack(args)}
      compiler.emit(parent, string.format("local %s = %s", target_local, tostring(target)))
      return utils.expr(string.format("(%s)[%s](%s)", target_local, method_string, table.concat(args0, ", ")), "statement")
    end
    local function method_call(ast, scope, parent)
      compiler.assert((2 < #ast), "expected at least 2 arguments", ast)
      local _568_ = compiler.compile1(ast[2], scope, parent, {nval = 1})
      local target = _568_[1]
      local args = {}
      for i = 4, #ast do
        local subexprs = nil
        local _569_
        if (i ~= #ast) then
          _569_ = 1
        else
        _569_ = nil
        end
        subexprs = compiler.compile1(ast[i], scope, parent, {nval = _569_})
        local tbl_17_ = args
        local i_18_ = #tbl_17_
        for _, subexpr in ipairs(subexprs) do
          local val_19_ = tostring(subexpr)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
      end
      local _572_0 = method_special_type(ast)
      if (_572_0 == "native") then
        return native_method_call(ast, scope, parent, target, args)
      elseif (_572_0 == "nonnative") then
        return nonnative_method_call(ast, scope, parent, target, args)
      elseif (_572_0 == "binding") then
        return binding_method_call(ast, scope, parent, target, args)
      end
    end
    SPECIALS[":"] = method_call
    doc_special(":", {"tbl", "method-name", "..."}, "Call the named method on tbl with the provided args.\nMethod name doesn't have to be known at compile-time; if it is, use\n(tbl:method-name ...) instead.")
    SPECIALS.comment = function(ast, _, parent)
      local c = nil
      local _574_
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i, elt in ipairs(ast) do
          local val_19_ = nil
          if (i ~= 1) then
            val_19_ = view(elt, {["one-line?"] = true})
          else
          val_19_ = nil
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        _574_ = tbl_17_
      end
      c = table.concat(_574_, " "):gsub("%]%]", "]\\]")
      return compiler.emit(parent, ("--[[ " .. c .. " ]]"), ast)
    end
    doc_special("comment", {"..."}, "Comment which will be emitted in Lua output.", true)
    local function hashfn_max_used(f_scope, i, max)
      local max0 = nil
      if f_scope.symmeta[("$" .. i)].used then
        max0 = i
      else
        max0 = max
      end
      if (i < 9) then
        return hashfn_max_used(f_scope, (i + 1), max0)
      else
        return max0
      end
    end
    SPECIALS.hashfn = function(ast, scope, parent)
      compiler.assert((#ast == 2), "expected one argument", ast)
      local f_scope = nil
      do
        local _579_0 = compiler["make-scope"](scope)
        _579_0["vararg"] = false
        _579_0["hashfn"] = true
        f_scope = _579_0
      end
      local f_chunk = {}
      local name = compiler.gensym(scope)
      local symbol = utils.sym(name)
      local args = {}
      compiler["declare-local"](symbol, scope, ast)
      for i = 1, 9 do
        args[i] = compiler["declare-local"](utils.sym(("$" .. i)), f_scope, ast)
      end
      local function walker(idx, node, _3fparent_node)
        if utils["sym?"](node, "$...") then
          f_scope.vararg = true
          if _3fparent_node then
            _3fparent_node[idx] = utils.varg()
            return nil
          else
            return utils.varg()
          end
        else
          return ((utils["list?"](node) and (not _3fparent_node or not utils["sym?"](node[1], "hashfn"))) or utils["table?"](node))
        end
      end
      utils["walk-tree"](ast, walker)
      compiler.compile1(ast[2], f_scope, f_chunk, {tail = true})
      local max_used = hashfn_max_used(f_scope, 1, 0)
      if f_scope.vararg then
        compiler.assert((max_used == 0), "$ and $... in hashfn are mutually exclusive", ast)
      end
      local arg_str = nil
      if f_scope.vararg then
        arg_str = tostring(utils.varg())
      else
        arg_str = table.concat(args, ", ", 1, max_used)
      end
      compiler.emit(parent, string.format("local function %s(%s)", name, arg_str), ast)
      compiler.emit(parent, f_chunk, ast)
      compiler.emit(parent, "end", ast)
      return utils.expr(name, "sym")
    end
    doc_special("hashfn", {"..."}, "Function literal shorthand; args are either $... OR $1, $2, etc.")
    local function comparator_special_type(ast)
      if (3 == #ast) then
        return "native"
      elseif utils["every?"]({unpack(ast, 3, (#ast - 1))}, utils["idempotent-expr?"]) then
        return "idempotent"
      else
        return "binding"
      end
    end
    local function short_circuit_safe_3f(x, scope)
      if (("table" ~= type(x)) or utils["sym?"](x) or utils["varg?"](x)) then
        return true
      elseif utils["table?"](x) then
        local ok = true
        for k, v in pairs(x) do
          if not ok then break end
          ok = (short_circuit_safe_3f(v, scope) and short_circuit_safe_3f(k, scope))
        end
        return ok
      elseif utils["list?"](x) then
        if utils["sym?"](x[1]) then
          local _585_0 = str1(x)
          if ((_585_0 == "fn") or (_585_0 == "hashfn") or (_585_0 == "let") or (_585_0 == "local") or (_585_0 == "var") or (_585_0 == "set") or (_585_0 == "tset") or (_585_0 == "if") or (_585_0 == "each") or (_585_0 == "for") or (_585_0 == "while") or (_585_0 == "do") or (_585_0 == "lua") or (_585_0 == "global")) then
            return false
          elseif (((_585_0 == "<") or (_585_0 == ">") or (_585_0 == "<=") or (_585_0 == ">=") or (_585_0 == "=") or (_585_0 == "not=") or (_585_0 == "~=")) and (comparator_special_type(x) == "binding")) then
            return false
          else
            local function _586_()
              return (1 ~= x[2])
            end
            if ((_585_0 == "pick-values") and _586_()) then
              return false
            else
              local function _587_()
                local call = _585_0
                return scope.macros[call]
              end
              if ((nil ~= _585_0) and _587_()) then
                local call = _585_0
                return false
              else
                local function _588_()
                  return (method_special_type(x) == "binding")
                end
                if ((_585_0 == ":") and _588_()) then
                  return false
                else
                  local _ = _585_0
                  local ok = true
                  for i = 2, #x do
                    if not ok then break end
                    ok = short_circuit_safe_3f(x[i], scope)
                  end
                  return ok
                end
              end
            end
          end
        else
          local ok = true
          for _, v in ipairs(x) do
            if not ok then break end
            ok = short_circuit_safe_3f(v, scope)
          end
          return ok
        end
      end
    end
    local function operator_special_result(ast, zero_arity, unary_prefix, padded_op, operands)
      local _592_0 = #operands
      if (_592_0 == 0) then
        if zero_arity then
          return utils.expr(zero_arity, "literal")
        else
          return compiler.assert(false, "Expected more than 0 arguments", ast)
        end
      elseif (_592_0 == 1) then
        if unary_prefix then
          return ("(" .. unary_prefix .. padded_op .. operands[1] .. ")")
        else
          return operands[1]
        end
      else
        local _ = _592_0
        return ("(" .. table.concat(operands, padded_op) .. ")")
      end
    end
    local function emit_short_circuit_if(ast, scope, parent, name, subast, accumulator, expr_string, setter)
      if (accumulator ~= expr_string) then
        compiler.emit(parent, string.format(setter, accumulator, expr_string), ast)
      end
      local function _597_()
        if (name == "and") then
          return accumulator
        else
          return ("not " .. accumulator)
        end
      end
      compiler.emit(parent, ("if %s then"):format(_597_()), subast)
      do
        local chunk = {}
        compiler.compile1(subast, scope, chunk, {nval = 1, target = accumulator})
        compiler.emit(parent, chunk)
      end
      return compiler.emit(parent, "end")
    end
    local function operator_special(name, zero_arity, unary_prefix, ast, scope, parent)
      compiler.assert(not ((#ast == 2) and utils["varg?"](ast[2])), "tried to use vararg with operator", ast)
      local padded_op = (" " .. name .. " ")
      local operands, accumulator = {}
      if utils["call-of?"](ast[#ast], "values") then
        utils.warn("multiple values in operators are deprecated", ast)
      end
      for subast in iter_args(ast) do
        if ((nil ~= next(operands)) and ((name == "or") or (name == "and")) and not short_circuit_safe_3f(subast, scope)) then
          local expr_string = table.concat(operands, padded_op)
          local setter = nil
          if accumulator then
            setter = "%s = %s"
          else
            setter = "local %s = %s"
          end
          if not accumulator then
            accumulator = compiler.gensym(scope, name)
          end
          emit_short_circuit_if(ast, scope, parent, name, subast, accumulator, expr_string, setter)
          operands = {accumulator}
        else
          table.insert(operands, str1(compiler.compile1(subast, scope, parent, {nval = 1})))
        end
      end
      return operator_special_result(ast, zero_arity, unary_prefix, padded_op, operands)
    end
    local function define_arithmetic_special(name, zero_arity, unary_prefix, _3flua_name)
      local _603_
      do
        local _602_0 = (_3flua_name or name)
        local function _604_(...)
          return operator_special(_602_0, zero_arity, unary_prefix, ...)
        end
        _603_ = _604_
      end
      SPECIALS[name] = _603_
      return doc_special(name, {"a", "b", "..."}, "Arithmetic operator; works the same as Lua but accepts more arguments.")
    end
    define_arithmetic_special("+", "0", "0")
    define_arithmetic_special("..", "''")
    define_arithmetic_special("^")
    define_arithmetic_special("-", nil, "")
    define_arithmetic_special("*", "1", "1")
    define_arithmetic_special("%")
    define_arithmetic_special("/", nil, "1")
    define_arithmetic_special("//", nil, "1")
    SPECIALS["or"] = function(ast, scope, parent)
      return operator_special("or", "false", nil, ast, scope, parent)
    end
    SPECIALS["and"] = function(ast, scope, parent)
      return operator_special("and", "true", nil, ast, scope, parent)
    end
    doc_special("and", {"a", "b", "..."}, "Boolean operator; works the same as Lua but accepts more arguments.")
    doc_special("or", {"a", "b", "..."}, "Boolean operator; works the same as Lua but accepts more arguments.")
    local function bitop_special(native_name, lib_name, zero_arity, unary_prefix, ast, scope, parent)
      if (#ast == 1) then
        return compiler.assert(zero_arity, "Expected more than 0 arguments.", ast)
      else
        local len = #ast
        local operands = {}
        local padded_native_name = (" " .. native_name .. " ")
        local prefixed_lib_name = ("bit." .. lib_name)
        for i = 2, len do
          local subexprs = nil
          local _605_
          if (i ~= len) then
            _605_ = 1
          else
          _605_ = nil
          end
          subexprs = compiler.compile1(ast[i], scope, parent, {nval = _605_})
          local tbl_17_ = operands
          local i_18_ = #tbl_17_
          for _, s in ipairs(subexprs) do
            local val_19_ = tostring(s)
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
        end
        if (#operands == 1) then
          if utils.root.options.useBitLib then
            return (prefixed_lib_name .. "(" .. unary_prefix .. ", " .. operands[1] .. ")")
          else
            return ("(" .. unary_prefix .. padded_native_name .. operands[1] .. ")")
          end
        else
          if utils.root.options.useBitLib then
            return (prefixed_lib_name .. "(" .. table.concat(operands, ", ") .. ")")
          else
            return ("(" .. table.concat(operands, padded_native_name) .. ")")
          end
        end
      end
    end
    local function define_bitop_special(name, zero_arity, unary_prefix, native)
      local function _612_(...)
        return bitop_special(native, name, zero_arity, unary_prefix, ...)
      end
      SPECIALS[name] = _612_
      return nil
    end
    define_bitop_special("lshift", nil, "1", "<<")
    define_bitop_special("rshift", nil, "1", ">>")
    define_bitop_special("band", "-1", "-1", "&")
    define_bitop_special("bor", "0", "0", "|")
    define_bitop_special("bxor", "0", "0", "~")
    doc_special("lshift", {"x", "n"}, "Bitwise logical left shift of x by n bits.\nOnly works in Lua 5.3+ or LuaJIT with the --use-bit-lib flag.")
    doc_special("rshift", {"x", "n"}, "Bitwise logical right shift of x by n bits.\nOnly works in Lua 5.3+ or LuaJIT with the --use-bit-lib flag.")
    doc_special("band", {"x1", "x2", "..."}, "Bitwise AND of any number of arguments.\nOnly works in Lua 5.3+ or LuaJIT with the --use-bit-lib flag.")
    doc_special("bor", {"x1", "x2", "..."}, "Bitwise OR of any number of arguments.\nOnly works in Lua 5.3+ or LuaJIT with the --use-bit-lib flag.")
    doc_special("bxor", {"x1", "x2", "..."}, "Bitwise XOR of any number of arguments.\nOnly works in Lua 5.3+ or LuaJIT with the --use-bit-lib flag.")
    SPECIALS.bnot = function(ast, scope, parent)
      compiler.assert((#ast == 2), "expected one argument", ast)
      local _613_ = compiler.compile1(ast[2], scope, parent, {nval = 1})
      local value = _613_[1]
      if utils.root.options.useBitLib then
        return ("bit.bnot(" .. tostring(value) .. ")")
      else
        return ("~(" .. tostring(value) .. ")")
      end
    end
    doc_special("bnot", {"x"}, "Bitwise negation; only works in Lua 5.3+ or LuaJIT with the --use-bit-lib flag.")
    doc_special("..", {"a", "b", "..."}, "String concatenation operator; works the same as Lua but accepts more arguments.")
    local function native_comparator(op, _615_0, scope, parent)
      local _616_ = _615_0
      local _ = _616_[1]
      local lhs_ast = _616_[2]
      local rhs_ast = _616_[3]
      local _617_ = compiler.compile1(lhs_ast, scope, parent, {nval = 1})
      local lhs = _617_[1]
      local _618_ = compiler.compile1(rhs_ast, scope, parent, {nval = 1})
      local rhs = _618_[1]
      return string.format("(%s %s %s)", tostring(lhs), op, tostring(rhs))
    end
    local function idempotent_comparator(op, chain_op, ast, scope, parent)
      local vals = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i = 2, #ast do
          local val_19_ = str1(compiler.compile1(ast[i], scope, parent, {nval = 1}))
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        vals = tbl_17_
      end
      local comparisons = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i = 1, (#vals - 1) do
          local val_19_ = string.format("(%s %s %s)", vals[i], op, vals[(i + 1)])
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        comparisons = tbl_17_
      end
      local chain = string.format(" %s ", (chain_op or "and"))
      return ("(" .. table.concat(comparisons, chain) .. ")")
    end
    local function binding_comparator(op, chain_op, ast, scope, parent)
      local binding_left = {}
      local binding_right = {}
      local vals = {}
      local chain = string.format(" %s ", (chain_op or "and"))
      for i = 2, #ast do
        local compiled = str1(compiler.compile1(ast[i], scope, parent, {nval = 1}))
        if (utils["idempotent-expr?"](ast[i]) or (i == 2) or (i == #ast)) then
          table.insert(vals, compiled)
        else
          local my_sym = compiler.gensym(scope)
          table.insert(binding_left, my_sym)
          table.insert(binding_right, compiled)
          table.insert(vals, my_sym)
        end
      end
      compiler.emit(parent, string.format("local %s = %s", table.concat(binding_left, ", "), table.concat(binding_right, ", "), ast))
      local _622_
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i = 1, (#vals - 1) do
          local val_19_ = string.format("(%s %s %s)", vals[i], op, vals[(i + 1)])
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        _622_ = tbl_17_
      end
      return ("(" .. table.concat(_622_, chain) .. ")")
    end
    local function define_comparator_special(name, _3flua_op, _3fchain_op)
      do
        local op = (_3flua_op or name)
        local function opfn(ast, scope, parent)
          compiler.assert((2 < #ast), "expected at least two arguments", ast)
          local _624_0 = comparator_special_type(ast)
          if (_624_0 == "native") then
            return native_comparator(op, ast, scope, parent)
          elseif (_624_0 == "idempotent") then
            return idempotent_comparator(op, _3fchain_op, ast, scope, parent)
          elseif (_624_0 == "binding") then
            return binding_comparator(op, _3fchain_op, ast, scope, parent)
          else
            local _ = _624_0
            return error("internal compiler error. please report this to the fennel devs.")
          end
        end
        SPECIALS[name] = opfn
      end
      return doc_special(name, {"a", "b", "..."}, "Comparison operator; works the same as Lua but accepts more arguments.")
    end
    define_comparator_special(">")
    define_comparator_special("<")
    define_comparator_special(">=")
    define_comparator_special("<=")
    define_comparator_special("=", "==")
    define_comparator_special("not=", "~=", "or")
    local function define_unary_special(op, _3frealop)
      local function opfn(ast, scope, parent)
        compiler.assert((#ast == 2), "expected one argument", ast)
        local tail = compiler.compile1(ast[2], scope, parent, {nval = 1})
        return ((_3frealop or op) .. str1(tail))
      end
      SPECIALS[op] = opfn
      return nil
    end
    define_unary_special("not", "not ")
    doc_special("not", {"x"}, "Logical operator; works the same as Lua.")
    define_unary_special("length", "#")
    doc_special("length", {"x"}, "Returns the length of a table or string.")
    SPECIALS["~="] = SPECIALS["not="]
    SPECIALS["#"] = SPECIALS.length
    SPECIALS.quote = function(ast, scope, parent)
      compiler.assert((#ast == 2), "expected one argument", ast)
      local runtime, this_scope = true, scope
      while this_scope do
        this_scope = this_scope.parent
        if (this_scope == compiler.scopes.compiler) then
          runtime = false
        end
      end
      return compiler["do-quote"](ast[2], scope, parent, runtime)
    end
    doc_special("quote", {"x"}, "Quasiquote the following form. Only works in macro/compiler scope.")
    local macro_loaded = {}
    local function safe_getmetatable(tbl)
      local mt = getmetatable(tbl)
      assert((mt ~= getmetatable("")), "Illegal metatable access!")
      return mt
    end
    local safe_require = nil
    local function safe_compiler_env()
      local _628_
      do
        local _627_0 = rawget(_G, "utf8")
        if (nil ~= _627_0) then
          _628_ = utils.copy(_627_0)
        else
          _628_ = _627_0
        end
      end
      return {_VERSION = _VERSION, assert = assert, bit = rawget(_G, "bit"), error = error, getmetatable = safe_getmetatable, ipairs = ipairs, math = utils.copy(math), next = next, pairs = utils.stablepairs, pcall = pcall, print = print, rawequal = rawequal, rawget = rawget, rawlen = rawget(_G, "rawlen"), rawset = rawset, require = safe_require, select = select, setmetatable = setmetatable, string = utils.copy(string), table = utils.copy(table), tonumber = tonumber, tostring = tostring, type = type, utf8 = _628_, xpcall = xpcall}
    end
    local function combined_mt_pairs(env)
      local combined = {}
      local _630_ = getmetatable(env)
      local __index = _630_["__index"]
      if ("table" == type(__index)) then
        for k, v in pairs(__index) do
          combined[k] = v
        end
      end
      for k, v in next, env, nil do
        combined[k] = v
      end
      return next, combined, nil
    end
    local function make_compiler_env(ast, scope, parent, _3fopts)
      local provided = nil
      do
        local _632_0 = (_3fopts or utils.root.options)
        if ((_G.type(_632_0) == "table") and (_632_0["compiler-env"] == "strict")) then
          provided = safe_compiler_env()
        elseif ((_G.type(_632_0) == "table") and (nil ~= _632_0.compilerEnv)) then
          local compilerEnv = _632_0.compilerEnv
          provided = compilerEnv
        elseif ((_G.type(_632_0) == "table") and (nil ~= _632_0["compiler-env"])) then
          local compiler_env = _632_0["compiler-env"]
          provided = compiler_env
        else
          local _ = _632_0
          provided = safe_compiler_env()
        end
      end
      local env = nil
      local function _634_()
        return compiler.scopes.macro
      end
      local function _635_(symbol)
        compiler.assert(compiler.scopes.macro, "must call from macro", ast)
        return compiler.scopes.macro.manglings[tostring(symbol)]
      end
      local function _636_(base)
        return utils.sym(compiler.gensym((compiler.scopes.macro or scope), base))
      end
      local function _637_(form)
        compiler.assert(compiler.scopes.macro, "must call from macro", ast)
        return compiler.macroexpand(form, compiler.scopes.macro)
      end
      env = {["assert-compile"] = compiler.assert, ["ast-source"] = utils["ast-source"], ["comment?"] = utils["comment?"], ["fennel-module-name"] = fennel_module_name, ["get-scope"] = _634_, ["in-scope?"] = _635_, ["list?"] = utils["list?"], ["macro-loaded"] = macro_loaded, ["multi-sym?"] = utils["multi-sym?"], ["sequence?"] = utils["sequence?"], ["sym?"] = utils["sym?"], ["table?"] = utils["table?"], ["varg?"] = utils["varg?"], _AST = ast, _CHUNK = parent, _IS_COMPILER = true, _SCOPE = scope, _SPECIALS = compiler.scopes.global.specials, _VARARG = utils.varg(), comment = utils.comment, gensym = _636_, list = utils.list, macroexpand = _637_, sequence = utils.sequence, sym = utils.sym, unpack = unpack, version = utils.version, view = view}
      env._G = env
      return setmetatable(env, {__index = provided, __newindex = provided, __pairs = combined_mt_pairs})
    end
    local function _638_(...)
      local tbl_17_ = {}
      local i_18_ = #tbl_17_
      for c in string.gmatch((package.config or ""), "([^\n]+)") do
        local val_19_ = c
        if (nil ~= val_19_) then
          i_18_ = (i_18_ + 1)
          tbl_17_[i_18_] = val_19_
        end
      end
      return tbl_17_
    end
    local _640_ = _638_(...)
    local dirsep = _640_[1]
    local pathsep = _640_[2]
    local pathmark = _640_[3]
    local pkg_config = {dirsep = (dirsep or "/"), pathmark = (pathmark or "?"), pathsep = (pathsep or ";")}
    local function escapepat(str)
      return string.gsub(str, "[^%w]", "%%%1")
    end
    local function search_module(modulename, _3fpathstring)
      local pathsepesc = escapepat(pkg_config.pathsep)
      local pattern = ("([^%s]*)%s"):format(pathsepesc, pathsepesc)
      local no_dot_module = modulename:gsub("%.", pkg_config.dirsep)
      local fullpath = ((_3fpathstring or utils["fennel-module"].path) .. pkg_config.pathsep)
      local function try_path(path)
        local filename = path:gsub(escapepat(pkg_config.pathmark), no_dot_module)
        local filename2 = path:gsub(escapepat(pkg_config.pathmark), modulename)
        local _641_0 = (io.open(filename) or io.open(filename2))
        if (nil ~= _641_0) then
          local file = _641_0
          file:close()
          return filename
        else
          local _ = _641_0
          return nil, ("no file '" .. filename .. "'")
        end
      end
      local function find_in_path(start, _3ftried_paths)
        local _643_0 = fullpath:match(pattern, start)
        if (nil ~= _643_0) then
          local path = _643_0
          local _644_0, _645_0 = try_path(path)
          if (nil ~= _644_0) then
            local filename = _644_0
            return filename
          elseif ((_644_0 == nil) and (nil ~= _645_0)) then
            local error = _645_0
            local function _647_()
              local _646_0 = (_3ftried_paths or {})
              table.insert(_646_0, error)
              return _646_0
            end
            return find_in_path((start + #path + 1), _647_())
          end
        else
          local _ = _643_0
          local function _649_()
            local tried_paths = table.concat((_3ftried_paths or {}), "\n\9")
            if (_VERSION < "Lua 5.4") then
              return ("\n\9" .. tried_paths)
            else
              return tried_paths
            end
          end
          return nil, _649_()
        end
      end
      return find_in_path(1)
    end
    local function make_searcher(_3foptions)
      local function _652_(module_name)
        local opts = utils.copy(utils.root.options)
        for k, v in pairs((_3foptions or {})) do
          opts[k] = v
        end
        opts["module-name"] = module_name
        local _653_0, _654_0 = search_module(module_name)
        if (nil ~= _653_0) then
          local filename = _653_0
          local function _655_(...)
            return utils["fennel-module"].dofile(filename, opts, ...)
          end
          return _655_, filename
        elseif ((_653_0 == nil) and (nil ~= _654_0)) then
          local error = _654_0
          return error
        end
      end
      return _652_
    end
    local function dofile_with_searcher(fennel_macro_searcher, filename, opts, ...)
      local searchers = (package.loaders or package.searchers or {})
      local _ = table.insert(searchers, 1, fennel_macro_searcher)
      local m = utils["fennel-module"].dofile(filename, opts, ...)
      table.remove(searchers, 1)
      return m
    end
    local function fennel_macro_searcher(module_name)
      local opts = nil
      do
        local _657_0 = utils.copy(utils.root.options)
        _657_0["module-name"] = module_name
        _657_0["env"] = "_COMPILER"
        _657_0["requireAsInclude"] = false
        _657_0["allowedGlobals"] = nil
        opts = _657_0
      end
      local _658_0 = search_module(module_name, utils["fennel-module"]["macro-path"])
      if (nil ~= _658_0) then
        local filename = _658_0
        local _659_
        if (opts["compiler-env"] == _G) then
          local function _660_(...)
            return dofile_with_searcher(fennel_macro_searcher, filename, opts, ...)
          end
          _659_ = _660_
        else
          local function _661_(...)
            return utils["fennel-module"].dofile(filename, opts, ...)
          end
          _659_ = _661_
        end
        return _659_, filename
      end
    end
    local function lua_macro_searcher(module_name)
      local _664_0 = search_module(module_name, package.path)
      if (nil ~= _664_0) then
        local filename = _664_0
        local code = nil
        do
          local f = io.open(filename)
          local function close_handlers_10_(ok_11_, ...)
            f:close()
            if ok_11_ then
              return ...
            else
              return error(..., 0)
            end
          end
          local function _666_()
            return assert(f:read("*a"))
          end
          code = close_handlers_10_(_G.xpcall(_666_, (package.loaded.fennel or debug).traceback))
        end
        local chunk = load_code(code, make_compiler_env(), filename)
        return chunk, filename
      end
    end
    local macro_searchers = {fennel_macro_searcher, lua_macro_searcher}
    local function search_macro_module(modname, n)
      local _668_0 = macro_searchers[n]
      if (nil ~= _668_0) then
        local f = _668_0
        local _669_0, _670_0 = f(modname)
        if ((nil ~= _669_0) and true) then
          local loader = _669_0
          local _3ffilename = _670_0
          return loader, _3ffilename
        else
          local _ = _669_0
          return search_macro_module(modname, (n + 1))
        end
      end
    end
    local function sandbox_fennel_module(modname)
      if ((modname == "fennel.macros") or (package and package.loaded and ("table" == type(package.loaded[modname])) and (package.loaded[modname].metadata == compiler.metadata))) then
        local function _673_(_, ...)
          return (compiler.metadata):setall(...)
        end
        return {metadata = {setall = _673_}, view = view}
      end
    end
    local function _675_(modname)
      local function _676_()
        local loader, filename = search_macro_module(modname, 1)
        compiler.assert(loader, (modname .. " module not found."))
        macro_loaded[modname] = loader(modname, filename)
        return macro_loaded[modname]
      end
      return (macro_loaded[modname] or sandbox_fennel_module(modname) or _676_())
    end
    safe_require = _675_
    local function add_macros(macros_2a, ast, scope)
      compiler.assert(utils["table?"](macros_2a), "expected macros to be table", ast)
      for k, v in pairs(macros_2a) do
        compiler.assert((type(v) == "function"), "expected each macro to be function", ast)
        compiler["check-binding-valid"](utils.sym(k), scope, ast, {["macro?"] = true})
        scope.macros[k] = v
      end
      return nil
    end
    local function resolve_module_name(_677_0, _scope, _parent, opts)
      local _678_ = _677_0
      local second = _678_[2]
      local filename = _678_["filename"]
      local filename0 = (filename or (utils["table?"](second) and second.filename))
      local module_name = utils.root.options["module-name"]
      local modexpr = compiler.compile(second, opts)
      local modname_chunk = load_code(modexpr)
      return modname_chunk(module_name, filename0)
    end
    SPECIALS["require-macros"] = function(ast, scope, parent, _3freal_ast)
      compiler.assert((#ast == 2), "Expected one module name argument", (_3freal_ast or ast))
      local modname = resolve_module_name(ast, scope, parent, {})
      compiler.assert(utils["string?"](modname), "module name must compile to string", (_3freal_ast or ast))
      if not macro_loaded[modname] then
        local loader, filename = search_macro_module(modname, 1)
        compiler.assert(loader, (modname .. " module not found."), ast)
        macro_loaded[modname] = compiler.assert(utils["table?"](loader(modname, filename)), "expected macros to be table", (_3freal_ast or ast))
      end
      if ("import-macros" == str1(ast)) then
        return macro_loaded[modname]
      else
        return add_macros(macro_loaded[modname], ast, scope)
      end
    end
    doc_special("require-macros", {"macro-module-name"}, "Load given module and use its contents as macro definitions in current scope.\nDeprecated.")
    local function emit_included_fennel(src, path, opts, sub_chunk)
      local subscope = compiler["make-scope"](utils.root.scope.parent)
      local forms = {}
      if utils.root.options.requireAsInclude then
        subscope.specials.require = compiler["require-include"]
      end
      for _, val in parser.parser(parser["string-stream"](src), path) do
        table.insert(forms, val)
      end
      for i = 1, #forms do
        local subopts = nil
        if (i == #forms) then
          subopts = {tail = true}
        else
          subopts = {nval = 0}
        end
        utils["propagate-options"](opts, subopts)
        compiler.compile1(forms[i], subscope, sub_chunk, subopts)
      end
      return nil
    end
    local function include_path(ast, opts, path, mod, fennel_3f)
      utils.root.scope.includes[mod] = "fnl/loading"
      local src = nil
      do
        local f = assert(io.open(path))
        local function close_handlers_10_(ok_11_, ...)
          f:close()
          if ok_11_ then
            return ...
          else
            return error(..., 0)
          end
        end
        local function _684_()
          return assert(f:read("*all")):gsub("[\13\n]*$", "")
        end
        src = close_handlers_10_(_G.xpcall(_684_, (package.loaded.fennel or debug).traceback))
      end
      local ret = utils.expr(("require(\"" .. mod .. "\")"), "statement")
      local target = ("package.preload[%q]"):format(mod)
      local preload_str = (target .. " = " .. target .. " or function(...)")
      local temp_chunk, sub_chunk = {}, {}
      compiler.emit(temp_chunk, preload_str, ast)
      compiler.emit(temp_chunk, sub_chunk)
      compiler.emit(temp_chunk, "end", ast)
      for _, v in ipairs(temp_chunk) do
        table.insert(utils.root.chunk, v)
      end
      if fennel_3f then
        emit_included_fennel(src, path, opts, sub_chunk)
      else
        compiler.emit(sub_chunk, src, ast)
      end
      utils.root.scope.includes[mod] = ret
      return ret
    end
    local function include_circular_fallback(mod, modexpr, fallback, ast)
      if (utils.root.scope.includes[mod] == "fnl/loading") then
        compiler.assert(fallback, "circular include detected", ast)
        return fallback(modexpr)
      end
    end
    SPECIALS.include = function(ast, scope, parent, opts)
      compiler.assert((#ast == 2), "expected one argument", ast)
      local modexpr = nil
      do
        local _687_0, _688_0 = pcall(resolve_module_name, ast, scope, parent, opts)
        if ((_687_0 == true) and (nil ~= _688_0)) then
          local modname = _688_0
          modexpr = utils.expr(string.format("%q", modname), "literal")
        else
          local _ = _687_0
          modexpr = compiler.compile1(ast[2], scope, parent, {nval = 1})[1]
        end
      end
      if ((modexpr.type ~= "literal") or ((modexpr[1]):byte() ~= 34)) then
        if opts.fallback then
          return opts.fallback(modexpr)
        else
          return compiler.assert(false, "module name must be string literal", ast)
        end
      else
        local mod = load_code(("return " .. modexpr[1]))()
        local oldmod = utils.root.options["module-name"]
        local _ = nil
        utils.root.options["module-name"] = mod
        _ = nil
        local res = nil
        local function _692_()
          local _691_0 = search_module(mod)
          if (nil ~= _691_0) then
            local fennel_path = _691_0
            return include_path(ast, opts, fennel_path, mod, true)
          else
            local _0 = _691_0
            local lua_path = search_module(mod, package.path)
            if lua_path then
              return include_path(ast, opts, lua_path, mod, false)
            elseif opts.fallback then
              return opts.fallback(modexpr)
            else
              return compiler.assert(false, ("module not found " .. mod), ast)
            end
          end
        end
        res = ((utils["member?"](mod, (utils.root.options.skipInclude or {})) and opts.fallback(modexpr, true)) or include_circular_fallback(mod, modexpr, opts.fallback, ast) or utils.root.scope.includes[mod] or _692_())
        utils.root.options["module-name"] = oldmod
        return res
      end
    end
    doc_special("include", {"module-name-literal"}, "Like require but load the target module during compilation and embed it in the\nLua output. The module must be a string literal and resolvable at compile time.")
    local function eval_compiler_2a(ast, scope, parent)
      local env = make_compiler_env(ast, scope, parent)
      local opts = utils.copy(utils.root.options)
      opts.scope = compiler["make-scope"](compiler.scopes.compiler)
      opts.allowedGlobals = current_global_names(env)
      return assert(load_code(compiler.compile(ast, opts), wrap_env(env)))(opts["module-name"], ast.filename)
    end
    SPECIALS.macros = function(ast, scope, parent)
      compiler.assert((#ast == 2), "Expected one table argument", ast)
      local macro_tbl = eval_compiler_2a(ast[2], scope, parent)
      compiler.assert(utils["table?"](macro_tbl), "Expected one table argument", ast)
      return add_macros(macro_tbl, ast, scope)
    end
    doc_special("macros", {"{:macro-name-1 (fn [...] ...) ... :macro-name-N macro-body-N}"}, "Define all functions in the given table as macros local to the current scope.")
    SPECIALS["tail!"] = function(ast, scope, parent, opts)
      compiler.assert((#ast == 2), "Expected one argument", ast)
      local call = utils["list?"](compiler.macroexpand(ast[2], scope))
      local callee = tostring((call and utils["sym?"](call[1])))
      compiler.assert((call and not scope.specials[callee]), "Expected a function call as argument", ast)
      compiler.assert(opts.tail, "Must be in tail position", ast)
      return compiler.compile1(call, scope, parent, opts)
    end
    doc_special("tail!", {"body"}, "Assert that the body being called is in tail position.")
    SPECIALS["pick-values"] = function(ast, scope, parent)
      local n = ast[2]
      local vals = utils.list(utils.sym("values"), unpack(ast, 3))
      compiler.assert((("number" == type(n)) and (0 <= n) and (n == math.floor(n))), ("Expected n to be an integer >= 0, got " .. tostring(n)))
      if (1 == n) then
        local _696_ = compiler.compile1(vals, scope, parent, {nval = 1})
        local _697_ = _696_[1]
        local expr = _697_[1]
        return {("(" .. expr .. ")")}
      elseif (0 == n) then
        for i = 3, #ast do
          compiler["keep-side-effects"](compiler.compile1(ast[i], scope, parent, {nval = 0}), parent, nil, ast[i])
        end
        return {}
      else
        local syms = nil
        do
          local tbl_17_ = utils.list()
          local i_18_ = #tbl_17_
          for _ = 1, n do
            local val_19_ = utils.sym(compiler.gensym(scope, "pv"))
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          syms = tbl_17_
        end
        compiler.destructure(syms, vals, ast, scope, parent, {declaration = true, nomulti = true, noundef = true, symtype = "pv"})
        return syms
      end
    end
    doc_special("pick-values", {"n", "..."}, "Evaluate to exactly n values.\n\nFor example,\n  (pick-values 2 ...)\nexpands to\n  (let [(_0_ _1_) ...]\n    (values _0_ _1_))")
    SPECIALS["eval-compiler"] = function(ast, scope, parent)
      local old_first = ast[1]
      ast[1] = utils.sym("do")
      local val = eval_compiler_2a(ast, scope, parent)
      ast[1] = old_first
      return val
    end
    doc_special("eval-compiler", {"..."}, "Evaluate the body at compile-time. Use the macro system instead if possible.", true)
    SPECIALS.unquote = function(ast)
      return compiler.assert(false, "tried to use unquote outside quote", ast)
    end
    doc_special("unquote", {"..."}, "Evaluate the argument even if it's in a quoted form.")
    return {["current-global-names"] = current_global_names, ["get-function-metadata"] = get_function_metadata, ["load-code"] = load_code, ["macro-loaded"] = macro_loaded, ["macro-searchers"] = macro_searchers, ["make-compiler-env"] = make_compiler_env, ["make-searcher"] = make_searcher, ["search-module"] = search_module, ["wrap-env"] = wrap_env, doc = doc_2a}
  end
  package.preload["fennel.compiler"] = package.preload["fennel.compiler"] or function(...)
    local utils = require("fennel.utils")
    local parser = require("fennel.parser")
    local friend = require("fennel.friend")
    local view = require("fennel.view")
    local unpack = (table.unpack or _G.unpack)
    local scopes = {compiler = nil, global = nil, macro = nil}
    local function make_scope(_3fparent)
      local parent = (_3fparent or scopes.global)
      local _275_
      if parent then
        _275_ = ((parent.depth or 0) + 1)
      else
        _275_ = 0
      end
      return {["gensym-base"] = setmetatable({}, {__index = (parent and parent["gensym-base"])}), autogensyms = setmetatable({}, {__index = (parent and parent.autogensyms)}), depth = _275_, gensyms = setmetatable({}, {__index = (parent and parent.gensyms)}), hashfn = (parent and parent.hashfn), includes = setmetatable({}, {__index = (parent and parent.includes)}), macros = setmetatable({}, {__index = (parent and parent.macros)}), manglings = setmetatable({}, {__index = (parent and parent.manglings)}), parent = parent, refedglobals = {}, specials = setmetatable({}, {__index = (parent and parent.specials)}), symmeta = setmetatable({}, {__index = (parent and parent.symmeta)}), unmanglings = setmetatable({}, {__index = (parent and parent.unmanglings)}), vararg = (parent and parent.vararg)}
    end
    local function assert_msg(ast, msg)
      local ast_tbl = nil
      if ("table" == type(ast)) then
        ast_tbl = ast
      else
        ast_tbl = {}
      end
      local m = getmetatable(ast)
      local filename = ((m and m.filename) or ast_tbl.filename or "unknown")
      local line = ((m and m.line) or ast_tbl.line or "?")
      local col = ((m and m.col) or ast_tbl.col or "?")
      local target = tostring((utils["sym?"](ast_tbl[1]) or ast_tbl[1] or "()"))
      return string.format("%s:%s:%s: Compile error in '%s': %s", filename, line, col, target, msg)
    end
    local function assert_compile(condition, msg, ast, _3ffallback_ast)
      if not condition then
        local _278_ = (utils.root.options or {})
        local error_pinpoint = _278_["error-pinpoint"]
        local source = _278_["source"]
        local unfriendly = _278_["unfriendly"]
        local ast0 = nil
        if next(utils["ast-source"](ast)) then
          ast0 = ast
        else
          ast0 = (_3ffallback_ast or {})
        end
        if (nil == utils.hook("assert-compile", condition, msg, ast0, utils.root.reset)) then
          utils.root.reset()
          if unfriendly then
            error(assert_msg(ast0, msg), 0)
          else
            friend["assert-compile"](condition, msg, ast0, source, {["error-pinpoint"] = error_pinpoint})
          end
        end
      end
      return condition
    end
    scopes.global = make_scope()
    scopes.global.vararg = true
    scopes.compiler = make_scope(scopes.global)
    scopes.macro = scopes.global
    local function serialize_string(str)
      local function _283_(_241)
        return ("\\" .. _241:byte())
      end
      return string.gsub(string.gsub(string.gsub(string.format("%q", str), "\\\n", "\\n"), "\\9", "\\t"), "[\128-\255]", _283_)
    end
    local function global_mangling(str)
      if utils["valid-lua-identifier?"](str) then
        return str
      else
        local function _284_(_241)
          return string.format("_%02x", _241:byte())
        end
        return ("__fnl_global__" .. str:gsub("[^%w]", _284_))
      end
    end
    local function global_unmangling(identifier)
      local _286_0 = string.match(identifier, "^__fnl_global__(.*)$")
      if (nil ~= _286_0) then
        local rest = _286_0
        local _287_0 = nil
        local function _288_(_241)
          return string.char(tonumber(_241:sub(2), 16))
        end
        _287_0 = string.gsub(rest, "_[%da-f][%da-f]", _288_)
        return _287_0
      else
        local _ = _286_0
        return identifier
      end
    end
    local function global_allowed_3f(name)
      local allowed = nil
      do
        local _290_0 = utils.root.options
        if (nil ~= _290_0) then
          _290_0 = _290_0.allowedGlobals
        end
        allowed = _290_0
      end
      return (not allowed or utils["member?"](name, allowed))
    end
    local function unique_mangling(original, mangling, scope, append)
      if scope.unmanglings[mangling] then
        return unique_mangling(original, (original .. append), scope, (append + 1))
      else
        return mangling
      end
    end
    local function apply_deferred_scope_changes(scope, deferred_scope_changes, ast)
      for raw, mangled in pairs(deferred_scope_changes.manglings) do
        assert_compile(not scope.refedglobals[mangled], ("use of global " .. raw .. " is aliased by a local"), ast)
        scope.manglings[raw] = mangled
      end
      for raw, symmeta in pairs(deferred_scope_changes.symmeta) do
        scope.symmeta[raw] = symmeta
      end
      return nil
    end
    local function combine_parts(parts, scope)
      local ret = (scope.manglings[parts[1]] or global_mangling(parts[1]))
      for i = 2, #parts do
        if utils["valid-lua-identifier?"](parts[i]) then
          if (parts["multi-sym-method-call"] and (i == #parts)) then
            ret = (ret .. ":" .. parts[i])
          else
            ret = (ret .. "." .. parts[i])
          end
        else
          ret = (ret .. "[" .. serialize_string(parts[i]) .. "]")
        end
      end
      return ret
    end
    local function root_scope(scope)
      return ((utils.root and utils.root.scope) or (scope.parent and root_scope(scope.parent)) or scope)
    end
    local function next_append(root_scope_2a)
      root_scope_2a["gensym-append"] = ((root_scope_2a["gensym-append"] or 0) + 1)
      return ("_" .. root_scope_2a["gensym-append"] .. "_")
    end
    local function gensym(scope, _3fbase, _3fsuffix)
      local root_scope_2a = root_scope(scope)
      local mangling = ((_3fbase or "") .. next_append(root_scope_2a) .. (_3fsuffix or ""))
      while scope.unmanglings[mangling] do
        mangling = ((_3fbase or "") .. next_append(root_scope_2a) .. (_3fsuffix or ""))
      end
      if (_3fbase and (0 < #_3fbase)) then
        scope["gensym-base"][mangling] = _3fbase
      end
      scope.gensyms[mangling] = true
      return mangling
    end
    local function combine_auto_gensym(parts, first)
      parts[1] = first
      local last = table.remove(parts)
      local last2 = table.remove(parts)
      local last_joiner = ((parts["multi-sym-method-call"] and ":") or ".")
      table.insert(parts, (last2 .. last_joiner .. last))
      return table.concat(parts, ".")
    end
    local function autogensym(base, scope)
      local _296_0 = utils["multi-sym?"](base)
      if (nil ~= _296_0) then
        local parts = _296_0
        return combine_auto_gensym(parts, autogensym(parts[1], scope))
      else
        local _ = _296_0
        local function _297_()
          local mangling = gensym(scope, base:sub(1, -2), "auto")
          scope.autogensyms[base] = mangling
          return mangling
        end
        return (scope.autogensyms[base] or _297_())
      end
    end
    local function check_binding_valid(symbol, scope, ast, _3fopts)
      local name = tostring(symbol)
      local macro_3f = nil
      do
        local _299_0 = _3fopts
        if (nil ~= _299_0) then
          _299_0 = _299_0["macro?"]
        end
        macro_3f = _299_0
      end
      assert_compile(("&" ~= name:match("[&.:]")), "invalid character: &", symbol)
      assert_compile(not name:find("^%."), "invalid character: .", symbol)
      assert_compile(not (scope.specials[name] or (not macro_3f and scope.macros[name])), ("local %s was overshadowed by a special form or macro"):format(name), ast)
      return assert_compile(not utils["quoted?"](symbol), string.format("macro tried to bind %s without gensym", name), symbol)
    end
    local function declare_local(symbol, scope, ast, _3fvar_3f, _3fdeferred_scope_changes)
      check_binding_valid(symbol, scope, ast)
      assert_compile(not utils["multi-sym?"](symbol), ("unexpected multi symbol " .. tostring(symbol)), ast)
      local str = tostring(symbol)
      local raw = nil
      if (utils["lua-keyword?"](str) or str:match("^%d")) then
        raw = ("_" .. str)
      else
        raw = str
      end
      local mangling = nil
      local function _302_(_241)
        return string.format("_%02x", _241:byte())
      end
      mangling = string.gsub(string.gsub(raw, "-", "_"), "[^%w_]", _302_)
      local unique = unique_mangling(mangling, mangling, scope, 0)
      scope.unmanglings[unique] = (scope["gensym-base"][str] or str)
      do
        local target = (_3fdeferred_scope_changes or scope)
        target.manglings[str] = unique
        target.symmeta[str] = {symbol = symbol, var = _3fvar_3f}
      end
      return unique
    end
    local function hashfn_arg_name(name, multi_sym_parts, scope)
      if not scope.hashfn then
        return nil
      elseif (name == "$") then
        return "$1"
      elseif multi_sym_parts then
        if (multi_sym_parts and (multi_sym_parts[1] == "$")) then
          multi_sym_parts[1] = "$1"
        end
        return table.concat(multi_sym_parts, ".")
      end
    end
    local function symbol_to_expression(symbol, scope, _3freference_3f)
      utils.hook("symbol-to-expression", symbol, scope, _3freference_3f)
      local name = symbol[1]
      local multi_sym_parts = utils["multi-sym?"](name)
      local name0 = (hashfn_arg_name(name, multi_sym_parts, scope) or name)
      local parts = (multi_sym_parts or {name0})
      local etype = (((1 < #parts) and "expression") or "sym")
      local local_3f = scope.manglings[parts[1]]
      if (local_3f and scope.symmeta[parts[1]]) then
        scope.symmeta[parts[1]]["used"] = true
        symbol.referent = scope.symmeta[parts[1]].symbol
      end
      assert_compile(not scope.macros[parts[1]], "tried to reference a macro without calling it", symbol)
      assert_compile((not scope.specials[parts[1]] or ("require" == parts[1])), "tried to reference a special form without calling it", symbol)
      assert_compile((not _3freference_3f or local_3f or ("_ENV" == parts[1]) or global_allowed_3f(parts[1])), ("unknown identifier: " .. tostring(parts[1])), symbol)
      local function _307_()
        local _306_0 = utils.root.options
        if (nil ~= _306_0) then
          _306_0 = _306_0.allowedGlobals
        end
        return _306_0
      end
      if (_307_() and not local_3f and scope.parent) then
        scope.parent.refedglobals[parts[1]] = true
      end
      return utils.expr(combine_parts(parts, scope), etype)
    end
    local function emit(chunk, out, _3fast)
      if (type(out) == "table") then
        return table.insert(chunk, out)
      else
        return table.insert(chunk, {ast = _3fast, leaf = out})
      end
    end
    local function peephole(chunk)
      if chunk.leaf then
        return chunk
      elseif ((3 <= #chunk) and (chunk[(#chunk - 2)].leaf == "do") and not chunk[(#chunk - 1)].leaf and (chunk[#chunk].leaf == "end")) then
        local kid = peephole(chunk[(#chunk - 1)])
        local new_chunk = {ast = chunk.ast}
        for i = 1, (#chunk - 3) do
          table.insert(new_chunk, peephole(chunk[i]))
        end
        for i = 1, #kid do
          table.insert(new_chunk, kid[i])
        end
        return new_chunk
      else
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _, x in ipairs(chunk) do
          local val_19_ = peephole(x)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        return tbl_17_
      end
    end
    local function flatten_chunk_correlated(main_chunk, options)
      local function flatten(chunk, out, last_line, file)
        local last_line0 = last_line
        if chunk.leaf then
          out[last_line0] = ((out[last_line0] or "") .. " " .. chunk.leaf)
        else
          for _, subchunk in ipairs(chunk) do
            if (subchunk.leaf or next(subchunk)) then
              local source = utils["ast-source"](subchunk.ast)
              if (file == source.filename) then
                last_line0 = math.max(last_line0, (source.line or 0))
              end
              last_line0 = flatten(subchunk, out, last_line0, file)
            end
          end
        end
        return last_line0
      end
      local out = {}
      local last = flatten(main_chunk, out, 1, options.filename)
      for i = 1, last do
        if (out[i] == nil) then
          out[i] = ""
        end
      end
      return table.concat(out, "\n")
    end
    local function flatten_chunk(file_sourcemap, chunk, tab, depth)
      if chunk.leaf then
        local _317_ = utils["ast-source"](chunk.ast)
        local endline = _317_["endline"]
        local filename = _317_["filename"]
        local line = _317_["line"]
        if ("end" == chunk.leaf) then
          table.insert(file_sourcemap, {filename, (endline or line)})
        else
          table.insert(file_sourcemap, {filename, line})
        end
        return chunk.leaf
      else
        local tab0 = nil
        do
          local _319_0 = tab
          if (_319_0 == true) then
            tab0 = "  "
          elseif (_319_0 == false) then
            tab0 = ""
          elseif (nil ~= _319_0) then
            local tab1 = _319_0
            tab0 = tab1
          elseif (_319_0 == nil) then
            tab0 = ""
          else
          tab0 = nil
          end
        end
        local _321_
        do
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, c in ipairs(chunk) do
            local val_19_ = nil
            if (c.leaf or next(c)) then
              local sub = flatten_chunk(file_sourcemap, c, tab0, (depth + 1))
              if (0 < depth) then
                val_19_ = (tab0 .. sub:gsub("\n", ("\n" .. tab0)))
              else
                val_19_ = sub
              end
            else
            val_19_ = nil
            end
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          _321_ = tbl_17_
        end
        return table.concat(_321_, "\n")
      end
    end
    local sourcemap = {}
    local function make_short_src(source)
      local source0 = source:gsub("\n", " ")
      if (#source0 <= 49) then
        return ("[fennel \"" .. source0 .. "\"]")
      else
        return ("[fennel \"" .. source0:sub(1, 46) .. "...\"]")
      end
    end
    local function flatten(chunk, options)
      local chunk0 = peephole(chunk)
      local indent = (options.indent or "  ")
      if options.correlate then
        return flatten_chunk_correlated(chunk0, options), {}
      else
        local file_sourcemap = {}
        local src = flatten_chunk(file_sourcemap, chunk0, indent, 0)
        file_sourcemap.short_src = (options.filename or make_short_src((options.source or src)))
        if options.filename then
          file_sourcemap.key = ("@" .. options.filename)
        else
          file_sourcemap.key = src
        end
        sourcemap[file_sourcemap.key] = file_sourcemap
        return src, file_sourcemap
      end
    end
    local function make_metadata()
      local function _329_(self, tgt, _3fkey)
        if self[tgt] then
          if (nil ~= _3fkey) then
            return self[tgt][_3fkey]
          else
            return self[tgt]
          end
        end
      end
      local function _332_(self, tgt, key, value)
        self[tgt] = (self[tgt] or {})
        self[tgt][key] = value
        return tgt
      end
      local function _333_(self, tgt, ...)
        local kv_len = select("#", ...)
        local kvs = {...}
        if ((kv_len % 2) ~= 0) then
          error("metadata:setall() expected even number of k/v pairs")
        end
        self[tgt] = (self[tgt] or {})
        for i = 1, kv_len, 2 do
          self[tgt][kvs[i]] = kvs[(i + 1)]
        end
        return tgt
      end
      return setmetatable({}, {__index = {get = _329_, set = _332_, setall = _333_}, __mode = "k"})
    end
    local function exprs1(exprs)
      local _335_
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _, e in ipairs(exprs) do
          local val_19_ = tostring(e)
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        _335_ = tbl_17_
      end
      return table.concat(_335_, ", ")
    end
    local function keep_side_effects(exprs, chunk, _3fstart, ast)
      for j = (_3fstart or 1), #exprs do
        local subexp = exprs[j]
        if ((subexp.type == "expression") and (subexp[1] ~= "nil")) then
          emit(chunk, ("do local _ = %s end"):format(tostring(subexp)), ast)
        elseif (subexp.type == "statement") then
          local code = tostring(subexp)
          local disambiguated = nil
          if (code:byte() == 40) then
            disambiguated = ("do end " .. code)
          else
            disambiguated = code
          end
          emit(chunk, disambiguated, ast)
        end
      end
      return nil
    end
    local function handle_compile_opts(exprs, parent, opts, ast)
      if opts.nval then
        local n = opts.nval
        local len = #exprs
        if (n ~= len) then
          if (n < len) then
            keep_side_effects(exprs, parent, (n + 1), ast)
            for i = (n + 1), len do
              exprs[i] = nil
            end
          else
            for i = (#exprs + 1), n do
              exprs[i] = utils.expr("nil", "literal")
            end
          end
        end
      end
      if opts.tail then
        emit(parent, string.format("return %s", exprs1(exprs)), ast)
      end
      if opts.target then
        local result = exprs1(exprs)
        local function _343_()
          if (result == "") then
            return "nil"
          else
            return result
          end
        end
        emit(parent, string.format("%s = %s", opts.target, _343_()), ast)
      end
      if (opts.tail or opts.target) then
        return {returned = true}
      else
        exprs["returned"] = true
        return exprs
      end
    end
    local function find_macro(ast, scope)
      local macro_2a = nil
      do
        local _346_0 = utils["sym?"](ast[1])
        if (_346_0 ~= nil) then
          local _347_0 = tostring(_346_0)
          if (_347_0 ~= nil) then
            macro_2a = scope.macros[_347_0]
          else
            macro_2a = _347_0
          end
        else
          macro_2a = _346_0
        end
      end
      local multi_sym_parts = utils["multi-sym?"](ast[1])
      if (not macro_2a and multi_sym_parts) then
        local nested_macro = utils["get-in"](scope.macros, multi_sym_parts)
        assert_compile((not scope.macros[multi_sym_parts[1]] or (type(nested_macro) == "function")), "macro not found in imported macro module", ast)
        return nested_macro
      else
        return macro_2a
      end
    end
    local function propagate_trace_info(_351_0, _index, node)
      local _352_ = _351_0
      local byteend = _352_["byteend"]
      local bytestart = _352_["bytestart"]
      local filename = _352_["filename"]
      local line = _352_["line"]
      do
        local src = utils["ast-source"](node)
        if (("table" == type(node)) and (filename ~= src.filename)) then
          src.filename, src.line, src["from-macro?"] = filename, line, true
          src.bytestart, src.byteend = bytestart, byteend
        end
      end
      return ("table" == type(node))
    end
    local function quote_literal_nils(index, node, parent)
      if (parent and utils["list?"](parent)) then
        for i = 1, utils.maxn(parent) do
          local _354_0 = parent[i]
          if (_354_0 == nil) then
            parent[i] = utils.sym("nil")
          end
        end
      end
      return index, node, parent
    end
    local function built_in_3f(m)
      local found_3f = false
      for _, f in pairs(scopes.global.macros) do
        if found_3f then break end
        found_3f = (f == m)
      end
      return found_3f
    end
    local function macroexpand_2a(ast, scope, _3fonce)
      local _357_0 = nil
      if utils["list?"](ast) then
        _357_0 = find_macro(ast, scope)
      else
      _357_0 = nil
      end
      if (_357_0 == false) then
        return ast
      elseif (nil ~= _357_0) then
        local macro_2a = _357_0
        local old_scope = scopes.macro
        local _ = nil
        scopes.macro = scope
        _ = nil
        local ok, transformed = nil, nil
        local function _359_()
          return macro_2a(unpack(ast, 2))
        end
        local function _360_()
          if built_in_3f(macro_2a) then
            return tostring
          else
            return debug.traceback
          end
        end
        ok, transformed = xpcall(_359_, _360_())
        local function _361_(...)
          return propagate_trace_info(ast, quote_literal_nils(...))
        end
        utils["walk-tree"](transformed, _361_)
        scopes.macro = old_scope
        assert_compile(ok, transformed, ast)
        utils.hook("macroexpand", ast, transformed, scope)
        if (_3fonce or not transformed) then
          return transformed
        else
          return macroexpand_2a(transformed, scope)
        end
      else
        local _ = _357_0
        return ast
      end
    end
    local function compile_special(ast, scope, parent, opts, special)
      local exprs = (special(ast, scope, parent, opts) or utils.expr("nil", "literal"))
      local exprs0 = nil
      if ("table" ~= type(exprs)) then
        exprs0 = utils.expr(exprs, "expression")
      else
        exprs0 = exprs
      end
      local exprs2 = nil
      if utils["expr?"](exprs0) then
        exprs2 = {exprs0}
      else
        exprs2 = exprs0
      end
      if not exprs2.returned then
        return handle_compile_opts(exprs2, parent, opts, ast)
      elseif (opts.tail or opts.target) then
        return {returned = true}
      else
        return exprs2
      end
    end
    local function callable_3f(_367_0, ctype, callee)
      local _368_ = _367_0
      local call_ast = _368_[1]
      if ("literal" == ctype) then
        return ("\"" == string.sub(callee, 1, 1))
      else
        return (utils["sym?"](call_ast) or utils["list?"](call_ast))
      end
    end
    local function compile_function_call(ast, scope, parent, opts, compile1, len)
      local _370_ = compile1(ast[1], scope, parent, {nval = 1})[1]
      local callee = _370_[1]
      local ctype = _370_["type"]
      local fargs = {}
      assert_compile(callable_3f(ast, ctype, callee), ("cannot call literal value " .. tostring(ast[1])), ast)
      for i = 2, len do
        local subexprs = nil
        local _371_
        if (i ~= len) then
          _371_ = 1
        else
        _371_ = nil
        end
        subexprs = compile1(ast[i], scope, parent, {nval = _371_})
        table.insert(fargs, subexprs[1])
        if (i == len) then
          for j = 2, #subexprs do
            table.insert(fargs, subexprs[j])
          end
        else
          keep_side_effects(subexprs, parent, 2, ast[i])
        end
      end
      local pat = nil
      if ("literal" == ctype) then
        pat = "(%s)(%s)"
      else
        pat = "%s(%s)"
      end
      local call = string.format(pat, tostring(callee), exprs1(fargs))
      return handle_compile_opts({utils.expr(call, "statement")}, parent, opts, ast)
    end
    local function compile_call(ast, scope, parent, opts, compile1)
      utils.hook("call", ast, scope)
      local len = #ast
      local first = ast[1]
      local multi_sym_parts = utils["multi-sym?"](first)
      local special = (utils["sym?"](first) and scope.specials[tostring(first)])
      assert_compile((0 < len), "expected a function, macro, or special to call", ast)
      if special then
        return compile_special(ast, scope, parent, opts, special)
      elseif (multi_sym_parts and multi_sym_parts["multi-sym-method-call"]) then
        local table_with_method = table.concat({unpack(multi_sym_parts, 1, (#multi_sym_parts - 1))}, ".")
        local method_to_call = multi_sym_parts[#multi_sym_parts]
        local new_ast = utils.list(utils.sym(":", ast), utils.sym(table_with_method, ast), method_to_call, select(2, unpack(ast)))
        return compile1(new_ast, scope, parent, opts)
      else
        return compile_function_call(ast, scope, parent, opts, compile1, len)
      end
    end
    local function compile_varg(ast, scope, parent, opts)
      local _376_
      if scope.hashfn then
        _376_ = "use $... in hashfn"
      else
        _376_ = "unexpected vararg"
      end
      assert_compile(scope.vararg, _376_, ast)
      return handle_compile_opts({utils.expr("...", "varg")}, parent, opts, ast)
    end
    local function compile_sym(ast, scope, parent, opts)
      local multi_sym_parts = utils["multi-sym?"](ast)
      assert_compile(not (multi_sym_parts and multi_sym_parts["multi-sym-method-call"]), "multisym method calls may only be in call position", ast)
      local e = nil
      if (ast[1] == "nil") then
        e = utils.expr("nil", "literal")
      else
        e = symbol_to_expression(ast, scope, true)
      end
      return handle_compile_opts({e}, parent, opts, ast)
    end
    local view_opts = nil
    do
      local nan = tostring((0 / 0))
      local _379_
      if (45 == nan:byte()) then
        _379_ = "(0/0)"
      else
        _379_ = "(- (0/0))"
      end
      local _381_
      if (45 == nan:byte()) then
        _381_ = "(- (0/0))"
      else
        _381_ = "(0/0)"
      end
      view_opts = {["negative-infinity"] = "(-1/0)", ["negative-nan"] = _379_, infinity = "(1/0)", nan = _381_}
    end
    local function compile_scalar(ast, _scope, parent, opts)
      local compiled = nil
      do
        local _383_0 = type(ast)
        if (_383_0 == "nil") then
          compiled = "nil"
        elseif (_383_0 == "boolean") then
          compiled = tostring(ast)
        elseif (_383_0 == "string") then
          compiled = serialize_string(ast)
        elseif (_383_0 == "number") then
          compiled = view(ast, view_opts)
        else
        compiled = nil
        end
      end
      return handle_compile_opts({utils.expr(compiled, "literal")}, parent, opts)
    end
    local function compile_table(ast, scope, parent, opts, compile1)
      local function escape_key(k)
        if ((type(k) == "string") and utils["valid-lua-identifier?"](k)) then
          return k
        else
          local _385_ = compile1(k, scope, parent, {nval = 1})
          local compiled = _385_[1]
          return ("[" .. tostring(compiled) .. "]")
        end
      end
      local keys = {}
      local buffer = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i, elem in ipairs(ast) do
          local val_19_ = nil
          do
            local nval = ((nil ~= ast[(i + 1)]) and 1)
            keys[i] = true
            val_19_ = exprs1(compile1(elem, scope, parent, {nval = nval}))
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        buffer = tbl_17_
      end
      do
        local tbl_17_ = buffer
        local i_18_ = #tbl_17_
        for k in utils.stablepairs(ast) do
          local val_19_ = nil
          if not keys[k] then
            local _388_ = compile1(ast[k], scope, parent, {nval = 1})
            local v = _388_[1]
            val_19_ = string.format("%s = %s", escape_key(k), tostring(v))
          else
          val_19_ = nil
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
      end
      return handle_compile_opts({utils.expr(("{" .. table.concat(buffer, ", ") .. "}"), "expression")}, parent, opts, ast)
    end
    local function compile1(ast, scope, parent, _3fopts)
      local opts = (_3fopts or {})
      local ast0 = macroexpand_2a(ast, scope)
      if utils["list?"](ast0) then
        return compile_call(ast0, scope, parent, opts, compile1)
      elseif utils["varg?"](ast0) then
        return compile_varg(ast0, scope, parent, opts)
      elseif utils["sym?"](ast0) then
        return compile_sym(ast0, scope, parent, opts)
      elseif (type(ast0) == "table") then
        return compile_table(ast0, scope, parent, opts, compile1)
      elseif ((type(ast0) == "nil") or (type(ast0) == "boolean") or (type(ast0) == "number") or (type(ast0) == "string")) then
        return compile_scalar(ast0, scope, parent, opts)
      else
        return assert_compile(false, ("could not compile value of type " .. type(ast0)), ast0)
      end
    end
    local function destructure(to, from, ast, scope, parent, opts)
      local opts0 = (opts or {})
      local _392_ = opts0
      local declaration = _392_["declaration"]
      local forceglobal = _392_["forceglobal"]
      local forceset = _392_["forceset"]
      local isvar = _392_["isvar"]
      local symtype = _392_["symtype"]
      local symtype0 = ("_" .. (symtype or "dst"))
      local setter = nil
      if declaration then
        setter = "local %s = %s"
      else
        setter = "%s = %s"
      end
      local deferred_scope_changes = {manglings = {}, symmeta = {}}
      local function getname(symbol, ast0)
        local raw = symbol[1]
        assert_compile(not (opts0.nomulti and utils["multi-sym?"](raw)), ("unexpected multi symbol " .. raw), ast0)
        if declaration then
          return declare_local(symbol, scope, symbol, isvar, deferred_scope_changes)
        else
          local parts = (utils["multi-sym?"](raw) or {raw})
          local _394_ = parts
          local first = _394_[1]
          local meta = scope.symmeta[first]
          assert_compile(not raw:find(":"), "cannot set method sym", symbol)
          if ((#parts == 1) and not forceset) then
            assert_compile(not (forceglobal and meta), string.format("global %s conflicts with local", tostring(symbol)), symbol)
            assert_compile(not (meta and not meta.var), ("expected var " .. raw), symbol)
          end
          assert_compile((meta or not opts0.noundef or (scope.hashfn and ("$" == first)) or global_allowed_3f(first)), ("expected local " .. first), symbol)
          if forceglobal then
            assert_compile(not scope.symmeta[scope.unmanglings[raw]], ("global " .. raw .. " conflicts with local"), symbol)
            scope.manglings[raw] = global_mangling(raw)
            scope.unmanglings[global_mangling(raw)] = raw
            local _397_
            do
              local _396_0 = utils.root.options
              if (nil ~= _396_0) then
                _396_0 = _396_0.allowedGlobals
              end
              _397_ = _396_0
            end
            if _397_ then
              local _400_
              do
                local _399_0 = utils.root.options
                if (nil ~= _399_0) then
                  _399_0 = _399_0.allowedGlobals
                end
                _400_ = _399_0
              end
              table.insert(_400_, raw)
            end
          end
          return symbol_to_expression(symbol, scope)[1]
        end
      end
      local function compile_top_target(lvalues)
        local inits = nil
        do
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, l in ipairs(lvalues) do
            local val_19_ = nil
            if scope.manglings[l] then
              val_19_ = l
            else
              val_19_ = "nil"
            end
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          inits = tbl_17_
        end
        local init = table.concat(inits, ", ")
        local lvalue = table.concat(lvalues, ", ")
        local plast = parent[#parent]
        local plen = #parent
        local ret = compile1(from, scope, parent, {target = lvalue})
        if declaration then
          for pi = plen, #parent do
            if (parent[pi] == plast) then
              plen = pi
            end
          end
          if ((#parent == (plen + 1)) and parent[#parent].leaf) then
            parent[#parent]["leaf"] = ("local " .. parent[#parent].leaf)
          elseif (init == "nil") then
            table.insert(parent, (plen + 1), {ast = ast, leaf = ("local " .. lvalue)})
          else
            table.insert(parent, (plen + 1), {ast = ast, leaf = ("local " .. lvalue .. " = " .. init)})
          end
        end
        return ret
      end
      local function destructure_sym(left, rightexprs, up1, top_3f)
        local lname = getname(left, up1)
        check_binding_valid(left, scope, left)
        if top_3f then
          return compile_top_target({lname})
        else
          return emit(parent, setter:format(lname, exprs1(rightexprs)), left)
        end
      end
      local function dynamic_set_target(_411_0)
        local _412_ = _411_0
        local _ = _412_[1]
        local target = _412_[2]
        local keys = {(table.unpack or unpack)(_412_, 3)}
        assert_compile(utils["sym?"](target), "dynamic set needs symbol target", ast)
        assert_compile(next(keys), "dynamic set needs at least one key", ast)
        local keys0 = nil
        do
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _0, k in ipairs(keys) do
            local val_19_ = tostring(compile1(k, scope, parent, {nval = 1})[1])
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          keys0 = tbl_17_
        end
        return string.format("%s[%s]", tostring(symbol_to_expression(target, scope, true)), table.concat(keys0, "]["))
      end
      local function destructure_values(left, rightexprs, up1, destructure1, top_3f)
        local left_names, tables = {}, {}
        for i, name in ipairs(left) do
          if utils["sym?"](name) then
            table.insert(left_names, getname(name, up1))
          elseif utils["call-of?"](name, ".") then
            table.insert(left_names, dynamic_set_target(name))
          else
            local symname = gensym(scope, symtype0)
            table.insert(left_names, symname)
            tables[i] = {name, utils.expr(symname, "sym")}
          end
        end
        assert_compile(left[1], "must provide at least one value", left)
        if top_3f then
          compile_top_target(left_names)
        elseif utils["expr?"](rightexprs) then
          emit(parent, setter:format(table.concat(left_names, ","), exprs1(rightexprs)), left)
        else
          local names = table.concat(left_names, ",")
          local target = nil
          if declaration then
            target = ("local " .. names)
          else
            target = names
          end
          emit(parent, compile1(rightexprs, scope, parent, {target = target}), left)
        end
        for _, pair in utils.stablepairs(tables) do
          destructure1(pair[1], {pair[2]}, left)
        end
        return nil
      end
      local unpack_fn = "function (t, k, e)\n                        local mt = getmetatable(t)\n                        if 'table' == type(mt) and mt.__fennelrest then\n                          return mt.__fennelrest(t, k)\n                        elseif e then\n                          local rest = {}\n                          for k, v in pairs(t) do\n                            if not e[k] then rest[k] = v end\n                          end\n                          return rest\n                        else\n                          return {(table.unpack or unpack)(t, k)}\n                        end\n                      end"
      local function destructure_kv_rest(s, v, left, excluded_keys, destructure1)
        local exclude_str = nil
        local _417_
        do
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, k in ipairs(excluded_keys) do
            local val_19_ = string.format("[%s] = true", serialize_string(k))
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          _417_ = tbl_17_
        end
        exclude_str = table.concat(_417_, ", ")
        local subexpr = utils.expr(string.format(string.gsub(("(" .. unpack_fn .. ")(%s, %s, {%s})"), "\n%s*", " "), s, tostring(v), exclude_str), "expression")
        return destructure1(v, {subexpr}, left)
      end
      local function destructure_rest(s, k, left, destructure1)
        local unpack_str = ("(" .. unpack_fn .. ")(%s, %s)")
        local formatted = string.format(string.gsub(unpack_str, "\n%s*", " "), s, k)
        local subexpr = utils.expr(formatted, "expression")
        local function _419_()
          local next_symbol = left[(k + 2)]
          return ((nil == next_symbol) or utils["sym?"](next_symbol, "&as"))
        end
        assert_compile((utils["sequence?"](left) and _419_()), "expected rest argument before last parameter", left)
        return destructure1(left[(k + 1)], {subexpr}, left)
      end
      local function optimize_table_destructure_3f(left, right)
        local function _420_()
          local all = next(left)
          for _, d in ipairs(left) do
            if not all then break end
            all = ((utils["sym?"](d) and not tostring(d):find("^&")) or (utils["list?"](d) and utils["sym?"](d[1], ".")))
          end
          return all
        end
        return (utils["sequence?"](left) and utils["sequence?"](right) and _420_())
      end
      local function destructure_table(left, rightexprs, top_3f, destructure1, up1)
        if optimize_table_destructure_3f(left, rightexprs) then
          return destructure_values(utils.list(unpack(left)), utils.list(utils.sym("values"), unpack(rightexprs)), up1, destructure1)
        else
          local right = nil
          do
            local _421_0 = nil
            if top_3f then
              _421_0 = exprs1(compile1(from, scope, parent))
            else
              _421_0 = exprs1(rightexprs)
            end
            if (_421_0 == "") then
              right = "nil"
            elseif (nil ~= _421_0) then
              local right0 = _421_0
              right = right0
            else
            right = nil
            end
          end
          local s = nil
          if utils["sym?"](rightexprs) then
            s = right
          else
            s = gensym(scope, symtype0)
          end
          local excluded_keys = {}
          if not utils["sym?"](rightexprs) then
            emit(parent, string.format("local %s = %s", s, right), left)
          end
          for k, v in utils.stablepairs(left) do
            if not (("number" == type(k)) and tostring(left[(k - 1)]):find("^&")) then
              if (utils["sym?"](k) and (tostring(k) == "&")) then
                destructure_kv_rest(s, v, left, excluded_keys, destructure1)
              elseif (utils["sym?"](v) and (tostring(v) == "&")) then
                destructure_rest(s, k, left, destructure1)
              elseif (utils["sym?"](k) and (tostring(k) == "&as")) then
                destructure_sym(v, {utils.expr(tostring(s))}, left)
              elseif (utils["sequence?"](left) and (tostring(v) == "&as")) then
                local _, next_sym, trailing = select(k, unpack(left))
                assert_compile((nil == trailing), "expected &as argument before last parameter", left)
                destructure_sym(next_sym, {utils.expr(tostring(s))}, left)
              else
                local key = nil
                if (type(k) == "string") then
                  key = serialize_string(k)
                else
                  key = k
                end
                local subexpr = utils.expr(("%s[%s]"):format(s, key), "expression")
                if (type(k) == "string") then
                  table.insert(excluded_keys, k)
                end
                destructure1(v, subexpr, left)
              end
            end
          end
          return nil
        end
      end
      local function destructure1(left, rightexprs, up1, top_3f)
        if (utils["sym?"](left) and (left[1] ~= "nil")) then
          destructure_sym(left, rightexprs, up1, top_3f)
        elseif utils["table?"](left) then
          destructure_table(left, rightexprs, top_3f, destructure1, up1)
        elseif utils["call-of?"](left, ".") then
          destructure_values({left}, rightexprs, up1, destructure1)
        elseif utils["list?"](left) then
          assert_compile(top_3f, "can't nest multi-value destructuring", left)
          destructure_values(left, rightexprs, up1, destructure1, true)
        else
          assert_compile(false, string.format("unable to bind %s %s", type(left), tostring(left)), (((type(up1[2]) == "table") and up1[2]) or up1))
        end
        return (top_3f and {returned = true})
      end
      local ret = destructure1(to, from, ast, true)
      utils.hook("destructure", from, to, scope, opts0)
      apply_deferred_scope_changes(scope, deferred_scope_changes, ast)
      return ret
    end
    local function require_include(ast, scope, parent, opts)
      opts.fallback = function(e, no_warn)
        if not no_warn then
          utils.warn(("include module not found, falling back to require: %s"):format(tostring(e)), ast)
        end
        return utils.expr(string.format("require(%s)", tostring(e)), "statement")
      end
      return scopes.global.specials.include(ast, scope, parent, opts)
    end
    local function compile_asts(asts, options)
      local opts = utils.copy(options)
      local scope = (opts.scope or make_scope(scopes.global))
      local chunk = {}
      if opts.requireAsInclude then
        scope.specials.require = require_include
      end
      if opts.assertAsRepl then
        scope.macros.assert = scope.macros["assert-repl"]
      end
      local _435_ = utils.root
      _435_["set-reset"](_435_)
      utils.root.chunk, utils.root.scope, utils.root.options = chunk, scope, opts
      for i = 1, #asts do
        local exprs = compile1(asts[i], scope, chunk, {nval = (((i < #asts) and 0) or nil), tail = (i == #asts)})
        keep_side_effects(exprs, chunk, nil, asts[i])
        if (i == #asts) then
          utils.hook("chunk", asts[i], scope)
        end
      end
      utils.root.reset()
      return flatten(chunk, opts)
    end
    local function compile_stream(stream, _3fopts)
      local opts = (_3fopts or {})
      local asts = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for _, ast in parser.parser(stream, opts.filename, opts) do
          local val_19_ = ast
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        asts = tbl_17_
      end
      return compile_asts(asts, opts)
    end
    local function compile_string(str, _3fopts)
      return compile_stream(parser["string-stream"](str, _3fopts), _3fopts)
    end
    local function compile(from, _3fopts)
      local _438_0 = type(from)
      if (_438_0 == "userdata") then
        local function _439_()
          local _440_0 = from:read(1)
          if (nil ~= _440_0) then
            return _440_0:byte()
          else
            return _440_0
          end
        end
        return compile_stream(_439_, _3fopts)
      elseif (_438_0 == "function") then
        return compile_stream(from, _3fopts)
      else
        local _ = _438_0
        return compile_asts({from}, _3fopts)
      end
    end
    local function traceback_frame(info)
      if ((info.what == "C") and info.name) then
        return string.format("\9[C]: in function '%s'", info.name)
      elseif (info.what == "C") then
        return "\9[C]: in ?"
      else
        local remap = sourcemap[info.source]
        if (remap and remap[info.currentline]) then
          if ((remap[info.currentline][1] or "unknown") ~= "unknown") then
            info.short_src = sourcemap[("@" .. remap[info.currentline][1])].short_src
          else
            info.short_src = remap.short_src
          end
          info.currentline = (remap[info.currentline][2] or -1)
        end
        if (info.what == "Lua") then
          local function _445_()
            if info.name then
              return ("'" .. info.name .. "'")
            else
              return "?"
            end
          end
          return string.format("\9%s:%d: in function %s", info.short_src, info.currentline, _445_())
        elseif (info.short_src == "(tail call)") then
          return "  (tail call)"
        else
          return string.format("\9%s:%d: in main chunk", info.short_src, info.currentline)
        end
      end
    end
    local lua_getinfo = debug.getinfo
    local function traceback(_3fmsg, _3fstart)
      local _448_0 = type(_3fmsg)
      if ((_448_0 == "nil") or (_448_0 == "string")) then
        local msg = (_3fmsg or "")
        if ((msg:find("^%g+:%d+:%d+ Compile error:.*") or msg:find("^%g+:%d+:%d+ Parse error:.*")) and not utils["debug-on?"]("trace")) then
          return msg
        else
          local lines = {}
          if (msg:find("^%g+:%d+:%d+ Compile error:") or msg:find("^%g+:%d+:%d+ Parse error:")) then
            table.insert(lines, msg)
          else
            local newmsg = msg:gsub("^[^:]*:%d+:%s+", "runtime error: ")
            table.insert(lines, newmsg)
          end
          table.insert(lines, "stack traceback:")
          local done_3f, level = false, (_3fstart or 2)
          while not done_3f do
            do
              local _450_0 = lua_getinfo(level, "Sln")
              if (_450_0 == nil) then
                done_3f = true
              elseif (nil ~= _450_0) then
                local info = _450_0
                table.insert(lines, traceback_frame(info))
              end
            end
            level = (level + 1)
          end
          return table.concat(lines, "\n")
        end
      else
        local _ = _448_0
        return _3fmsg
      end
    end
    local function getinfo(thread_or_level, ...)
      local thread_or_level0 = nil
      if ("number" == type(thread_or_level)) then
        thread_or_level0 = (1 + thread_or_level)
      else
        thread_or_level0 = thread_or_level
      end
      local info = lua_getinfo(thread_or_level0, ...)
      local mapped = (info and sourcemap[info.source])
      if mapped then
        for _, key in ipairs({"currentline", "linedefined", "lastlinedefined"}) do
          local mapped_value = nil
          do
            local _455_0 = mapped
            if (nil ~= _455_0) then
              _455_0 = _455_0[info[key]]
            end
            if (nil ~= _455_0) then
              _455_0 = _455_0[2]
            end
            mapped_value = _455_0
          end
          if (info[key] and mapped_value) then
            info[key] = mapped_value
          end
        end
        if info.activelines then
          local tbl_14_ = {}
          for line in pairs(info.activelines) do
            local k_15_, v_16_ = mapped[line][2], true
            if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
              tbl_14_[k_15_] = v_16_
            end
          end
          info.activelines = tbl_14_
        end
        if (info.what == "Lua") then
          info.what = "Fennel"
        end
      end
      return info
    end
    local function mixed_concat(t, joiner)
      local seen = {}
      local ret, s = "", ""
      for k, v in ipairs(t) do
        table.insert(seen, k)
        ret = (ret .. s .. v)
        s = joiner
      end
      for k, v in utils.stablepairs(t) do
        if not seen[k] then
          ret = (ret .. s .. "[" .. k .. "]" .. "=" .. v)
          s = joiner
        end
      end
      return ret
    end
    local function do_quote(form, scope, parent, runtime_3f)
      local function quote_all(form0, discard_non_numbers)
        local tbl_14_ = {}
        for k, v in utils.stablepairs(form0) do
          local k_15_, v_16_ = nil, nil
          if (type(k) == "number") then
            k_15_, v_16_ = k, do_quote(v, scope, parent, runtime_3f)
          elseif not discard_non_numbers then
            k_15_, v_16_ = do_quote(k, scope, parent, runtime_3f), do_quote(v, scope, parent, runtime_3f)
          else
          k_15_, v_16_ = nil
          end
          if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
            tbl_14_[k_15_] = v_16_
          end
        end
        return tbl_14_
      end
      if utils["varg?"](form) then
        assert_compile(not runtime_3f, "quoted ... may only be used at compile time", form)
        return "_VARARG"
      elseif utils["sym?"](form) then
        local filename = nil
        if form.filename then
          filename = string.format("%q", form.filename)
        else
          filename = "nil"
        end
        local symstr = tostring(form)
        assert_compile(not runtime_3f, "symbols may only be used at compile time", form)
        if (symstr:find("#$") or symstr:find("#[:.]")) then
          return string.format("_G.sym('%s', {filename=%s, line=%s})", autogensym(symstr, scope), filename, (form.line or "nil"))
        else
          return string.format("_G.sym('%s', {quoted=true, filename=%s, line=%s})", symstr, filename, (form.line or "nil"))
        end
      elseif utils["call-of?"](form, "unquote") then
        local res = unpack(compile1(form[2], scope, parent))
        return res[1]
      elseif utils["list?"](form) then
        local mapped = quote_all(form, true)
        local filename = nil
        if form.filename then
          filename = string.format("%q", form.filename)
        else
          filename = "nil"
        end
        assert_compile(not runtime_3f, "lists may only be used at compile time", form)
        return string.format(("setmetatable({filename=%s, line=%s, bytestart=%s, %s}" .. ", getmetatable(_G.list()))"), filename, (form.line or "nil"), (form.bytestart or "nil"), mixed_concat(mapped, ", "))
      elseif utils["sequence?"](form) then
        local mapped = quote_all(form)
        local source = getmetatable(form)
        local filename = nil
        if source.filename then
          filename = string.format("%q", source.filename)
        else
          filename = "nil"
        end
        local _470_
        if source then
          _470_ = source.line
        else
          _470_ = "nil"
        end
        return string.format("setmetatable({%s}, {filename=%s, line=%s, sequence=%s})", mixed_concat(mapped, ", "), filename, _470_, "(getmetatable(_G.sequence()))['sequence']")
      elseif (type(form) == "table") then
        local mapped = quote_all(form)
        local source = getmetatable(form)
        local filename = nil
        if source.filename then
          filename = string.format("%q", source.filename)
        else
          filename = "nil"
        end
        local function _473_()
          if source then
            return source.line
          else
            return "nil"
          end
        end
        return string.format("setmetatable({%s}, {filename=%s, line=%s})", mixed_concat(mapped, ", "), filename, _473_())
      elseif (type(form) == "string") then
        return serialize_string(form)
      else
        return tostring(form)
      end
    end
    return {["apply-deferred-scope-changes"] = apply_deferred_scope_changes, ["check-binding-valid"] = check_binding_valid, ["compile-stream"] = compile_stream, ["compile-string"] = compile_string, ["declare-local"] = declare_local, ["do-quote"] = do_quote, ["global-allowed?"] = global_allowed_3f, ["global-mangling"] = global_mangling, ["global-unmangling"] = global_unmangling, ["keep-side-effects"] = keep_side_effects, ["make-scope"] = make_scope, ["require-include"] = require_include, ["symbol-to-expression"] = symbol_to_expression, assert = assert_compile, autogensym = autogensym, compile = compile, compile1 = compile1, destructure = destructure, emit = emit, gensym = gensym, getinfo = getinfo, macroexpand = macroexpand_2a, metadata = make_metadata(), scopes = scopes, sourcemap = sourcemap, traceback = traceback}
  end
  package.preload["fennel.friend"] = package.preload["fennel.friend"] or function(...)
    local utils = require("fennel.utils")
    local utf8_ok_3f, utf8 = pcall(require, "utf8")
    local suggestions = {["$ and $... in hashfn are mutually exclusive"] = {"modifying the hashfn so it only contains $... or $, $1, $2, $3, etc"}, ["can't introduce (.*) here"] = {"declaring the local at the top-level"}, ["can't start multisym segment with a digit"] = {"removing the digit", "adding a non-digit before the digit"}, ["cannot call literal value"] = {"checking for typos", "checking for a missing function name", "making sure to use prefix operators, not infix"}, ["could not compile value of type "] = {"debugging the macro you're calling to return a list or table"}, ["could not read number (.*)"] = {"removing the non-digit character", "beginning the identifier with a non-digit if it is not meant to be a number"}, ["expected a function.* to call"] = {"removing the empty parentheses", "using square brackets if you want an empty table"}, ["expected at least one pattern/body pair"] = {"adding a pattern and a body to execute when the pattern matches"}, ["expected binding and iterator"] = {"making sure you haven't omitted a local name or iterator"}, ["expected binding sequence"] = {"placing a table here in square brackets containing identifiers to bind"}, ["expected body expression"] = {"putting some code in the body of this form after the bindings"}, ["expected each macro to be function"] = {"ensuring that the value for each key in your macros table contains a function", "avoid defining nested macro tables"}, ["expected even number of name/value bindings"] = {"finding where the identifier or value is missing"}, ["expected even number of pattern/body pairs"] = {"checking that every pattern has a body to go with it", "adding _ before the final body"}, ["expected even number of values in table literal"] = {"removing a key", "adding a value"}, ["expected local"] = {"looking for a typo", "looking for a local which is used out of its scope"}, ["expected macros to be table"] = {"ensuring your macro definitions return a table"}, ["expected parameters"] = {"adding function parameters as a list of identifiers in brackets"}, ["expected range to include start and stop"] = {"adding missing arguments"}, ["expected rest argument before last parameter"] = {"moving & to right before the final identifier when destructuring"}, ["expected symbol for function parameter: (.*)"] = {"changing %s to an identifier instead of a literal value"}, ["expected var (.*)"] = {"declaring %s using var instead of let/local", "introducing a new local instead of changing the value of %s"}, ["expected vararg as last parameter"] = {"moving the \"...\" to the end of the parameter list"}, ["expected whitespace before opening delimiter"] = {"adding whitespace"}, ["global (.*) conflicts with local"] = {"renaming local %s"}, ["invalid character: (.)"] = {"deleting or replacing %s", "avoiding reserved characters like \", \\, ', ~, ;, @, `, and comma"}, ["local (.*) was overshadowed by a special form or macro"] = {"renaming local %s"}, ["macro not found in macro module"] = {"checking the keys of the imported macro module's returned table"}, ["macro tried to bind (.*) without gensym"] = {"changing to %s# when introducing identifiers inside macros"}, ["malformed multisym"] = {"ensuring each period or colon is not followed by another period or colon"}, ["may only be used at compile time"] = {"moving this to inside a macro if you need to manipulate symbols/lists", "using square brackets instead of parens to construct a table"}, ["method must be last component"] = {"using a period instead of a colon for field access", "removing segments after the colon", "making the method call, then looking up the field on the result"}, ["mismatched closing delimiter (.), expected (.)"] = {"replacing %s with %s", "deleting %s", "adding matching opening delimiter earlier"}, ["missing subject"] = {"adding an item to operate on"}, ["multisym method calls may only be in call position"] = {"using a period instead of a colon to reference a table's fields", "putting parens around this"}, ["tried to reference a macro without calling it"] = {"renaming the macro so as not to conflict with locals"}, ["tried to reference a special form without calling it"] = {"making sure to use prefix operators, not infix", "wrapping the special in a function if you need it to be first class"}, ["tried to use unquote outside quote"] = {"moving the form to inside a quoted form", "removing the comma"}, ["tried to use vararg with operator"] = {"accumulating over the operands"}, ["unable to bind (.*)"] = {"replacing the %s with an identifier"}, ["unexpected arguments"] = {"removing an argument", "checking for typos"}, ["unexpected closing delimiter (.)"] = {"deleting %s", "adding matching opening delimiter earlier"}, ["unexpected iterator clause"] = {"removing an argument", "checking for typos"}, ["unexpected multi symbol (.*)"] = {"removing periods or colons from %s"}, ["unexpected vararg"] = {"putting \"...\" at the end of the fn parameters if the vararg was intended"}, ["unknown identifier: (.*)"] = {"looking to see if there's a typo", "using the _G table instead, eg. _G.%s if you really want a global", "moving this code to somewhere that %s is in scope", "binding %s as a local in the scope of this code"}, ["unused local (.*)"] = {"renaming the local to _%s if it is meant to be unused", "fixing a typo so %s is used", "disabling the linter which checks for unused locals"}, ["use of global (.*) is aliased by a local"] = {"renaming local %s", "refer to the global using _G.%s instead of directly"}}
    local unpack = (table.unpack or _G.unpack)
    local function suggest(msg)
      local s = nil
      for pat, sug in pairs(suggestions) do
        if s then break end
        local matches = {msg:match(pat)}
        if next(matches) then
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, s0 in ipairs(sug) do
            local val_19_ = s0:format(unpack(matches))
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          s = tbl_17_
        else
        s = nil
        end
      end
      return s
    end
    local function read_line(filename, line, _3fsource)
      if _3fsource then
        local matcher = string.gmatch((_3fsource .. "\n"), "(.-)(\13?\n)")
        for _ = 2, line do
          matcher()
        end
        return matcher()
      else
        local f = assert(_G.io.open(filename))
        local function close_handlers_10_(ok_11_, ...)
          f:close()
          if ok_11_ then
            return ...
          else
            return error(..., 0)
          end
        end
        local function _190_()
          for _ = 2, line do
            f:read()
          end
          return f:read()
        end
        return close_handlers_10_(_G.xpcall(_190_, (package.loaded.fennel or debug).traceback))
      end
    end
    local function sub(str, start, _end)
      if ((_end < start) or (#str < start)) then
        return ""
      elseif utf8_ok_3f then
        return string.sub(str, utf8.offset(str, start), ((utf8.offset(str, (_end + 1)) or (utf8.len(str) + 1)) - 1))
      else
        return string.sub(str, start, math.min(_end, str:len()))
      end
    end
    local function highlight_line(codeline, col, _3fendcol, opts)
      if ((opts and (false == opts["error-pinpoint"])) or (os and os.getenv and os.getenv("NO_COLOR"))) then
        return codeline
      else
        local _193_ = (opts or {})
        local error_pinpoint = _193_["error-pinpoint"]
        local endcol = (_3fendcol or col)
        local eol = nil
        if utf8_ok_3f then
          eol = utf8.len(codeline)
        else
          eol = string.len(codeline)
        end
        local _195_ = (error_pinpoint or {"\27[7m", "\27[0m"})
        local open = _195_[1]
        local close = _195_[2]
        return (sub(codeline, 1, col) .. open .. sub(codeline, (col + 1), (endcol + 1)) .. close .. sub(codeline, (endcol + 2), eol))
      end
    end
    local function friendly_msg(msg, _197_0, source, opts)
      local _198_ = _197_0
      local col = _198_["col"]
      local endcol = _198_["endcol"]
      local endline = _198_["endline"]
      local filename = _198_["filename"]
      local line = _198_["line"]
      local ok, codeline = pcall(read_line, filename, line, source)
      local endcol0 = nil
      if (ok and codeline and (line ~= endline)) then
        endcol0 = #codeline
      else
        endcol0 = endcol
      end
      local out = {msg, ""}
      if (ok and codeline) then
        if col then
          table.insert(out, highlight_line(codeline, col, endcol0, opts))
        else
          table.insert(out, codeline)
        end
      end
      for _, suggestion in ipairs((suggest(msg) or {})) do
        table.insert(out, ("* Try %s."):format(suggestion))
      end
      return table.concat(out, "\n")
    end
    local function assert_compile(condition, msg, ast, source, opts)
      if not condition then
        local _202_ = utils["ast-source"](ast)
        local col = _202_["col"]
        local filename = _202_["filename"]
        local line = _202_["line"]
        error(friendly_msg(("%s:%s:%s: Compile error: %s"):format((filename or "unknown"), (line or "?"), (col or "?"), msg), utils["ast-source"](ast), source, opts), 0)
      end
      return condition
    end
    local function parse_error(msg, filename, line, col, source, opts)
      return error(friendly_msg(("%s:%s:%s: Parse error: %s"):format(filename, line, col, msg), {col = col, filename = filename, line = line}, source, opts), 0)
    end
    return {["assert-compile"] = assert_compile, ["parse-error"] = parse_error}
  end
  package.preload["fennel.parser"] = package.preload["fennel.parser"] or function(...)
    local utils = require("fennel.utils")
    local friend = require("fennel.friend")
    local unpack = (table.unpack or _G.unpack)
    local function granulate(getchunk)
      local c, index, done_3f = "", 1, false
      local function _204_(parser_state)
        if not done_3f then
          if (index <= #c) then
            local b = c:byte(index)
            index = (index + 1)
            return b
          else
            local _205_0 = getchunk(parser_state)
            local function _206_()
              local char = _205_0
              return (char ~= "")
            end
            if ((nil ~= _205_0) and _206_()) then
              local char = _205_0
              c = char
              index = 2
              return c:byte()
            else
              local _ = _205_0
              done_3f = true
              return nil
            end
          end
        end
      end
      local function _210_()
        c = ""
        return nil
      end
      return _204_, _210_
    end
    local function string_stream(str, _3foptions)
      local str0 = str:gsub("^#!", ";;")
      if _3foptions then
        _3foptions.source = str0
      end
      local index = 1
      local function _212_()
        local r = str0:byte(index)
        index = (index + 1)
        return r
      end
      return _212_
    end
    local delims = {[123] = 125, [125] = true, [40] = 41, [41] = true, [91] = 93, [93] = true}
    local function sym_char_3f(b)
      local b0 = nil
      if ("number" == type(b)) then
        b0 = b
      else
        b0 = string.byte(b)
      end
      return ((32 < b0) and not delims[b0] and (b0 ~= 127) and (b0 ~= 34) and (b0 ~= 39) and (b0 ~= 126) and (b0 ~= 59) and (b0 ~= 44) and (b0 ~= 64) and (b0 ~= 96))
    end
    local prefixes = {[35] = "hashfn", [39] = "quote", [44] = "unquote", [96] = "quote"}
    local nan, negative_nan = nil, nil
    if (45 == string.byte(tostring((0 / 0)))) then
      nan, negative_nan = ( - (0 / 0)), (0 / 0)
    else
      nan, negative_nan = (0 / 0), ( - (0 / 0))
    end
    local function char_starter_3f(b)
      return (((1 < b) and (b < 127)) or ((192 < b) and (b < 247)))
    end
    local function parser_fn(getbyte, filename, _215_0)
      local _216_ = _215_0
      local options = _216_
      local comments = _216_["comments"]
      local source = _216_["source"]
      local unfriendly = _216_["unfriendly"]
      local stack = {}
      local line, byteindex, col, prev_col, lastb = 1, 0, 0, 0, nil
      local function ungetb(ub)
        if char_starter_3f(ub) then
          col = (col - 1)
        end
        if (ub == 10) then
          line, col = (line - 1), prev_col
        end
        byteindex = (byteindex - 1)
        lastb = ub
        return nil
      end
      local function getb()
        local r = nil
        if lastb then
          r, lastb = lastb, nil
        else
          r = getbyte({["stack-size"] = #stack})
        end
        if r then
          byteindex = (byteindex + 1)
        end
        if (r and char_starter_3f(r)) then
          col = (col + 1)
        end
        if (r == 10) then
          line, col, prev_col = (line + 1), 0, col
        end
        return r
      end
      local function whitespace_3f(b)
        local function _224_()
          local _223_0 = options.whitespace
          if (nil ~= _223_0) then
            _223_0 = _223_0[b]
          end
          return _223_0
        end
        return ((b == 32) or ((9 <= b) and (b <= 13)) or _224_())
      end
      local function parse_error(msg, _3fcol_adjust)
        local col0 = (col + (_3fcol_adjust or -1))
        if (nil == utils["hook-opts"]("parse-error", options, msg, filename, (line or "?"), col0, source, utils.root.reset)) then
          utils.root.reset()
          if unfriendly then
            return error(string.format("%s:%s:%s: Parse error: %s", filename, (line or "?"), col0, msg), 0)
          else
            return friend["parse-error"](msg, filename, (line or "?"), col0, source, options)
          end
        end
      end
      local function parse_stream()
        local whitespace_since_dispatch, done_3f, retval = true
        local function set_source_fields(source0)
          source0.byteend, source0.endcol, source0.endline = byteindex, (col - 1), line
          return nil
        end
        local function dispatch(v, _3fsource, _3fraw)
          whitespace_since_dispatch = false
          local v0 = nil
          do
            local _228_0 = utils["hook-opts"]("parse-form", options, v, _3fsource, _3fraw, stack)
            if (nil ~= _228_0) then
              local hookv = _228_0
              v0 = hookv
            else
              local _ = _228_0
              v0 = v
            end
          end
          local _230_0 = stack[#stack]
          if (_230_0 == nil) then
            retval, done_3f = v0, true
            return nil
          elseif ((_G.type(_230_0) == "table") and (nil ~= _230_0.prefix)) then
            local prefix = _230_0.prefix
            local source0 = nil
            do
              local _231_0 = table.remove(stack)
              set_source_fields(_231_0)
              source0 = _231_0
            end
            local list = utils.list(utils.sym(prefix, source0), v0)
            return dispatch(utils.copy(source0, list))
          elseif (nil ~= _230_0) then
            local top = _230_0
            return table.insert(top, v0)
          end
        end
        local function badend()
          local closers = nil
          do
            local tbl_17_ = {}
            local i_18_ = #tbl_17_
            for _, _233_0 in ipairs(stack) do
              local _234_ = _233_0
              local closer = _234_["closer"]
              local val_19_ = closer
              if (nil ~= val_19_) then
                i_18_ = (i_18_ + 1)
                tbl_17_[i_18_] = val_19_
              end
            end
            closers = tbl_17_
          end
          local _236_
          if (#stack == 1) then
            _236_ = ""
          else
            _236_ = "s"
          end
          return parse_error(string.format("expected closing delimiter%s %s", _236_, string.char(unpack(closers))), 0)
        end
        local function skip_whitespace(b, close_table)
          if (b and whitespace_3f(b)) then
            whitespace_since_dispatch = true
            return skip_whitespace(getb(), close_table)
          elseif (not b and next(stack)) then
            badend()
            for i = #stack, 2, -1 do
              close_table(stack[i].closer)
            end
            return stack[1].closer
          else
            return b
          end
        end
        local function parse_comment(b, contents)
          if (b and (10 ~= b)) then
            local function _239_()
              table.insert(contents, string.char(b))
              return contents
            end
            return parse_comment(getb(), _239_())
          elseif comments then
            ungetb(10)
            return dispatch(utils.comment(table.concat(contents), {filename = filename, line = line}))
          end
        end
        local function open_table(b)
          if not whitespace_since_dispatch then
            parse_error(("expected whitespace before opening delimiter " .. string.char(b)))
          end
          return table.insert(stack, {bytestart = byteindex, closer = delims[b], col = (col - 1), filename = filename, line = line})
        end
        local function close_list(list)
          return dispatch(setmetatable(list, getmetatable(utils.list())))
        end
        local function close_sequence(tbl)
          local mt = getmetatable(utils.sequence())
          for k, v in pairs(tbl) do
            if ("number" ~= type(k)) then
              mt[k] = v
              tbl[k] = nil
            end
          end
          return dispatch(setmetatable(tbl, mt))
        end
        local function add_comment_at(comments0, index, node)
          local _243_0 = comments0[index]
          if (nil ~= _243_0) then
            local existing = _243_0
            return table.insert(existing, node)
          else
            local _ = _243_0
            comments0[index] = {node}
            return nil
          end
        end
        local function next_noncomment(tbl, i)
          if utils["comment?"](tbl[i]) then
            return next_noncomment(tbl, (i + 1))
          elseif utils["sym?"](tbl[i], ":") then
            return tostring(tbl[(i + 1)])
          else
            return tbl[i]
          end
        end
        local function extract_comments(tbl)
          local comments0 = {keys = {}, last = {}, values = {}}
          while utils["comment?"](tbl[#tbl]) do
            table.insert(comments0.last, 1, table.remove(tbl))
          end
          local last_key_3f = false
          for i, node in ipairs(tbl) do
            if not utils["comment?"](node) then
              last_key_3f = not last_key_3f
            elseif last_key_3f then
              add_comment_at(comments0.values, next_noncomment(tbl, i), node)
            else
              add_comment_at(comments0.keys, next_noncomment(tbl, i), node)
            end
          end
          for i = #tbl, 1, -1 do
            if utils["comment?"](tbl[i]) then
              table.remove(tbl, i)
            end
          end
          return comments0
        end
        local function close_curly_table(tbl)
          local comments0 = extract_comments(tbl)
          local keys = {}
          local val = {}
          if ((#tbl % 2) ~= 0) then
            byteindex = (byteindex - 1)
            parse_error("expected even number of values in table literal")
          end
          setmetatable(val, tbl)
          for i = 1, #tbl, 2 do
            if ((tostring(tbl[i]) == ":") and utils["sym?"](tbl[(i + 1)]) and utils["sym?"](tbl[i])) then
              tbl[i] = tostring(tbl[(i + 1)])
            end
            val[tbl[i]] = tbl[(i + 1)]
            table.insert(keys, tbl[i])
          end
          tbl.comments = comments0
          tbl.keys = keys
          return dispatch(val)
        end
        local function close_table(b)
          local top = table.remove(stack)
          if (top == nil) then
            parse_error(("unexpected closing delimiter " .. string.char(b)))
          end
          if (top.closer and (top.closer ~= b)) then
            parse_error(("mismatched closing delimiter " .. string.char(b) .. ", expected " .. string.char(top.closer)))
          end
          set_source_fields(top)
          if (b == 41) then
            return close_list(top)
          elseif (b == 93) then
            return close_sequence(top)
          else
            return close_curly_table(top)
          end
        end
        local function parse_string_loop(chars, b, state)
          if b then
            table.insert(chars, string.char(b))
          end
          local state0 = nil
          do
            local _254_0 = {state, b}
            if ((_G.type(_254_0) == "table") and (_254_0[1] == "base") and (_254_0[2] == 92)) then
              state0 = "backslash"
            elseif ((_G.type(_254_0) == "table") and (_254_0[1] == "base") and (_254_0[2] == 34)) then
              state0 = "done"
            elseif ((_G.type(_254_0) == "table") and (_254_0[1] == "backslash") and (_254_0[2] == 10)) then
              table.remove(chars, (#chars - 1))
              state0 = "base"
            else
              local _ = _254_0
              state0 = "base"
            end
          end
          if (b and (state0 ~= "done")) then
            return parse_string_loop(chars, getb(), state0)
          else
            return b
          end
        end
        local function escape_char(c)
          return ({[10] = "\\n", [11] = "\\v", [12] = "\\f", [13] = "\\r", [7] = "\\a", [8] = "\\b", [9] = "\\t"})[c:byte()]
        end
        local function parse_string(source0)
          if not whitespace_since_dispatch then
            utils.warn("expected whitespace before string", nil, filename, line)
          end
          table.insert(stack, {closer = 34})
          local chars = {"\""}
          if not parse_string_loop(chars, getb(), "base") then
            badend()
          end
          table.remove(stack)
          local raw = table.concat(chars)
          local formatted = raw:gsub("[\7-\13]", escape_char)
          local _259_0 = (rawget(_G, "loadstring") or load)(("return " .. formatted))
          if (nil ~= _259_0) then
            local load_fn = _259_0
            return dispatch(load_fn(), source0, raw)
          elseif (_259_0 == nil) then
            return parse_error(("Invalid string: " .. raw))
          end
        end
        local function parse_prefix(b)
          table.insert(stack, {bytestart = byteindex, col = (col - 1), filename = filename, line = line, prefix = prefixes[b]})
          local nextb = getb()
          local trailing_whitespace_3f = (whitespace_3f(nextb) or (true == delims[nextb]))
          if (trailing_whitespace_3f and (b ~= 35)) then
            parse_error("invalid whitespace after quoting prefix")
          end
          ungetb(nextb)
          if (trailing_whitespace_3f and (b == 35)) then
            local source0 = table.remove(stack)
            set_source_fields(source0)
            return dispatch(utils.sym("#", source0))
          end
        end
        local function parse_sym_loop(chars, b)
          if (b and sym_char_3f(b)) then
            table.insert(chars, string.char(b))
            return parse_sym_loop(chars, getb())
          else
            if b then
              ungetb(b)
            end
            return chars
          end
        end
        local function parse_number(rawstr, source0)
          local trimmed = (not rawstr:find("^_") and rawstr:gsub("_", ""))
          if ((trimmed == "nan") or (trimmed == "-nan")) then
            return false
          elseif rawstr:match("^%d") then
            dispatch((tonumber(trimmed) or parse_error(("could not read number \"" .. rawstr .. "\""))), source0, rawstr)
            return true
          else
            local _265_0 = tonumber(trimmed)
            if (nil ~= _265_0) then
              local x = _265_0
              dispatch(x, source0, rawstr)
              return true
            else
              local _ = _265_0
              return false
            end
          end
        end
        local function check_malformed_sym(rawstr)
          local function col_adjust(pat)
            return (rawstr:find(pat) - utils.len(rawstr) - 1)
          end
          if (rawstr:match("^~") and (rawstr ~= "~=")) then
            parse_error("invalid character: ~")
          elseif (rawstr:match("[%.:][%.:]") and (rawstr ~= "..") and (rawstr ~= "$...")) then
            parse_error(("malformed multisym: " .. rawstr), col_adjust("[%.:][%.:]"))
          elseif ((rawstr ~= ":") and rawstr:match(":$")) then
            parse_error(("malformed multisym: " .. rawstr), col_adjust(":$"))
          elseif rawstr:match(":.+[%.:]") then
            parse_error(("method must be last component of multisym: " .. rawstr), col_adjust(":.+[%.:]"))
          end
          if not whitespace_since_dispatch then
            utils.warn("expected whitespace before token", nil, filename, line)
          end
          return rawstr
        end
        local function parse_sym(b)
          local source0 = {bytestart = byteindex, col = (col - 1), filename = filename, line = line}
          local rawstr = table.concat(parse_sym_loop({string.char(b)}, getb()))
          set_source_fields(source0)
          if (rawstr == "true") then
            return dispatch(true, source0)
          elseif (rawstr == "false") then
            return dispatch(false, source0)
          elseif (rawstr == "...") then
            return dispatch(utils.varg(source0))
          elseif (rawstr == ".inf") then
            return dispatch((1 / 0), source0, rawstr)
          elseif (rawstr == "-.inf") then
            return dispatch((-1 / 0), source0, rawstr)
          elseif (rawstr == ".nan") then
            return dispatch(nan, source0, rawstr)
          elseif (rawstr == "-.nan") then
            return dispatch(negative_nan, source0, rawstr)
          elseif rawstr:match("^:.+$") then
            return dispatch(rawstr:sub(2), source0, rawstr)
          elseif not parse_number(rawstr, source0) then
            return dispatch(utils.sym(check_malformed_sym(rawstr), source0))
          end
        end
        local function parse_loop(b)
          if not b then
          elseif (b == 59) then
            parse_comment(getb(), {";"})
          elseif (type(delims[b]) == "number") then
            open_table(b)
          elseif delims[b] then
            close_table(b)
          elseif (b == 34) then
            parse_string({bytestart = byteindex, col = col, filename = filename, line = line})
          elseif prefixes[b] then
            parse_prefix(b)
          elseif (sym_char_3f(b) or (b == string.byte("~"))) then
            parse_sym(b)
          elseif not utils["hook-opts"]("illegal-char", options, b, getb, ungetb, dispatch) then
            parse_error(("invalid character: " .. string.char(b)))
          end
          if not b then
            return nil
          elseif done_3f then
            return true, retval
          else
            return parse_loop(skip_whitespace(getb(), close_table))
          end
        end
        return parse_loop(skip_whitespace(getb(), close_table))
      end
      local function _273_()
        stack, line, byteindex, col, lastb = {}, 1, 0, 0, ((lastb ~= 10) and lastb)
        return nil
      end
      return parse_stream, _273_
    end
    local function parser(stream_or_string, _3ffilename, _3foptions)
      local filename = (_3ffilename or "unknown")
      local options = (_3foptions or utils.root.options or {})
      assert(("string" == type(filename)), "expected filename as second argument to parser")
      if ("string" == type(stream_or_string)) then
        return parser_fn(string_stream(stream_or_string, options), filename, options)
      else
        return parser_fn(stream_or_string, filename, options)
      end
    end
    return {["string-stream"] = string_stream, ["sym-char?"] = sym_char_3f, granulate = granulate, parser = parser}
  end
  local utils = nil
  package.preload["fennel.view"] = package.preload["fennel.view"] or function(...)
    local type_order = {["function"] = 5, boolean = 2, number = 1, string = 3, table = 4, thread = 7, userdata = 6}
    local default_opts = {["detect-cycles?"] = true, ["empty-as-sequence?"] = false, ["escape-newlines?"] = false, ["line-length"] = 80, ["max-sparse-gap"] = 10, ["metamethod?"] = true, ["one-line?"] = false, ["prefer-colon?"] = false, ["utf8?"] = true, depth = 128}
    local lua_pairs = pairs
    local lua_ipairs = ipairs
    local function pairs(t)
      local _1_0 = getmetatable(t)
      if ((_G.type(_1_0) == "table") and (nil ~= _1_0.__pairs)) then
        local p = _1_0.__pairs
        return p(t)
      else
        local _ = _1_0
        return lua_pairs(t)
      end
    end
    local function ipairs(t)
      local _3_0 = getmetatable(t)
      if ((_G.type(_3_0) == "table") and (nil ~= _3_0.__ipairs)) then
        local i = _3_0.__ipairs
        return i(t)
      else
        local _ = _3_0
        return lua_ipairs(t)
      end
    end
    local function length_2a(t)
      local _5_0 = getmetatable(t)
      if ((_G.type(_5_0) == "table") and (nil ~= _5_0.__len)) then
        local l = _5_0.__len
        return l(t)
      else
        local _ = _5_0
        return #t
      end
    end
    local function get_default(key)
      local _7_0 = default_opts[key]
      if (_7_0 == nil) then
        return error(("option '%s' doesn't have a default value, use the :after key to set it"):format(tostring(key)))
      elseif (nil ~= _7_0) then
        local v = _7_0
        return v
      end
    end
    local function getopt(options, key)
      local _9_0 = options[key]
      if ((_G.type(_9_0) == "table") and (nil ~= _9_0.once)) then
        local val_2a = _9_0.once
        return val_2a
      else
        local _3fval = _9_0
        return _3fval
      end
    end
    local function normalize_opts(options)
      local tbl_14_ = {}
      for k, v in pairs(options) do
        local k_15_, v_16_ = nil, nil
        local function _12_()
          local _11_0 = v
          if ((_G.type(_11_0) == "table") and (nil ~= _11_0.after)) then
            local val = _11_0.after
            return val
          else
            local function _13_()
              return v.once
            end
            if ((_G.type(_11_0) == "table") and _13_()) then
              return get_default(k)
            else
              local _ = _11_0
              return v
            end
          end
        end
        k_15_, v_16_ = k, _12_()
        if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
          tbl_14_[k_15_] = v_16_
        end
      end
      return tbl_14_
    end
    local function sort_keys(_16_0, _18_0)
      local _17_ = _16_0
      local a = _17_[1]
      local _19_ = _18_0
      local b = _19_[1]
      local ta = type(a)
      local tb = type(b)
      if ((ta == tb) and ((ta == "string") or (ta == "number"))) then
        return (a < b)
      else
        local dta = type_order[ta]
        local dtb = type_order[tb]
        if (dta and dtb) then
          return (dta < dtb)
        elseif dta then
          return true
        elseif dtb then
          return false
        else
          return (ta < tb)
        end
      end
    end
    local function max_index_gap(kv)
      local gap = 0
      if (0 < length_2a(kv)) then
        local i = 0
        for _, _22_0 in ipairs(kv) do
          local _23_ = _22_0
          local k = _23_[1]
          if (gap < (k - i)) then
            gap = (k - i)
          end
          i = k
        end
      end
      return gap
    end
    local function fill_gaps(kv)
      local missing_indexes = {}
      local i = 0
      for _, _26_0 in ipairs(kv) do
        local _27_ = _26_0
        local j = _27_[1]
        i = (i + 1)
        while (i < j) do
          table.insert(missing_indexes, i)
          i = (i + 1)
        end
      end
      for _, k in ipairs(missing_indexes) do
        table.insert(kv, k, {k})
      end
      return nil
    end
    local function table_kv_pairs(t, options)
      local assoc_3f = false
      local kv = {}
      local insert = table.insert
      for k, v in pairs(t) do
        if ((type(k) ~= "number") or (k < 1)) then
          assoc_3f = true
        end
        insert(kv, {k, v})
      end
      table.sort(kv, sort_keys)
      if not assoc_3f then
        if (options["max-sparse-gap"] < max_index_gap(kv)) then
          assoc_3f = true
        else
          fill_gaps(kv)
        end
      end
      if (length_2a(kv) == 0) then
        return kv, "empty"
      else
        local function _31_()
          if assoc_3f then
            return "table"
          else
            return "seq"
          end
        end
        return kv, _31_()
      end
    end
    local function count_table_appearances(t, appearances)
      if (type(t) == "table") then
        if not appearances[t] then
          appearances[t] = 1
          for k, v in pairs(t) do
            count_table_appearances(k, appearances)
            count_table_appearances(v, appearances)
          end
        else
          appearances[t] = ((appearances[t] or 0) + 1)
        end
      end
      return appearances
    end
    local function save_table(t, seen)
      local seen0 = (seen or {len = 0})
      local id = (seen0.len + 1)
      if not seen0[t] then
        seen0[t] = id
        seen0.len = id
      end
      return seen0
    end
    local function detect_cycle(t, seen)
      if ("table" == type(t)) then
        seen[t] = true
        local res = nil
        for k, v in pairs(t) do
          if res then break end
          res = (seen[k] or detect_cycle(k, seen) or seen[v] or detect_cycle(v, seen))
        end
        return res
      end
    end
    local function visible_cycle_3f(t, options)
      return (getopt(options, "detect-cycles?") and detect_cycle(t, {}) and save_table(t, options.seen) and (1 < (options.appearances[t] or 0)))
    end
    local function table_indent(indent, id)
      local opener_length = nil
      if id then
        opener_length = (length_2a(tostring(id)) + 2)
      else
        opener_length = 1
      end
      return (indent + opener_length)
    end
    local pp = nil
    local function concat_table_lines(elements, options, multiline_3f, indent, table_type, prefix, last_comment_3f)
      local indent_str = ("\n" .. string.rep(" ", indent))
      local open = nil
      local function _38_()
        if ("seq" == table_type) then
          return "["
        else
          return "{"
        end
      end
      open = ((prefix or "") .. _38_())
      local close = nil
      if ("seq" == table_type) then
        close = "]"
      else
        close = "}"
      end
      local oneline = (open .. table.concat(elements, " ") .. close)
      if (not getopt(options, "one-line?") and (multiline_3f or (options["line-length"] < (indent + length_2a(oneline))) or last_comment_3f)) then
        local function _40_()
          if last_comment_3f then
            return indent_str
          else
            return ""
          end
        end
        return (open .. table.concat(elements, indent_str) .. _40_() .. close)
      else
        return oneline
      end
    end
    local function utf8_len(x)
      local n = 0
      for _ in string.gmatch(x, "[%z\1-\127\192-\247]") do
        n = (n + 1)
      end
      return n
    end
    local function comment_3f(x)
      if ("table" == type(x)) then
        local fst = x[1]
        return (("string" == type(fst)) and (nil ~= fst:find("^;")))
      else
        return false
      end
    end
    local function pp_associative(t, kv, options, indent)
      local multiline_3f = false
      local id = options.seen[t]
      if (options.depth <= options.level) then
        return "{...}"
      elseif (id and getopt(options, "detect-cycles?")) then
        return ("@" .. id .. "{...}")
      else
        local visible_cycle_3f0 = visible_cycle_3f(t, options)
        local id0 = (visible_cycle_3f0 and options.seen[t])
        local indent0 = table_indent(indent, id0)
        local slength = nil
        if getopt(options, "utf8?") then
          slength = utf8_len
        else
          local function _43_(_241)
            return #_241
          end
          slength = _43_
        end
        local prefix = nil
        if visible_cycle_3f0 then
          prefix = ("@" .. id0)
        else
          prefix = ""
        end
        local items = nil
        do
          local options0 = normalize_opts(options)
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, _46_0 in ipairs(kv) do
            local _47_ = _46_0
            local k = _47_[1]
            local v = _47_[2]
            local val_19_ = nil
            do
              local k0 = pp(k, options0, (indent0 + 1), true)
              local v0 = pp(v, options0, (indent0 + slength(k0) + 1))
              multiline_3f = (multiline_3f or k0:find("\n") or v0:find("\n"))
              val_19_ = (k0 .. " " .. v0)
            end
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          items = tbl_17_
        end
        return concat_table_lines(items, options, multiline_3f, indent0, "table", prefix, false)
      end
    end
    local function pp_sequence(t, kv, options, indent)
      local multiline_3f = false
      local id = options.seen[t]
      if (options.depth <= options.level) then
        return "[...]"
      elseif (id and getopt(options, "detect-cycles?")) then
        return ("@" .. id .. "[...]")
      else
        local visible_cycle_3f0 = visible_cycle_3f(t, options)
        local id0 = (visible_cycle_3f0 and options.seen[t])
        local indent0 = table_indent(indent, id0)
        local prefix = nil
        if visible_cycle_3f0 then
          prefix = ("@" .. id0)
        else
          prefix = ""
        end
        local last_comment_3f = comment_3f(t[#t])
        local items = nil
        do
          local options0 = normalize_opts(options)
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, _51_0 in ipairs(kv) do
            local _52_ = _51_0
            local _0 = _52_[1]
            local v = _52_[2]
            local val_19_ = nil
            do
              local v0 = pp(v, options0, indent0)
              multiline_3f = (multiline_3f or v0:find("\n") or v0:find("^;"))
              val_19_ = v0
            end
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          items = tbl_17_
        end
        return concat_table_lines(items, options, multiline_3f, indent0, "seq", prefix, last_comment_3f)
      end
    end
    local function concat_lines(lines, options, indent, force_multi_line_3f)
      if (length_2a(lines) == 0) then
        if getopt(options, "empty-as-sequence?") then
          return "[]"
        else
          return "{}"
        end
      else
        local oneline = nil
        local _56_
        do
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for _, line in ipairs(lines) do
            local val_19_ = line:gsub("^%s+", "")
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          _56_ = tbl_17_
        end
        oneline = table.concat(_56_, " ")
        if (not getopt(options, "one-line?") and (force_multi_line_3f or oneline:find("\n") or (options["line-length"] < (indent + length_2a(oneline))))) then
          return table.concat(lines, ("\n" .. string.rep(" ", indent)))
        else
          return oneline
        end
      end
    end
    local function pp_metamethod(t, metamethod, options, indent)
      if (options.depth <= options.level) then
        if getopt(options, "empty-as-sequence?") then
          return "[...]"
        else
          return "{...}"
        end
      else
        local _ = nil
        local function _61_(_241)
          return visible_cycle_3f(_241, options)
        end
        options["visible-cycle?"] = _61_
        _ = nil
        local lines, force_multi_line_3f = nil, nil
        do
          local options0 = normalize_opts(options)
          lines, force_multi_line_3f = metamethod(t, pp, options0, indent)
        end
        options["visible-cycle?"] = nil
        local _62_0 = type(lines)
        if (_62_0 == "string") then
          return lines
        elseif (_62_0 == "table") then
          return concat_lines(lines, options, indent, force_multi_line_3f)
        else
          local _0 = _62_0
          return error("__fennelview metamethod must return a table of lines")
        end
      end
    end
    local function pp_table(x, options, indent)
      options.level = (options.level + 1)
      local x0 = nil
      do
        local _65_0 = nil
        if getopt(options, "metamethod?") then
          local _66_0 = x
          if (nil ~= _66_0) then
            local _67_0 = getmetatable(_66_0)
            if (nil ~= _67_0) then
              _65_0 = _67_0.__fennelview
            else
              _65_0 = _67_0
            end
          else
            _65_0 = _66_0
          end
        else
        _65_0 = nil
        end
        if (nil ~= _65_0) then
          local metamethod = _65_0
          x0 = pp_metamethod(x, metamethod, options, indent)
        else
          local _ = _65_0
          local _71_0, _72_0 = table_kv_pairs(x, options)
          if (true and (_72_0 == "empty")) then
            local _0 = _71_0
            if getopt(options, "empty-as-sequence?") then
              x0 = "[]"
            else
              x0 = "{}"
            end
          elseif ((nil ~= _71_0) and (_72_0 == "table")) then
            local kv = _71_0
            x0 = pp_associative(x, kv, options, indent)
          elseif ((nil ~= _71_0) and (_72_0 == "seq")) then
            local kv = _71_0
            x0 = pp_sequence(x, kv, options, indent)
          else
          x0 = nil
          end
        end
      end
      options.level = (options.level - 1)
      return x0
    end
    local function exponential_notation(n, fallback)
      local s = nil
      for i = 0, 308 do
        if s then break end
        local s0 = string.format(("%." .. i .. "e"), n)
        if (n == tonumber(s0)) then
          local exp = s0:match("e%+?(%d+)$")
          if (exp and (14 < tonumber(exp))) then
            s = s0
          else
            s = fallback
          end
        else
        s = nil
        end
      end
      return s
    end
    local inf_str = tostring((1 / 0))
    local neg_inf_str = tostring((-1 / 0))
    local function number__3estring(n, options)
      local val = nil
      if (n ~= n) then
        if (45 == string.byte(tostring(n))) then
          val = (options["negative-nan"] or "-.nan")
        else
          val = (options.nan or ".nan")
        end
      elseif (math.floor(n) == n) then
        local s1 = string.format("%.f", n)
        if (s1 == inf_str) then
          val = (options.infinity or ".inf")
        elseif (s1 == neg_inf_str) then
          val = (options["negative-infinity"] or "-.inf")
        elseif (s1 == tostring(n)) then
          val = s1
        else
          val = (exponential_notation(n, s1) or s1)
        end
      else
        val = tostring(n)
      end
      local _81_0 = string.gsub(val, ",", ".")
      return _81_0
    end
    local function colon_string_3f(s)
      return s:find("^[-%w?^_!$%&*+./|<=>]+$")
    end
    local utf8_inits = {{["max-byte"] = 127, ["max-code"] = 127, ["min-byte"] = 0, ["min-code"] = 0, len = 1}, {["max-byte"] = 223, ["max-code"] = 2047, ["min-byte"] = 192, ["min-code"] = 128, len = 2}, {["max-byte"] = 239, ["max-code"] = 65535, ["min-byte"] = 224, ["min-code"] = 2048, len = 3}, {["max-byte"] = 247, ["max-code"] = 1114111, ["min-byte"] = 240, ["min-code"] = 65536, len = 4}}
    local function default_byte_escape(byte, _options)
      return ("\\%03d"):format(byte)
    end
    local function utf8_escape(str, options)
      local function validate_utf8(str0, index)
        local inits = utf8_inits
        local byte = string.byte(str0, index)
        local init = nil
        do
          local ret = nil
          for _, init0 in ipairs(inits) do
            if ret then break end
            ret = (byte and (function(_82_,_83_,_84_) return (_82_ <= _83_) and (_83_ <= _84_) end)(init0["min-byte"],byte,init0["max-byte"]) and init0)
          end
          init = ret
        end
        local code = nil
        local function _85_()
          local code0 = nil
          if init then
            code0 = (byte - init["min-byte"])
          else
            code0 = nil
          end
          for i = (index + 1), (index + init.len + -1) do
            local byte0 = string.byte(str0, i)
            code0 = (byte0 and code0 and ((128 <= byte0) and (byte0 <= 191)) and ((code0 * 64) + (byte0 - 128)))
          end
          return code0
        end
        code = (init and _85_())
        if (code and (function(_87_,_88_,_89_) return (_87_ <= _88_) and (_88_ <= _89_) end)(init["min-code"],code,init["max-code"]) and not ((55296 <= code) and (code <= 57343))) then
          return init.len
        end
      end
      local index = 1
      local output = {}
      local byte_escape = (getopt(options, "byte-escape") or default_byte_escape)
      while (index <= #str) do
        local nexti = (string.find(str, "[\128-\255]", index) or (#str + 1))
        local len = validate_utf8(str, nexti)
        table.insert(output, string.sub(str, index, (nexti + (len or 0) + -1)))
        if (not len and (nexti <= #str)) then
          table.insert(output, byte_escape(str:byte(nexti), options))
        end
        if len then
          index = (nexti + len)
        else
          index = (nexti + 1)
        end
      end
      return table.concat(output)
    end
    local function pp_string(str, options, indent)
      local len = length_2a(str)
      local esc_newline_3f = ((len < 2) or (getopt(options, "escape-newlines?") and (len < (options["line-length"] - indent))))
      local byte_escape = (getopt(options, "byte-escape") or default_byte_escape)
      local escs = nil
      local _93_
      if esc_newline_3f then
        _93_ = "\\n"
      else
        _93_ = "\n"
      end
      local function _95_(_241, _242)
        return byte_escape(_242:byte(), options)
      end
      escs = setmetatable({["\""] = "\\\"", ["\11"] = "\\v", ["\12"] = "\\f", ["\13"] = "\\r", ["\7"] = "\\a", ["\8"] = "\\b", ["\9"] = "\\t", ["\\"] = "\\\\", ["\n"] = _93_}, {__index = _95_})
      local str0 = ("\"" .. str:gsub("[%c\\\"]", escs) .. "\"")
      if getopt(options, "utf8?") then
        return utf8_escape(str0, options)
      else
        return str0
      end
    end
    local function make_options(t, options)
      local defaults = nil
      do
        local tbl_14_ = {}
        for k, v in pairs(default_opts) do
          local k_15_, v_16_ = k, v
          if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
            tbl_14_[k_15_] = v_16_
          end
        end
        defaults = tbl_14_
      end
      local overrides = {appearances = count_table_appearances(t, {}), level = 0, seen = {len = 0}}
      for k, v in pairs((options or {})) do
        defaults[k] = v
      end
      for k, v in pairs(overrides) do
        defaults[k] = v
      end
      return defaults
    end
    local function _98_(x, options, indent, colon_3f)
      local indent0 = (indent or 0)
      local options0 = (options or make_options(x))
      local x0 = nil
      if options0.preprocess then
        x0 = options0.preprocess(x, options0)
      else
        x0 = x
      end
      local tv = type(x0)
      local function _101_()
        local _100_0 = getmetatable(x0)
        if ((_G.type(_100_0) == "table") and true) then
          local __fennelview = _100_0.__fennelview
          return __fennelview
        end
      end
      if ((tv == "table") or ((tv == "userdata") and _101_())) then
        return pp_table(x0, options0, indent0)
      elseif (tv == "number") then
        return number__3estring(x0, options0)
      else
        local function _103_()
          if (colon_3f ~= nil) then
            return colon_3f
          elseif ("function" == type(options0["prefer-colon?"])) then
            return options0["prefer-colon?"](x0)
          else
            return getopt(options0, "prefer-colon?")
          end
        end
        if ((tv == "string") and colon_string_3f(x0) and _103_()) then
          return (":" .. x0)
        elseif (tv == "string") then
          return pp_string(x0, options0, indent0)
        elseif ((tv == "boolean") or (tv == "nil")) then
          return tostring(x0)
        else
          return ("#<" .. tostring(x0) .. ">")
        end
      end
    end
    pp = _98_
    local function _view(x, _3foptions)
      return pp(x, make_options(x, _3foptions), 0)
    end
    return _view
  end
  package.preload["fennel.utils"] = package.preload["fennel.utils"] or function(...)
    local view = require("fennel.view")
    local version = "1.5.1"
    local function luajit_vm_3f()
      return ((nil ~= _G.jit) and (type(_G.jit) == "table") and (nil ~= _G.jit.on) and (nil ~= _G.jit.off) and (type(_G.jit.version_num) == "number"))
    end
    local function luajit_vm_version()
      local jit_os = nil
      if (_G.jit.os == "OSX") then
        jit_os = "macOS"
      else
        jit_os = _G.jit.os
      end
      return (_G.jit.version .. " " .. jit_os .. "/" .. _G.jit.arch)
    end
    local function fengari_vm_3f()
      return ((nil ~= _G.fengari) and (type(_G.fengari) == "table") and (nil ~= _G.fengari.VERSION) and (type(_G.fengari.VERSION_NUM) == "number"))
    end
    local function fengari_vm_version()
      return (_G.fengari.RELEASE .. " (" .. _VERSION .. ")")
    end
    local function lua_vm_version()
      if luajit_vm_3f() then
        return luajit_vm_version()
      elseif fengari_vm_3f() then
        return fengari_vm_version()
      else
        return ("PUC " .. _VERSION)
      end
    end
    local function runtime_version(_3fas_table)
      if _3fas_table then
        return {fennel = version, lua = lua_vm_version()}
      else
        return ("Fennel " .. version .. " on " .. lua_vm_version())
      end
    end
    local len = nil
    do
      local _108_0, _109_0 = pcall(require, "utf8")
      if ((_108_0 == true) and (nil ~= _109_0)) then
        local utf8 = _109_0
        len = utf8.len
      else
        local _ = _108_0
        len = string.len
      end
    end
    local kv_order = {boolean = 2, number = 1, string = 3, table = 4}
    local function kv_compare(a, b)
      local _111_0, _112_0 = type(a), type(b)
      if (((_111_0 == "number") and (_112_0 == "number")) or ((_111_0 == "string") and (_112_0 == "string"))) then
        return (a < b)
      else
        local function _113_()
          local a_t = _111_0
          local b_t = _112_0
          return (a_t ~= b_t)
        end
        if (((nil ~= _111_0) and (nil ~= _112_0)) and _113_()) then
          local a_t = _111_0
          local b_t = _112_0
          return ((kv_order[a_t] or 5) < (kv_order[b_t] or 5))
        else
          local _ = _111_0
          return (tostring(a) < tostring(b))
        end
      end
    end
    local function add_stable_keys(succ, prev_key, src, _3fpred)
      local first = prev_key
      local last = nil
      do
        local prev = prev_key
        for _, k in ipairs(src) do
          if ((prev == k) or (succ[k] ~= nil) or (_3fpred and not _3fpred(k))) then
            prev = prev
          else
            if (first == nil) then
              first = k
              prev = k
            elseif (prev ~= nil) then
              succ[prev] = k
              prev = k
            else
              prev = k
            end
          end
        end
        last = prev
      end
      return succ, last, first
    end
    local function stablepairs(t)
      local mt_keys = nil
      do
        local _117_0 = getmetatable(t)
        if (nil ~= _117_0) then
          _117_0 = _117_0.keys
        end
        mt_keys = _117_0
      end
      local succ, prev, first_mt = nil, nil, nil
      local function _119_(_241)
        return t[_241]
      end
      succ, prev, first_mt = add_stable_keys({}, nil, (mt_keys or {}), _119_)
      local pairs_keys = nil
      do
        local _120_0 = nil
        do
          local tbl_17_ = {}
          local i_18_ = #tbl_17_
          for k in pairs(t) do
            local val_19_ = k
            if (nil ~= val_19_) then
              i_18_ = (i_18_ + 1)
              tbl_17_[i_18_] = val_19_
            end
          end
          _120_0 = tbl_17_
        end
        table.sort(_120_0, kv_compare)
        pairs_keys = _120_0
      end
      local succ0, _, first_after_mt = add_stable_keys(succ, prev, pairs_keys)
      local first = nil
      if (first_mt == nil) then
        first = first_after_mt
      else
        first = first_mt
      end
      local function stablenext(tbl, key)
        local _123_0 = nil
        if (key == nil) then
          _123_0 = first
        else
          _123_0 = succ0[key]
        end
        if (nil ~= _123_0) then
          local next_key = _123_0
          local _125_0 = tbl[next_key]
          if (_125_0 ~= nil) then
            return next_key, _125_0
          else
            return _125_0
          end
        end
      end
      return stablenext, t, nil
    end
    local function get_in(tbl, path)
      if (nil ~= path[1]) then
        local t = tbl
        for _, k in ipairs(path) do
          if (nil == t) then break end
          if (type(t) == "table") then
            t = t[k]
          else
          t = nil
          end
        end
        return t
      end
    end
    local function copy(_3ffrom, _3fto)
      local tbl_14_ = (_3fto or {})
      for k, v in pairs((_3ffrom or {})) do
        local k_15_, v_16_ = k, v
        if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
          tbl_14_[k_15_] = v_16_
        end
      end
      return tbl_14_
    end
    local function member_3f(x, tbl, _3fn)
      local _131_0 = tbl[(_3fn or 1)]
      if (_131_0 == x) then
        return true
      elseif (_131_0 == nil) then
        return nil
      else
        local _ = _131_0
        return member_3f(x, tbl, ((_3fn or 1) + 1))
      end
    end
    local function maxn(tbl)
      local max = 0
      for k in pairs(tbl) do
        if ("number" == type(k)) then
          max = math.max(max, k)
        else
          max = max
        end
      end
      return max
    end
    local function every_3f(t, predicate)
      local result = true
      for _, item in ipairs(t) do
        if not result then break end
        result = predicate(item)
      end
      return result
    end
    local function allpairs(tbl)
      assert((type(tbl) == "table"), "allpairs expects a table")
      local t = tbl
      local seen = {}
      local function allpairs_next(_, state)
        local next_state, value = next(t, state)
        if seen[next_state] then
          return allpairs_next(nil, next_state)
        elseif next_state then
          seen[next_state] = true
          return next_state, value
        else
          local _134_0 = getmetatable(t)
          if ((_G.type(_134_0) == "table") and true) then
            local __index = _134_0.__index
            if ("table" == type(__index)) then
              t = __index
              return allpairs_next(t)
            end
          end
        end
      end
      return allpairs_next
    end
    local function deref(self)
      return self[1]
    end
    local function list__3estring(self, _3fview, _3foptions, _3findent)
      local viewed = nil
      do
        local tbl_17_ = {}
        local i_18_ = #tbl_17_
        for i = 1, maxn(self) do
          local val_19_ = nil
          if _3fview then
            val_19_ = _3fview(self[i], _3foptions, _3findent)
          else
            val_19_ = view(self[i])
          end
          if (nil ~= val_19_) then
            i_18_ = (i_18_ + 1)
            tbl_17_[i_18_] = val_19_
          end
        end
        viewed = tbl_17_
      end
      return ("(" .. table.concat(viewed, " ") .. ")")
    end
    local function comment_view(c)
      return c, true
    end
    local function sym_3d(a, b)
      return ((deref(a) == deref(b)) and (getmetatable(a) == getmetatable(b)))
    end
    local function sym_3c(a, b)
      return (a[1] < tostring(b))
    end
    local symbol_mt = {"SYMBOL", __eq = sym_3d, __fennelview = deref, __lt = sym_3c, __tostring = deref}
    local expr_mt = nil
    local function _140_(x)
      return tostring(deref(x))
    end
    expr_mt = {"EXPR", __tostring = _140_}
    local list_mt = {"LIST", __fennelview = list__3estring, __tostring = list__3estring}
    local comment_mt = {"COMMENT", __eq = sym_3d, __fennelview = comment_view, __lt = sym_3c, __tostring = deref}
    local sequence_marker = {"SEQUENCE"}
    local varg_mt = {"VARARG", __fennelview = deref, __tostring = deref}
    local getenv = nil
    local function _141_()
      return nil
    end
    getenv = ((os and os.getenv) or _141_)
    local function debug_on_3f(flag)
      local level = (getenv("FENNEL_DEBUG") or "")
      return ((level == "all") or level:find(flag))
    end
    local function list(...)
      return setmetatable({...}, list_mt)
    end
    local function sym(str, _3fsource)
      local _142_
      do
        local tbl_14_ = {str}
        for k, v in pairs((_3fsource or {})) do
          local k_15_, v_16_ = nil, nil
          if (type(k) == "string") then
            k_15_, v_16_ = k, v
          else
          k_15_, v_16_ = nil
          end
          if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
            tbl_14_[k_15_] = v_16_
          end
        end
        _142_ = tbl_14_
      end
      return setmetatable(_142_, symbol_mt)
    end
    local function sequence(...)
      local function _145_(seq, view0, inspector, indent)
        local opts = nil
        do
          inspector["empty-as-sequence?"] = {after = inspector["empty-as-sequence?"], once = true}
          inspector["metamethod?"] = {after = inspector["metamethod?"], once = false}
          opts = inspector
        end
        return view0(seq, opts, indent)
      end
      return setmetatable({...}, {__fennelview = _145_, sequence = sequence_marker})
    end
    local function expr(strcode, etype)
      return setmetatable({strcode, type = etype}, expr_mt)
    end
    local function comment_2a(contents, _3fsource)
      local _146_ = (_3fsource or {})
      local filename = _146_["filename"]
      local line = _146_["line"]
      return setmetatable({contents, filename = filename, line = line}, comment_mt)
    end
    local function varg(_3fsource)
      local _147_
      do
        local tbl_14_ = {"..."}
        for k, v in pairs((_3fsource or {})) do
          local k_15_, v_16_ = nil, nil
          if (type(k) == "string") then
            k_15_, v_16_ = k, v
          else
          k_15_, v_16_ = nil
          end
          if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
            tbl_14_[k_15_] = v_16_
          end
        end
        _147_ = tbl_14_
      end
      return setmetatable(_147_, varg_mt)
    end
    local function expr_3f(x)
      return ((type(x) == "table") and (getmetatable(x) == expr_mt) and x)
    end
    local function varg_3f(x)
      return ((type(x) == "table") and (getmetatable(x) == varg_mt) and x)
    end
    local function list_3f(x)
      return ((type(x) == "table") and (getmetatable(x) == list_mt) and x)
    end
    local function sym_3f(x, _3fname)
      return ((type(x) == "table") and (getmetatable(x) == symbol_mt) and ((nil == _3fname) or (x[1] == _3fname)) and x)
    end
    local function sequence_3f(x)
      local mt = ((type(x) == "table") and getmetatable(x))
      return (mt and (mt.sequence == sequence_marker) and x)
    end
    local function comment_3f(x)
      return ((type(x) == "table") and (getmetatable(x) == comment_mt) and x)
    end
    local function table_3f(x)
      return ((type(x) == "table") and not varg_3f(x) and (getmetatable(x) ~= list_mt) and (getmetatable(x) ~= symbol_mt) and not comment_3f(x) and x)
    end
    local function kv_table_3f(t)
      if table_3f(t) then
        local nxt, t0, k = pairs(t)
        local len0 = #t0
        local next_state = nil
        if (0 == len0) then
          next_state = k
        else
          next_state = len0
        end
        return ((nil ~= nxt(t0, next_state)) and t0)
      end
    end
    local function string_3f(x)
      if (type(x) == "string") then
        return x
      else
        return false
      end
    end
    local function multi_sym_3f(str)
      if sym_3f(str) then
        return multi_sym_3f(tostring(str))
      elseif (type(str) ~= "string") then
        return false
      else
        local function _153_()
          local parts = {}
          for part in str:gmatch("[^%.%:]+[%.%:]?") do
            local last_char = part:sub(-1)
            if (last_char == ":") then
              parts["multi-sym-method-call"] = true
            end
            if ((last_char == ":") or (last_char == ".")) then
              parts[(#parts + 1)] = part:sub(1, -2)
            else
              parts[(#parts + 1)] = part
            end
          end
          return (next(parts) and parts)
        end
        return ((str:match("%.") or str:match(":")) and not str:match("%.%.") and (str:byte() ~= string.byte(".")) and (str:byte() ~= string.byte(":")) and (str:byte(-1) ~= string.byte(".")) and (str:byte(-1) ~= string.byte(":")) and _153_())
      end
    end
    local function call_of_3f(ast, callee)
      return (list_3f(ast) and sym_3f(ast[1], callee))
    end
    local function quoted_3f(symbol)
      return symbol.quoted
    end
    local function idempotent_expr_3f(x)
      local t = type(x)
      return ((t == "string") or (t == "number") or (t == "boolean") or (sym_3f(x) and not multi_sym_3f(x)))
    end
    local function walk_tree(root, f, _3fcustom_iterator)
      local function walk(iterfn, parent, idx, node)
        if (f(idx, node, parent) and not sym_3f(node)) then
          for k, v in iterfn(node) do
            walk(iterfn, node, k, v)
          end
          return nil
        end
      end
      walk((_3fcustom_iterator or pairs), nil, nil, root)
      return root
    end
    local root = nil
    local function _158_()
    end
    root = {chunk = nil, options = nil, reset = _158_, scope = nil}
    root["set-reset"] = function(_159_0)
      local _160_ = _159_0
      local chunk = _160_["chunk"]
      local options = _160_["options"]
      local reset = _160_["reset"]
      local scope = _160_["scope"]
      root.reset = function()
        root.chunk, root.scope, root.options, root.reset = chunk, scope, options, reset
        return nil
      end
      return root.reset
    end
    local lua_keywords = {["and"] = true, ["break"] = true, ["do"] = true, ["else"] = true, ["elseif"] = true, ["end"] = true, ["false"] = true, ["for"] = true, ["function"] = true, ["goto"] = true, ["if"] = true, ["in"] = true, ["local"] = true, ["nil"] = true, ["not"] = true, ["or"] = true, ["repeat"] = true, ["return"] = true, ["then"] = true, ["true"] = true, ["until"] = true, ["while"] = true}
    local function lua_keyword_3f(str)
      local function _162_()
        local _161_0 = root.options
        if (nil ~= _161_0) then
          _161_0 = _161_0.keywords
        end
        if (nil ~= _161_0) then
          _161_0 = _161_0[str]
        end
        return _161_0
      end
      return (lua_keywords[str] or _162_())
    end
    local function valid_lua_identifier_3f(str)
      return (str:match("^[%a_][%w_]*$") and not lua_keyword_3f(str))
    end
    local propagated_options = {"allowedGlobals", "indent", "correlate", "useMetadata", "env", "compiler-env", "compilerEnv"}
    local function propagate_options(options, subopts)
      local tbl_14_ = subopts
      for _, name in ipairs(propagated_options) do
        local k_15_, v_16_ = name, options[name]
        if ((k_15_ ~= nil) and (v_16_ ~= nil)) then
          tbl_14_[k_15_] = v_16_
        end
      end
      return tbl_14_
    end
    local function ast_source(ast)
      if (table_3f(ast) or sequence_3f(ast)) then
        return (getmetatable(ast) or {})
      elseif ("table" == type(ast)) then
        return ast
      else
        return {}
      end
    end
    local function warn(msg, _3fast, _3ffilename, _3fline)
      local _167_0 = nil
      do
        local _168_0 = root.options
        if (nil ~= _168_0) then
          _168_0 = _168_0.warn
        end
        _167_0 = _168_0
      end
      if (nil ~= _167_0) then
        local opt_warn = _167_0
        return opt_warn(msg, _3fast, _3ffilename, _3fline)
      else
        local _ = _167_0
        if (_G.io and _G.io.stderr) then
          local loc = nil
          do
            local _170_0 = ast_source(_3fast)
            if ((_G.type(_170_0) == "table") and (nil ~= _170_0.filename) and (nil ~= _170_0.line)) then
              local filename = _170_0.filename
              local line = _170_0.line
              loc = (filename .. ":" .. line .. ": ")
            else
              local _0 = _170_0
              if (_3ffilename and _3fline) then
                loc = (_3ffilename .. ":" .. _3fline .. ": ")
              else
                loc = ""
              end
            end
          end
          return (_G.io.stderr):write(("--WARNING: %s%s\n"):format(loc, msg))
        end
      end
    end
    local warned = {}
    local function check_plugin_version(_175_0)
      local _176_ = _175_0
      local plugin = _176_
      local name = _176_["name"]
      local versions = _176_["versions"]
      if (not member_3f(version:gsub("-dev", ""), (versions or {})) and not (string_3f(versions) and version:find(versions)) and not warned[plugin]) then
        warned[plugin] = true
        return warn(string.format("plugin %s does not support Fennel version %s", (name or "unknown"), version))
      end
    end
    local function hook_opts(event, _3foptions, ...)
      local plugins = nil
      local function _179_(...)
        local _178_0 = _3foptions
        if (nil ~= _178_0) then
          _178_0 = _178_0.plugins
        end
        return _178_0
      end
      local function _182_(...)
        local _181_0 = root.options
        if (nil ~= _181_0) then
          _181_0 = _181_0.plugins
        end
        return _181_0
      end
      plugins = (_179_(...) or _182_(...))
      if plugins then
        local result = nil
        for _, plugin in ipairs(plugins) do
          if (nil ~= result) then break end
          check_plugin_version(plugin)
          local _184_0 = plugin[event]
          if (nil ~= _184_0) then
            local f = _184_0
            result = f(...)
          else
          result = nil
          end
        end
        return result
      end
    end
    local function hook(event, ...)
      return hook_opts(event, root.options, ...)
    end
    return {["ast-source"] = ast_source, ["call-of?"] = call_of_3f, ["comment?"] = comment_3f, ["debug-on?"] = debug_on_3f, ["every?"] = every_3f, ["expr?"] = expr_3f, ["fennel-module"] = nil, ["get-in"] = get_in, ["hook-opts"] = hook_opts, ["idempotent-expr?"] = idempotent_expr_3f, ["kv-table?"] = kv_table_3f, ["list?"] = list_3f, ["lua-keyword?"] = lua_keyword_3f, ["macro-path"] = table.concat({"./?.fnl", "./?/init-macros.fnl", "./?/init.fnl", getenv("FENNEL_MACRO_PATH")}, ";"), ["member?"] = member_3f, ["multi-sym?"] = multi_sym_3f, ["propagate-options"] = propagate_options, ["quoted?"] = quoted_3f, ["runtime-version"] = runtime_version, ["sequence?"] = sequence_3f, ["string?"] = string_3f, ["sym?"] = sym_3f, ["table?"] = table_3f, ["valid-lua-identifier?"] = valid_lua_identifier_3f, ["varg?"] = varg_3f, ["walk-tree"] = walk_tree, allpairs = allpairs, comment = comment_2a, copy = copy, expr = expr, hook = hook, len = len, list = list, maxn = maxn, path = table.concat({"./?.fnl", "./?/init.fnl", getenv("FENNEL_PATH")}, ";"), root = root, sequence = sequence, stablepairs = stablepairs, sym = sym, varg = varg, version = version, warn = warn}
  end
  utils = require("fennel.utils")
  local parser = require("fennel.parser")
  local compiler = require("fennel.compiler")
  local specials = require("fennel.specials")
  local repl = require("fennel.repl")
  local view = require("fennel.view")
  local function eval_env(env, opts)
    if (env == "_COMPILER") then
      local env0 = specials["make-compiler-env"](nil, compiler.scopes.compiler, {}, opts)
      if (opts.allowedGlobals == nil) then
        opts.allowedGlobals = specials["current-global-names"](env0)
      end
      return specials["wrap-env"](env0)
    else
      return (env and specials["wrap-env"](env))
    end
  end
  local function eval_opts(options, str)
    local opts = utils.copy(options)
    if (opts.allowedGlobals == nil) then
      opts.allowedGlobals = specials["current-global-names"](opts.env)
    end
    if (not opts.filename and not opts.source) then
      opts.source = str
    end
    if (opts.env == "_COMPILER") then
      opts.scope = compiler["make-scope"](compiler.scopes.compiler)
    end
    return opts
  end
  local function eval(str, _3foptions, ...)
    local opts = eval_opts(_3foptions, str)
    local env = eval_env(opts.env, opts)
    local lua_source = compiler["compile-string"](str, opts)
    local loader = nil
    local function _841_(...)
      if opts.filename then
        return ("@" .. opts.filename)
      else
        return str
      end
    end
    loader = specials["load-code"](lua_source, env, _841_(...))
    opts.filename = nil
    return loader(...)
  end
  local function dofile_2a(filename, _3foptions, ...)
    local opts = utils.copy(_3foptions)
    local f = assert(io.open(filename, "rb"))
    local source = assert(f:read("*all"), ("Could not read " .. filename))
    f:close()
    opts.filename = filename
    return eval(source, opts, ...)
  end
  local function syntax()
    local body_3f = {"when", "with-open", "collect", "icollect", "fcollect", "lambda", "\206\187", "macro", "match", "match-try", "case", "case-try", "accumulate", "faccumulate", "doto"}
    local binding_3f = {"collect", "icollect", "fcollect", "each", "for", "let", "with-open", "accumulate", "faccumulate"}
    local define_3f = {"fn", "lambda", "\206\187", "var", "local", "macro", "macros", "global"}
    local deprecated = {"~=", "#", "global", "require-macros", "pick-args"}
    local out = {}
    for k, v in pairs(compiler.scopes.global.specials) do
      local metadata = (compiler.metadata[v] or {})
      out[k] = {["binding-form?"] = utils["member?"](k, binding_3f), ["body-form?"] = metadata["fnl/body-form?"], ["define?"] = utils["member?"](k, define_3f), ["deprecated?"] = utils["member?"](k, deprecated), ["special?"] = true}
    end
    for k in pairs(compiler.scopes.global.macros) do
      out[k] = {["binding-form?"] = utils["member?"](k, binding_3f), ["body-form?"] = utils["member?"](k, body_3f), ["define?"] = utils["member?"](k, define_3f), ["macro?"] = true}
    end
    for k, v in pairs(_G) do
      local _842_0 = type(v)
      if (_842_0 == "function") then
        out[k] = {["function?"] = true, ["global?"] = true}
      elseif (_842_0 == "table") then
        if not k:find("^_") then
          for k2, v2 in pairs(v) do
            if ("function" == type(v2)) then
              out[(k .. "." .. k2)] = {["function?"] = true, ["global?"] = true}
            end
          end
          out[k] = {["global?"] = true}
        end
      end
    end
    return out
  end
  local mod = {["ast-source"] = utils["ast-source"], ["comment?"] = utils["comment?"], ["compile-stream"] = compiler["compile-stream"], ["compile-string"] = compiler["compile-string"], ["list?"] = utils["list?"], ["load-code"] = specials["load-code"], ["macro-loaded"] = specials["macro-loaded"], ["macro-path"] = utils["macro-path"], ["macro-searchers"] = specials["macro-searchers"], ["make-searcher"] = specials["make-searcher"], ["multi-sym?"] = utils["multi-sym?"], ["runtime-version"] = utils["runtime-version"], ["search-module"] = specials["search-module"], ["sequence?"] = utils["sequence?"], ["string-stream"] = parser["string-stream"], ["sym-char?"] = parser["sym-char?"], ["sym?"] = utils["sym?"], ["table?"] = utils["table?"], ["varg?"] = utils["varg?"], comment = utils.comment, compile = compiler.compile, compile1 = compiler.compile1, compileStream = compiler["compile-stream"], compileString = compiler["compile-string"], doc = specials.doc, dofile = dofile_2a, eval = eval, gensym = compiler.gensym, getinfo = compiler.getinfo, granulate = parser.granulate, list = utils.list, loadCode = specials["load-code"], macroLoaded = specials["macro-loaded"], macroPath = utils["macro-path"], macroSearchers = specials["macro-searchers"], makeSearcher = specials["make-searcher"], make_searcher = specials["make-searcher"], mangle = compiler["global-mangling"], metadata = compiler.metadata, parser = parser.parser, path = utils.path, repl = repl, runtimeVersion = utils["runtime-version"], scope = compiler["make-scope"], searchModule = specials["search-module"], searcher = specials["make-searcher"](), sequence = utils.sequence, stringStream = parser["string-stream"], sym = utils.sym, syntax = syntax, traceback = compiler.traceback, unmangle = compiler["global-unmangling"], varg = utils.varg, version = utils.version, view = view}
  mod.install = function(_3fopts)
    table.insert((package.searchers or package.loaders), specials["make-searcher"](_3fopts))
    return mod
  end
  utils["fennel-module"] = mod
  do
    local module_name = "fennel.macros"
    local _ = nil
    local function _846_()
      return mod
    end
    package.preload[module_name] = _846_
    _ = nil
    local env = nil
    do
      local _847_0 = specials["make-compiler-env"](nil, compiler.scopes.compiler, {})
      _847_0["utils"] = utils
      _847_0["fennel"] = mod
      _847_0["get-function-metadata"] = specials["get-function-metadata"]
      env = _847_0
    end
    local built_ins = eval([===[;; fennel-ls: macro-file
    
    ;; These macros are awkward because their definition cannot rely on the any
    ;; built-in macros, only special forms. (no when, no icollect, etc)
    
    (fn copy [t]
      (let [out []]
        (each [_ v (ipairs t)] (table.insert out v))
        (setmetatable out (getmetatable t))))
    
    (fn ->* [val ...]
      "Thread-first macro.
    Take the first value and splice it into the second form as its first argument.
    The value of the second form is spliced into the first arg of the third, etc."
      (var x val)
      (each [_ e (ipairs [...])]
        (let [elt (if (list? e) (copy e) (list e))]
          (table.insert elt 2 x)
          (set x elt)))
      x)
    
    (fn ->>* [val ...]
      "Thread-last macro.
    Same as ->, except splices the value into the last position of each form
    rather than the first."
      (var x val)
      (each [_ e (ipairs [...])]
        (let [elt (if (list? e) (copy e) (list e))]
          (table.insert elt x)
          (set x elt)))
      x)
    
    (fn -?>* [val ?e ...]
      "Nil-safe thread-first macro.
    Same as -> except will short-circuit with nil when it encounters a nil value."
      (if (= nil ?e)
          val
          (not (utils.idempotent-expr? val))
          ;; try again, but with an eval-safe val
          `(let [tmp# ,val]
            (-?> tmp# ,?e ,...))
          (let [call (if (list? ?e) (copy ?e) (list ?e))]
            (table.insert call 2 val)
            `(if (not= nil ,val)
                 ,(-?>* call ...)))))
    
    (fn -?>>* [val ?e ...]
      "Nil-safe thread-last macro.
    Same as ->> except will short-circuit with nil when it encounters a nil value."
      (if (= nil ?e)
          val
          (not (utils.idempotent-expr? val))
          ;; try again, but with an eval-safe val
          `(let [tmp# ,val]
            (-?>> tmp# ,?e ,...))
          (let [call (if (list? ?e) (copy ?e) (list ?e))]
            (table.insert call val)
            `(if (not= ,val nil)
                 ,(-?>>* call ...)))))
    
    (fn ?dot [tbl ...]
      "Nil-safe table look up.
    Same as . (dot), except will short-circuit with nil when it encounters
    a nil value in any of subsequent keys."
      (let [head (gensym :t)
            lookups `(do
                       (var ,head ,tbl)
                       ,head)]
        (each [i k (ipairs [...])]
          ;; Kinda gnarly to reassign in place like this, but it emits the best lua.
          ;; With this impl, it emits a flat, concise, and readable set of ifs
          (table.insert lookups (+ i 2)
                        `(if (not= nil ,head) (set ,head (. ,head ,k)))))
        lookups))
    
    (fn doto* [val ...]
      "Evaluate val and splice it into the first argument of subsequent forms."
      (assert (not= val nil) "missing subject")
      (if (not (utils.idempotent-expr? val))
        `(let [tmp# ,val]
           (doto tmp# ,...))
        (let [form `(do)]
          (each [_ elt (ipairs [...])]
            (let [elt (if (list? elt) (copy elt) (list elt))]
              (table.insert elt 2 val)
              (table.insert form elt)))
          (table.insert form val)
          form)))
    
    (fn when* [condition body1 ...]
      "Evaluate body for side-effects only when condition is truthy."
      (assert body1 "expected body")
      `(if ,condition
           (do
             ,body1
             ,...)))
    
    (fn with-open* [closable-bindings ...]
      "Like `let`, but invokes (v:close) on each binding after evaluating the body.
    The body is evaluated inside `xpcall` so that bound values will be closed upon
    encountering an error before propagating it."
      (let [bodyfn `(fn []
                      ,...)
            closer `(fn close-handlers# [ok# ...]
                      (if ok# ... (error ... 0)))
            traceback `(. (or (. package.loaded ,(fennel-module-name)) _G.debug {})
                          :traceback)]
        (for [i 1 (length closable-bindings) 2]
          (assert (sym? (. closable-bindings i))
                  "with-open only allows symbols in bindings")
          (table.insert closer 4 `(: ,(. closable-bindings i) :close)))
        `(let ,closable-bindings
           ,closer
           (close-handlers# (_G.xpcall ,bodyfn ,traceback)))))
    
    (fn extract-into [iter-tbl]
      (var (into iter-out found?) (values [] (copy iter-tbl)))
      (for [i (length iter-tbl) 2 -1]
        (let [item (. iter-tbl i)]
          (if (or (sym? item "&into") (= :into item))
              (do
                (assert (not found?) "expected only one &into clause")
                (set found? true)
                (set into (. iter-tbl (+ i 1)))
                (table.remove iter-out i)
                (table.remove iter-out i)))))
      (assert (or (not found?) (sym? into) (table? into) (list? into))
              "expected table, function call, or symbol in &into clause")
      (values into iter-out found?))
    
    (fn collect* [iter-tbl key-expr value-expr ...]
      "Return a table made by running an iterator and evaluating an expression that
    returns key-value pairs to be inserted sequentially into the table.  This can
    be thought of as a table comprehension. The body should provide two expressions
    (used as key and value) or nil, which causes it to be omitted.
    
    For example,
      (collect [k v (pairs {:apple \"red\" :orange \"orange\"})]
        (values v k))
    returns
      {:red \"apple\" :orange \"orange\"}
    
    Supports an &into clause after the iterator to put results in an existing table.
    Supports early termination with an &until clause."
      (assert (and (sequence? iter-tbl) (<= 2 (length iter-tbl)))
              "expected iterator binding table")
      (assert (not= nil key-expr) "expected key and value expression")
      (assert (= nil ...)
              "expected 1 or 2 body expressions; wrap multiple expressions with do")
      (assert (or value-expr (list? key-expr)) "need key and value")
      (let [kv-expr (if (= nil value-expr) key-expr `(values ,key-expr ,value-expr))
            (into iter) (extract-into iter-tbl)]
        `(let [tbl# ,into]
           (each ,iter
             (let [(k# v#) ,kv-expr]
               (if (and (not= k# nil) (not= v# nil))
                 (tset tbl# k# v#))))
           tbl#)))
    
    (fn seq-collect [how iter-tbl value-expr ...]
      "Common part between icollect and fcollect for producing sequential tables.
    
    Iteration code only differs in using the for or each keyword, the rest
    of the generated code is identical."
      (assert (not= nil value-expr) "expected table value expression")
      (assert (= nil ...)
              "expected exactly one body expression. Wrap multiple expressions in do")
      (let [(into iter has-into?) (extract-into iter-tbl)]
        (if has-into?
            `(let [tbl# ,into]
               (,how ,iter (let [val# ,value-expr]
                             (table.insert tbl# val#)))
               tbl#)
            ;; believe it or not, using a var here has a pretty good performance
            ;; boost: https://p.hagelb.org/icollect-performance.html
            ;; but it doesn't always work with &into clauses, so skip if that's used
            `(let [tbl# []]
               (var i# 0)
               (,how ,iter
                     (let [val# ,value-expr]
                       (when (not= nil val#)
                         (set i# (+ i# 1))
                         (tset tbl# i# val#))))
               tbl#))))
    
    (fn icollect* [iter-tbl value-expr ...]
      "Return a sequential table made by running an iterator and evaluating an
    expression that returns values to be inserted sequentially into the table.
    This can be thought of as a table comprehension. If the body evaluates to nil
    that element is omitted.
    
    For example,
      (icollect [_ v (ipairs [1 2 3 4 5])]
        (when (not= v 3)
          (* v v)))
    returns
      [1 4 16 25]
    
    Supports an &into clause after the iterator to put results in an existing table.
    Supports early termination with an &until clause."
      (assert (and (sequence? iter-tbl) (<= 2 (length iter-tbl)))
              "expected iterator binding table")
      (seq-collect 'each iter-tbl value-expr ...))
    
    (fn fcollect* [iter-tbl value-expr ...]
      "Return a sequential table made by advancing a range as specified by
    for, and evaluating an expression that returns values to be inserted
    sequentially into the table.  This can be thought of as a range
    comprehension. If the body evaluates to nil that element is omitted.
    
    For example,
      (fcollect [i 1 10 2]
        (when (not= i 3)
          (* i i)))
    returns
      [1 25 49 81]
    
    Supports an &into clause after the range to put results in an existing table.
    Supports early termination with an &until clause."
      (assert (and (sequence? iter-tbl) (< 2 (length iter-tbl)))
              "expected range binding table")
      (seq-collect 'for iter-tbl value-expr ...))
    
    (fn accumulate-impl [for? iter-tbl body ...]
      (assert (and (sequence? iter-tbl) (<= 4 (length iter-tbl)))
              "expected initial value and iterator binding table")
      (assert (not= nil body) "expected body expression")
      (assert (= nil ...)
              "expected exactly one body expression. Wrap multiple expressions with do")
      (let [[accum-var accum-init] iter-tbl
            iter (sym (if for? "for" "each"))] ; accumulate or faccumulate?
        `(do
           (var ,accum-var ,accum-init)
           (,iter ,[(unpack iter-tbl 3)]
                  (set ,accum-var ,body))
           ,(if (list? accum-var)
              (list (sym :values) (unpack accum-var))
              accum-var))))
    
    (fn accumulate* [iter-tbl body ...]
      "Accumulation macro.
    
    It takes a binding table and an expression as its arguments.  In the binding
    table, the first form starts out bound to the second value, which is an initial
    accumulator. The rest are an iterator binding table in the format `each` takes.
    
    It runs through the iterator in each step of which the given expression is
    evaluated, and the accumulator is set to the value of the expression. It
    eventually returns the final value of the accumulator.
    
    For example,
      (accumulate [total 0
                   _ n (pairs {:apple 2 :orange 3})]
        (+ total n))
    returns 5"
      (accumulate-impl false iter-tbl body ...))
    
    (fn faccumulate* [iter-tbl body ...]
      "Identical to accumulate, but after the accumulator the binding table is the
    same as `for` instead of `each`. Like collect to fcollect, will iterate over a
    numerical range like `for` rather than an iterator."
      (accumulate-impl true iter-tbl body ...))
    
    (fn partial* [f ...]
      "Return a function with all arguments partially applied to f."
      (assert f "expected a function to partially apply")
      (let [bindings []
            args []]
        (each [_ arg (ipairs [...])]
          (if (utils.idempotent-expr? arg)
            (table.insert args arg)
            (let [name (gensym)]
              (table.insert bindings name)
              (table.insert bindings arg)
              (table.insert args name))))
        (let [body (list f (unpack args))]
          (table.insert body _VARARG)
          ;; only use the extra let if we need double-eval protection
          (if (= nil (. bindings 1))
              `(fn [,_VARARG] ,body)
              `(let ,bindings
                 (fn [,_VARARG] ,body))))))
    
    (fn pick-args* [n f]
      "Create a function of arity n that applies its arguments to f. Deprecated."
      (if (and _G.io _G.io.stderr)
          (_G.io.stderr:write
           "-- WARNING: pick-args is deprecated and will be removed in the future.\n"))
      (let [bindings []]
        (for [i 1 n] (tset bindings i (gensym)))
        `(fn ,bindings (,f ,(unpack bindings)))))
    
    (fn lambda* [...]
      "Function literal with nil-checked arguments.
    Like `fn`, but will throw an exception if a declared argument is passed in as
    nil, unless that argument's name begins with a question mark."
      (let [args [...]
            args-len (length args)
            has-internal-name? (sym? (. args 1))
            arglist (if has-internal-name? (. args 2) (. args 1))
            metadata-position (if has-internal-name? 3 2)
            (_ check-position) (get-function-metadata [:lambda ...] arglist
                                                      metadata-position)
            empty-body? (< args-len check-position)]
        (fn check! [a]
          (if (table? a)
              (each [_ a (pairs a)] (check! a))
              (let [as (tostring a)]
                (and (not (as:find "^?")) (not= as "&") (not (as:find "^_"))
                     (not= as "...") (not= as "&as")))
              (table.insert args check-position
                            `(_G.assert (not= nil ,a)
                                        ,(: "Missing argument %s on %s:%s" :format
                                            (tostring a)
                                            (or a.filename :unknown)
                                            (or a.line "?"))))))
    
        (assert (= :table (type arglist)) "expected arg list")
        (each [_ a (ipairs arglist)] (check! a))
        (if empty-body? (table.insert args (sym :nil)))
        `(fn ,(unpack args))))
    
    (fn macro* [name ...]
      "Define a single macro."
      (assert (sym? name) "expected symbol for macro name")
      (local args [...])
      `(macros {,(tostring name) (fn ,(unpack args))}))
    
    (fn macrodebug* [form return?]
      "Print the resulting form after performing macroexpansion.
    With a second argument, returns expanded form as a string instead of printing."
      (let [handle (if return? `do `print)]
        ;; TODO: Provide a helpful compiler error in the unlikely edge case of an
        ;; infinite AST instead of the current "silently expand until max depth"
        `(,handle ,(view (macroexpand form _SCOPE) {:detect-cycles? false}))))
    
    (fn import-macros* [binding1 module-name1 ...]
      "Bind a table of macros from each macro module according to a binding form.
    Each binding form can be either a symbol or a k/v destructuring table.
    Example:
      (import-macros mymacros                 :my-macros    ; bind to symbol
                     {:macro1 alias : macro2} :proj.macros) ; import by name"
      (assert (and binding1 module-name1 (= 0 (% (select "#" ...) 2)))
              "expected even number of binding/modulename pairs")
      (for [i 1 (select "#" binding1 module-name1 ...) 2]
        ;; delegate the actual loading of the macros to the require-macros
        ;; special which already knows how to set up the compiler env and stuff.
        ;; this is weird because require-macros is deprecated but it works.
        (let [(binding modname) (select i binding1 module-name1 ...)
              scope (get-scope)
              ;; if the module-name is an expression (and not just a string) we
              ;; patch our expression to have the correct source filename so
              ;; require-macros can pass it down when resolving the module-name.
              expr `(import-macros ,modname)
              filename (if (list? modname) (. modname 1 :filename) :unknown)
              _ (tset expr :filename filename)
              macros* (_SPECIALS.require-macros expr scope {} binding)]
          (if (sym? binding)
              ;; bind whole table of macros to table bound to symbol
              (tset scope.macros (. binding 1) macros*)
              ;; 1-level table destructuring for importing individual macros
              (table? binding)
              (each [macro-name [import-key] (pairs binding)]
                (assert (= :function (type (. macros* macro-name)))
                        (.. "macro " macro-name " not found in module "
                            (tostring modname)))
                (tset scope.macros import-key (. macros* macro-name))))))
      nil)
    
    (fn assert-repl* [condition ...]
      "Enter into a debug REPL  and print the message when condition is false/nil.
    Works as a drop-in replacement for Lua's `assert`.
    REPL `,return` command returns values to assert in place to continue execution."
      {:fnl/arglist [condition ?message ...]}
      (fn add-locals [{: symmeta : parent} locals]
        (each [name (pairs symmeta)]
          (tset locals name (sym name)))
        (if parent (add-locals parent locals) locals))
      `(let [unpack# (or table.unpack _G.unpack)
             pack# (or table.pack #(doto [$...] (tset :n (select :# $...))))
             ;; need to pack/unpack input args to account for (assert (foo)),
             ;; because assert returns *all* arguments upon success
             vals# (pack# ,condition ,...)
             condition# (. vals# 1)
             message# (or (. vals# 2) "assertion failed, entering repl.")]
         (if (not condition#)
             (let [opts# {:assert-repl? true}
                   fennel# (require ,(fennel-module-name))
                   locals# ,(add-locals (get-scope) [])]
               (set opts#.message (fennel#.traceback message#))
               (set opts#.env (collect [k# v# (pairs _G) &into locals#]
                                (if (= nil (. locals# k#)) (values k# v#))))
               (_G.assert (fennel#.repl opts#)))
             (values (unpack# vals# 1 vals#.n)))))
    
    {:-> ->*
     :->> ->>*
     :-?> -?>*
     :-?>> -?>>*
     :?. ?dot
     :doto doto*
     :when when*
     :with-open with-open*
     :collect collect*
     :icollect icollect*
     :fcollect fcollect*
     :accumulate accumulate*
     :faccumulate faccumulate*
     :partial partial*
     :lambda lambda*
     :λ lambda*
     :pick-args pick-args*
     :macro macro*
     :macrodebug macrodebug*
     :import-macros import-macros*
     :assert-repl assert-repl*}
    ]===], {env = env, filename = "src/fennel/macros.fnl", moduleName = module_name, scope = compiler.scopes.compiler, useMetadata = true})
    local _0 = nil
    for k, v in pairs(built_ins) do
      compiler.scopes.global.macros[k] = v
    end
    _0 = nil
    local match_macros = eval([===[;; fennel-ls: macro-file
    
    ;;; Pattern matching
    ;; This is separated out so we can use the "core" macros during the
    ;; implementation of pattern matching.
    
    (fn copy [t] (collect [k v (pairs t)] k v))
    
    (fn double-eval-safe? [x type]
      (or (= :number type) (= :string type) (= :boolean type)
          (and (sym? x) (not (multi-sym? x)))))
    
    (fn with [opts k]
      (doto (copy opts) (tset k true)))
    
    (fn without [opts k]
      (doto (copy opts) (tset k nil)))
    
    (fn case-values [vals pattern unifications case-pattern opts]
      (let [condition `(and)
            bindings []]
        (each [i pat (ipairs pattern)]
          (let [(subcondition subbindings) (case-pattern [(. vals i)] pat
                                                          unifications (without opts :multival?))]
            (table.insert condition subcondition)
            (icollect [_ b (ipairs subbindings) &into bindings] b)))
        (values condition bindings)))
    
    (fn case-table [val pattern unifications case-pattern opts ?top]
      (let [condition (if (= :table ?top) `(and) `(and (= (_G.type ,val) :table)))
            bindings []]
        (each [k pat (pairs pattern)]
          (if (sym? pat :&)
              (let [rest-pat (. pattern (+ k 1))
                    rest-val `(select ,k ((or table.unpack _G.unpack) ,val))
                    subcondition (case-table `(pick-values 1 ,rest-val)
                                              rest-pat unifications case-pattern
                                              (without opts :multival?))]
                (if (not (sym? rest-pat))
                    (table.insert condition subcondition))
                (assert (= nil (. pattern (+ k 2)))
                        "expected & rest argument before last parameter")
                (table.insert bindings rest-pat)
                (table.insert bindings [rest-val]))
              (sym? k :&as)
              (do
                (table.insert bindings pat)
                (table.insert bindings val))
              (and (= :number (type k)) (sym? pat :&as))
              (do
                (assert (= nil (. pattern (+ k 2)))
                        "expected &as argument before last parameter")
                (table.insert bindings (. pattern (+ k 1)))
                (table.insert bindings val))
              ;; don't process the pattern right after &/&as; already got it
              (or (not= :number (type k)) (and (not (sym? (. pattern (- k 1)) :&as))
                                               (not (sym? (. pattern (- k 1)) :&))))
              (let [subval `(. ,val ,k)
                    (subcondition subbindings) (case-pattern [subval] pat
                                                              unifications
                                                              (without opts :multival?))]
                (table.insert condition subcondition)
                (icollect [_ b (ipairs subbindings) &into bindings] b))))
        (values condition bindings)))
    
    (fn case-guard [vals condition guards unifications case-pattern opts]
      (if (. guards 1)
        (let [(pcondition bindings) (case-pattern vals condition unifications opts)
              condition `(and ,(unpack guards))]
           (values `(and ,pcondition
                         (let ,bindings
                           ,condition)) bindings))
        (case-pattern vals condition unifications opts)))
    
    (fn symbols-in-pattern [pattern]
      "gives the set of symbols inside a pattern"
      (if (list? pattern)
          (if (or (sym? (. pattern 1) :where)
                  (sym? (. pattern 1) :=))
              (symbols-in-pattern (. pattern 2))
              (sym? (. pattern 2) :?)
              (symbols-in-pattern (. pattern 1))
              (let [result {}]
                (each [_ child-pattern (ipairs pattern)]
                  (collect [name symbol (pairs (symbols-in-pattern child-pattern)) &into result]
                    name symbol))
                result))
          (sym? pattern)
          (if (and (not (sym? pattern :or))
                   (not (sym? pattern :nil)))
              {(tostring pattern) pattern}
              {})
          (= (type pattern) :table)
          (let [result {}]
            (each [key-pattern value-pattern (pairs pattern)]
              (collect [name symbol (pairs (symbols-in-pattern key-pattern)) &into result]
                name symbol)
              (collect [name symbol (pairs (symbols-in-pattern value-pattern)) &into result]
                name symbol))
            result)
          {}))
    
    (fn symbols-in-every-pattern [pattern-list infer-unification?]
      "gives a list of symbols that are present in every pattern in the list"
      (let [?symbols (accumulate [?symbols nil
                                  _ pattern (ipairs pattern-list)]
                       (let [in-pattern (symbols-in-pattern pattern)]
                         (if ?symbols
                           (do
                             (each [name (pairs ?symbols)]
                               (when (not (. in-pattern name))
                                 (tset ?symbols name nil)))
                             ?symbols)
                           in-pattern)))]
        (icollect [_ symbol (pairs (or ?symbols {}))]
          (if (not (and infer-unification?
                        (in-scope? symbol)))
            symbol))))
    
    (fn case-or [vals pattern guards unifications case-pattern opts]
      (let [pattern [(unpack pattern 2)]
            bindings (symbols-in-every-pattern pattern opts.infer-unification?)]
        (if (= nil (. bindings 1))
            ;; no bindings special case generates simple code
            (let [condition (icollect [_ subpattern (ipairs pattern) &into `(or)]
                              (case-pattern vals subpattern unifications opts))]
              (values (if (. guards 1)
                          `(and ,condition ,(unpack guards))
                          condition)
                      []))
          ;; case with bindings is handled specially, and returns three values instead of two
          (let [matched? (gensym :matched?)
                bindings-mangled (icollect [_ binding (ipairs bindings)]
                                   (gensym (tostring binding)))
                pre-bindings `(if)]
            (each [_ subpattern (ipairs pattern)]
              (let [(subcondition subbindings) (case-guard vals subpattern guards {} case-pattern opts)]
                (table.insert pre-bindings subcondition)
                (table.insert pre-bindings `(let ,subbindings
                                              (values true ,(unpack bindings))))))
            (values matched?
                    [`(,(unpack bindings)) `(values ,(unpack bindings-mangled))]
                    [`(,matched? ,(unpack bindings-mangled)) pre-bindings])))))
    
    (fn case-pattern [vals pattern unifications opts ?top]
      "Take the AST of values and a single pattern and returns a condition
    to determine if it matches as well as a list of bindings to
    introduce for the duration of the body if it does match."
    
      ;; This function returns the following values (multival):
      ;; a "condition", which is an expression that determines whether the
      ;;   pattern should match,
      ;; a "bindings", which bind all of the symbols used in a pattern
      ;; an optional "pre-bindings", which is a list of bindings that happen
      ;;   before the condition and bindings are evaluated. These should only
      ;;   come from a (case-or). In this case there should be no recursion:
      ;;   the call stack should be case-condition > case-pattern > case-or
      ;;
      ;; Here are the expected flags in the opts table:
      ;;   :infer-unification? boolean - if the pattern should guess when to unify  (ie, match -> true, case -> false)
      ;;   :multival? boolean - if the pattern can contain multivals  (in order to disallow patterns like [(1 2)])
      ;;   :in-where? boolean - if the pattern is surrounded by (where)  (where opts into more pattern features)
      ;;   :legacy-guard-allowed? boolean - if the pattern should allow `(a ? b) patterns
    
      ;; we have to assume we're matching against multiple values here until we
      ;; know we're either in a multi-valued clause (in which case we know the #
      ;; of vals) or we're not, in which case we only care about the first one.
      (let [[val] vals]
        (if (and (sym? pattern)
                 (or (sym? pattern :nil)
                     (and opts.infer-unification?
                          (in-scope? pattern)
                          (not (sym? pattern :_)))
                     (and opts.infer-unification?
                          (multi-sym? pattern)
                          (in-scope? (. (multi-sym? pattern) 1)))))
            (values `(= ,val ,pattern) [])
            ;; unify a local we've seen already
            (and (sym? pattern) (. unifications (tostring pattern)))
            (values `(= ,(. unifications (tostring pattern)) ,val) [])
            ;; bind a fresh local
            (sym? pattern)
            (let [wildcard? (: (tostring pattern) :find "^_")]
              (if (not wildcard?) (tset unifications (tostring pattern) val))
              (values (if (or wildcard? (string.find (tostring pattern) "^?")) true
                          `(not= ,(sym :nil) ,val)) [pattern val]))
            ;; opt-in unify with (=)
            (and (list? pattern)
                 (sym? (. pattern 1) :=)
                 (sym? (. pattern 2)))
            (let [bind (. pattern 2)]
              (assert-compile (= 2 (length pattern)) "(=) should take only one argument" pattern)
              (assert-compile (not opts.infer-unification?) "(=) cannot be used inside of match" pattern)
              (assert-compile opts.in-where? "(=) must be used in (where) patterns" pattern)
              (assert-compile (and (sym? bind) (not (sym? bind :nil)) "= has to bind to a symbol" bind))
              (values `(= ,val ,bind) []))
            ;; where-or clause
            (and (list? pattern) (sym? (. pattern 1) :where) (list? (. pattern 2)) (sym? (. pattern 2 1) :or))
            (do
              (assert-compile ?top "can't nest (where) pattern" pattern)
              (case-or vals (. pattern 2) [(unpack pattern 3)] unifications case-pattern (with opts :in-where?)))
            ;; where clause
            (and (list? pattern) (sym? (. pattern 1) :where))
            (do
              (assert-compile ?top "can't nest (where) pattern" pattern)
              (case-guard vals (. pattern 2) [(unpack pattern 3)] unifications case-pattern (with opts :in-where?)))
            ;; or clause (not allowed on its own)
            (and (list? pattern) (sym? (. pattern 1) :or))
            (do
              (assert-compile ?top "can't nest (or) pattern" pattern)
              ;; This assertion can be removed to make patterns more permissive
              (assert-compile false "(or) must be used in (where) patterns" pattern)
              (case-or vals pattern [] unifications case-pattern opts))
            ;; guard clause
            (and (list? pattern) (sym? (. pattern 2) :?))
            (do
              (assert-compile opts.legacy-guard-allowed? "legacy guard clause not supported in case" pattern)
              (case-guard vals (. pattern 1) [(unpack pattern 3)] unifications case-pattern opts))
            ;; multi-valued patterns (represented as lists)
            (list? pattern)
            (do
              (assert-compile opts.multival? "can't nest multi-value destructuring" pattern)
              (case-values vals pattern unifications case-pattern opts))
            ;; table patterns
            (= (type pattern) :table)
            (case-table val pattern unifications case-pattern opts ?top)
            ;; literal value
            (values `(= ,val ,pattern) []))))
    
    (fn add-pre-bindings [out pre-bindings]
      "Decide when to switch from the current `if` AST to a new one"
      (if pre-bindings
          ;; `out` no longer needs to grow.
          ;; Instead, a new tail `if` AST is introduced, which is where the rest of
          ;; the clauses will get appended. This way, all future clauses have the
          ;; pre-bindings in scope.
          (let [tail `(if)]
            (table.insert out true)
            (table.insert out `(let ,pre-bindings ,tail))
            tail)
          ;; otherwise, keep growing the current `if` AST.
          out))
    
    (fn case-condition [vals clauses match? top-table?]
      "Construct the actual `if` AST for the given match values and clauses."
      ;; root is the original `if` AST.
      ;; out is the `if` AST that is currently being grown.
      (let [root `(if)]
        (faccumulate [out root
                      i 1 (length clauses) 2]
          (let [pattern (. clauses i)
                body (. clauses (+ i 1))
                (condition bindings pre-bindings) (case-pattern vals pattern {}
                                                                {:multival? true
                                                                 :infer-unification? match?
                                                                 :legacy-guard-allowed? match?}
                                                                (if top-table? :table true))
                out (add-pre-bindings out pre-bindings)]
            ;; grow the `if` AST by one extra condition
            (table.insert out condition)
            (table.insert out `(let ,bindings ,body))
            out))
        root))
    
    (fn count-case-multival [pattern]
      "Identify the amount of multival values that a pattern requires."
      (if (and (list? pattern) (sym? (. pattern 2) :?))
          (count-case-multival (. pattern 1))
          (and (list? pattern) (sym? (. pattern 1) :where))
          (count-case-multival (. pattern 2))
          (and (list? pattern) (sym? (. pattern 1) :or))
          (accumulate [longest 0
                       _ child-pattern (ipairs pattern)]
            (math.max longest (count-case-multival child-pattern)))
          (list? pattern)
          (length pattern)
          1))
    
    (fn case-count-syms [clauses]
      "Find the length of the largest multi-valued clause"
      (let [patterns (fcollect [i 1 (length clauses) 2]
                       (. clauses i))]
        (accumulate [longest 0
                     _ pattern (ipairs patterns)]
          (math.max longest (count-case-multival pattern)))))
    
    (fn maybe-optimize-table [val clauses]
      (if (faccumulate [all (sequence? val) i 1 (length clauses) 2 &until (not all)]
            (and (sequence? (. clauses i))
                 (accumulate [all2 (next (. clauses i))
                              _ d (ipairs (. clauses i)) &until (not all2)]
                   (and all2 (or (not (sym? d)) (not (: (tostring d) :find "^&")))))))
          (values `(values ,(unpack val))
                  (fcollect [i 1 (length clauses)]
                    (if (= 1 (% i 2))
                        (list (unpack (. clauses i)))
                        (. clauses i))))
          (values val clauses)))
    
    (fn case-impl [match? init-val ...]
      "The shared implementation of case and match."
      (assert (not= init-val nil) "missing subject")
      (assert (= 0 (math.fmod (select :# ...) 2))
              "expected even number of pattern/body pairs")
      (assert (not= 0 (select :# ...))
              "expected at least one pattern/body pair")
      (let [(val clauses) (maybe-optimize-table init-val [...])
            vals-count (case-count-syms clauses)
            skips-multiple-eval-protection? (and (= vals-count 1) (double-eval-safe? val))]
        (if skips-multiple-eval-protection?
          (case-condition (list val) clauses match? (table? init-val))
          ;; protect against multiple evaluation of the value, bind against as
          ;; many values as we ever match against in the clauses.
          (let [vals (fcollect [_ 1 vals-count &into (list)] (gensym))]
            (list `let [vals val] (case-condition vals clauses match? (table? init-val)))))))
    
    (fn case* [val ...]
      "Perform pattern matching on val. See reference for details.
    
    Syntax:
    
    (case data-expression
      pattern body
      (where pattern guards*) body
      (where (or pattern patterns*) guards*) body)"
      (case-impl false val ...))
    
    (fn match* [val ...]
      "Perform pattern matching on val, automatically unifying on variables in
    local scope. See reference for details.
    
    Syntax:
    
    (match data-expression
      pattern body
      (where pattern guards*) body
      (where (or pattern patterns*) guards*) body)"
      (case-impl true val ...))
    
    (fn case-try-step [how expr else pattern body ...]
      (if (= nil pattern body)
          expr
          ;; unlike regular match, we can't know how many values the value
          ;; might evaluate to, so we have to capture them all in ... via IIFE
          ;; to avoid double-evaluation.
          `((fn [...]
              (,how ...
                ,pattern ,(case-try-step how body else ...)
                ,(unpack else)))
            ,expr)))
    
    (fn case-try-impl [how expr pattern body ...]
      (let [clauses [pattern body ...]
            last (. clauses (length clauses))
            catch (if (sym? (and (= :table (type last)) (. last 1)) :catch)
                     (let [[_ & e] (table.remove clauses)] e) ; remove `catch sym
                     [`_# `...])]
        (assert (= 0 (math.fmod (length clauses) 2))
                "expected every pattern to have a body")
        (assert (= 0 (math.fmod (length catch) 2))
                "expected every catch pattern to have a body")
        (case-try-step how expr catch (unpack clauses))))
    
    (fn case-try* [expr pattern body ...]
      "Perform chained pattern matching for a sequence of steps which might fail.
    
    The values from the initial expression are matched against the first pattern.
    If they match, the first body is evaluated and its values are matched against
    the second pattern, etc.
    
    If there is a (catch pat1 body1 pat2 body2 ...) form at the end, any mismatch
    from the steps will be tried against these patterns in sequence as a fallback
    just like a normal match. If there is no catch, the mismatched values will be
    returned as the value of the entire expression."
      (case-try-impl `case expr pattern body ...))
    
    (fn match-try* [expr pattern body ...]
      "Perform chained pattern matching for a sequence of steps which might fail.
    
    The values from the initial expression are matched against the first pattern.
    If they match, the first body is evaluated and its values are matched against
    the second pattern, etc.
    
    If there is a (catch pat1 body1 pat2 body2 ...) form at the end, any mismatch
    from the steps will be tried against these patterns in sequence as a fallback
    just like a normal match. If there is no catch, the mismatched values will be
    returned as the value of the entire expression."
      (case-try-impl `match expr pattern body ...))
    
    {:case case*
     :case-try case-try*
     :match match*
     :match-try match-try*}
    ]===], {allowedGlobals = false, env = env, filename = "src/fennel/match.fnl", moduleName = module_name, scope = compiler.scopes.compiler, useMetadata = true})
    for k, v in pairs(match_macros) do
      compiler.scopes.global.macros[k] = v
    end
    package.preload[module_name] = nil
  end
  return mod
end
package.preload["emacs"] = package.preload["emacs"] or function(...)
  local function emacsclient_exe()
    return hs.application.find("Emacs"):path():gsub("Emacs.app", "bin/emacsclient")
  end
  local function capture(is_note)
    local key
    if is_note then
      key = "\"z\""
    else
      key = ""
    end
    local current_app = hs.window.focusedWindow()
    local pid = ("\"" .. current_app:pid() .. "\" ")
    local title = ("\"" .. current_app:title() .. "\" ")
    local run_str = (emacsclient_exe() .. " -c -F '(quote (name . \"capture\"))'" .. " -e '(spacehammer-activate-capture-frame " .. pid .. title .. key .. " )' &")
    local timer
    local function _1044_()
      return io.popen(run_str)
    end
    timer = hs.timer.delayed.new(0.1, _1044_)
    return timer:start()
  end
  local function edit_with_emacs()
    local current_app = hs.window.focusedWindow():application()
    local pid = ("\"" .. current_app:pid() .. "\"")
    local title = ("\"" .. current_app:title() .. "\"")
    local screen = ("\"" .. hs.screen.mainScreen():id() .. "\"")
    local run_str = (emacsclient_exe() .. " -e '(spacehammer-edit-with-emacs " .. pid .. " " .. title .. " " .. screen .. " )' &")
    local prev = hs.pasteboard.changeCount()
    local _ = hs.eventtap.keyStroke({"cmd"}, "c")
    local next = hs.pasteboard.changeCount()
    if (prev == next) then
      hs.eventtap.keyStroke({"cmd"}, "a")
      hs.eventtap.keyStroke({"cmd"}, "c")
    else
    end
    io.popen(run_str)
    return hs.application.open("Emacs")
  end
  local function run_emacs_fn(elisp_fn, args)
    local args_lst
    if args then
      args_lst = (" '" .. table.concat(args, " '"))
    else
      args_lst = nil
    end
    local run_str
    local _1047_
    if args_lst then
      _1047_ = args_lst
    else
      _1047_ = " &"
    end
    run_str = (emacsclient_exe() .. " -e \"(funcall '" .. elisp_fn .. _1047_ .. ")\" &")
    return io.popen(run_str)
  end
  local function full_screen()
    hs.application.launchOrFocus("Emacs")
    return run_emacs_fn(("(lambda ())" .. "(spacemacs/toggle-fullscreen-frame-on)" .. "(spacehammer/fix-frame)"))
  end
  local function vertical_split_with_emacs()
    local windows = require("windows")
    local cur_app
    do
      local tmp_3_auto = hs.window.focusedWindow()
      if (nil ~= tmp_3_auto) then
        local tmp_3_auto0 = tmp_3_auto:application()
        if (nil ~= tmp_3_auto0) then
          cur_app = tmp_3_auto0:name()
        else
          cur_app = nil
        end
      else
        cur_app = nil
      end
    end
    local rect_left = {0, 0, 0.5, 1}
    local rect_right = {0.5, 0, 0.5, 1}
    local elisp = ("(lambda ()" .. " (spacemacs/toggle-fullscreen-frame-off) " .. " (spacemacs/maximize-horizontally) " .. " (spacemacs/maximize-vertically))")
    run_emacs_fn(elisp)
    local function _1051_()
      if (cur_app == "Emacs") then
        windows.rect(rect_left)
        windows["jump-to-last-window"]()
        return windows.rect(rect_right)
      else
        windows.rect(rect_right)
        hs.application.launchOrFocus("Emacs")
        return windows.rect(rect_left)
      end
    end
    return hs.timer.doAfter(0.2, _1051_)
  end
  local function switch_to_app(pid)
    local app = hs.application.applicationForPID(tonumber(pid))
    if app then
      return app:activate()
    else
      return nil
    end
  end
  local function switch_to_app_and_paste_from_clipboard(pid)
    local app = hs.application.applicationForPID(tonumber(pid))
    if app then
      app:activate()
      local function _1054_()
        return app:selectMenuItem({"Edit", "Paste"})
      end
      return hs.timer.doAfter(0.001, _1054_)
    else
      return nil
    end
  end
  local function maximize()
    local function _1056_()
      local app = hs.application.find("Emacs")
      local windows = require("windows")
      local modal = require("lib.modal")
      if app then
        app:activate()
        return windows["maximize-window-frame"]()
      else
        return nil
      end
    end
    return hs.timer.doAfter(1.5, _1056_)
  end
  local function _1148_()
    return capture(true)
  end
  return {capture = capture, ["edit-with-emacs"] = edit_with_emacs, ["full-screen"] = full_screen, maximize = maximize, note = _1148_, switchToApp = switch_to_app, switchToAppAndPasteFromClipboard = switch_to_app_and_paste_from_clipboard, ["vertical-split-with-emacs"] = vertical_split_with_emacs, ["run-emacs-fn"] = run_emacs_fn}
end
package.preload["lib.modal"] = package.preload["lib.modal"] or function(...)
  local atom = require("lib.atom")
  local statemachine = require("lib.statemachine")
  local apps = require("lib.apps")
  local _local_1108_ = require("lib.functional")
  local butlast = _local_1108_["butlast"]
  local call_when = _local_1108_["call-when"]
  local concat = _local_1108_["concat"]
  local conj = _local_1108_["conj"]
  local find = _local_1108_["find"]
  local filter = _local_1108_["filter"]
  local has_some_3f = _local_1108_["has-some?"]
  local identity = _local_1108_["identity"]
  local join = _local_1108_["join"]
  local map = _local_1108_["map"]
  local merge = _local_1108_["merge"]
  local _local_1114_ = require("lib.text")
  local align_columns = _local_1114_["align-columns"]
  local _local_1115_ = require("lib.bind")
  local action__3efn = _local_1115_["action->fn"]
  local bind_keys = _local_1115_["bind-keys"]
  local lifecycle = require("lib.lifecycle")
  local log = hs.logger.new("modal.fnl", "debug")
  local fsm = nil
  local default_style = {textFont = "Menlo", textSize = 16, radius = 0, strokeWidth = 0}
  local style = {}
  local function timeout(f)
    local task = hs.timer.doAfter(2, f)
    local function destroy_task()
      if task then
        task:stop()
        return nil
      else
        return nil
      end
    end
    return destroy_task
  end
  local function activate_modal(menu_key)
    return fsm.send("activate", menu_key)
  end
  local function enter_modal(menu_key)
    return fsm.send("enter", menu_key)
  end
  local function deactivate_modal()
    return fsm.send("deactivate")
  end
  local function previous_modal()
    return fsm.send("previous")
  end
  local function start_modal_timeout()
    return fsm.send("start-timeout")
  end
  local function create_action_trigger(_1117_)
    local action = _1117_["action"]
    local repeatable = _1117_["repeatable"]
    local timeout0 = _1117_["timeout"]
    local action_fn = action__3efn(action)
    local function _1118_()
      if (repeatable and (timeout0 ~= false)) then
        start_modal_timeout()
      elseif not repeatable then
        deactivate_modal()
      else
      end
      return hs.timer.doAfter(0.01, action_fn)
    end
    return _1118_
  end
  local function create_menu_trigger(_1120_)
    local key = _1120_["key"]
    local function _1121_()
      return enter_modal(key)
    end
    return _1121_
  end
  local function select_trigger(item)
    if (item.action and (item.action == "previous")) then
      return previous_modal
    elseif item.action then
      return create_action_trigger(item)
    elseif item.items then
      return create_menu_trigger(item)
    else
      local function _1122_()
        return log.w("No trigger could be found for item: ", hs.inspect(item))
      end
      return _1122_
    end
  end
  local function bind_item(item)
    return {mods = (item.mods or {}), key = item.key, action = select_trigger(item)}
  end
  local function bind_menu_keys(items)
    local function _1124_(item)
      return (item.action or item.items)
    end
    return bind_keys(concat(map(bind_item, filter(_1124_, items)), {{key = "ESCAPE", action = deactivate_modal}, {mods = {"ctrl"}, key = "[", action = deactivate_modal}}))
  end
  local mod_chars = {cmd = "CMD", alt = "OPT", shift = "SHFT", tab = "TAB"}
  local function format_key(item)
    local mods
    do
      local tmp_6_auto = item.mods
      if (tmp_6_auto ~= nil) then
        local tmp_6_auto0
        local function _1125_(m)
          return (mod_chars[m] or m)
        end
        tmp_6_auto0 = map(_1125_, tmp_6_auto)
        if (tmp_6_auto0 ~= nil) then
          local tmp_6_auto1 = join(" ", tmp_6_auto0)
          if (tmp_6_auto1 ~= nil) then
            mods = identity(tmp_6_auto1)
          else
            mods = nil
          end
        else
          mods = nil
        end
      else
        mods = nil
      end
    end
    local _1129_
    if mods then
      _1129_ = " + "
    else
      _1129_ = ""
    end
    return ((mods or "") .. _1129_ .. item.key)
  end
  local function modal_alert(menu)
    local items
    local function _1131_(item)
      return {format_key(item), item.title}
    end
    local function _1132_(item)
      return item.title
    end
    items = align_columns(map(_1131_, filter(_1132_, menu.items)))
    local text = join("\n", items)
    hs.alert.closeAll()
    return hs.alert(text, style, hs.screen.mainScreen(), true)
  end
  local function show_modal_menu(state)
    lifecycle["enter-menu"](state.context.menu)
    modal_alert(state.context.menu)
    local unbind_keys = bind_menu_keys(state.context.menu.items)
    local stop_timeout = state.context["stop-timeout"]
    local function _1133_()
      hs.alert.closeAll(0)
      unbind_keys()
      call_when(stop_timeout)
      return lifecycle["exit-menu"](state.context.menu)
    end
    return _1133_
  end
  local function by_key(target)
    local function _1134_(item)
      return ((item.key == target) and has_some_3f(item.items))
    end
    return _1134_
  end
  local function __3emenu(state, action, menu_key)
    local config = state.context["config"]
    local prev_menu = state.context["menu"]
    local app_menu = apps["get-app"]()
    local menu
    if menu_key then
      menu = find(by_key(menu_key), prev_menu.items)
    else
      if (app_menu and has_some_3f(app_menu.items)) then
        menu = app_menu
      else
        menu = config
      end
    end
    return {state = {["current-state"] = "active", context = merge(state.context, {menu = menu})}, effect = "open-menu"}
  end
  local function active__3eidle(state, action, extra)
    return {state = {["current-state"] = "idle", context = merge(state.context, {menu = "nil", history = {}})}, effect = "close-modal-menu"}
  end
  local function __3eenter_app(state, action, extra)
    local config = state.context["config"]
    local prev_menu = state.context["menu"]
    local app_menu = apps["get-app"]()
    local menu
    if (app_menu and has_some_3f(app_menu.items)) then
      menu = app_menu
    else
      menu = config
    end
    if (menu.key == prev_menu.key) then
      return nil
    else
      return {state = {["current-state"] = "active", context = merge(state.context, {menu = menu})}, effect = "open-menu"}
    end
  end
  local function active__3eleave_app(state, action, extra)
    local config = state.context["config"]
    local prev_menu = state.context["menu"]
    if (prev_menu.key == config.key) then
      return nil
    else
      return __3emenu(state)
    end
  end
  local function add_timeout_transition(state, action, extra)
    return {state = {["current-state"] = state["current-state"], context = merge(state.context, {["stop-timeout"] = timeout(deactivate_modal)})}, effect = "open-menu"}
  end
  local function __3eprevious(state, action, extra)
    local config = state.context["config"]
    local hist = state.context["history"]
    local menu = state.context["menu"]
    local prev_menu = hist[(#hist - 1)]
    if prev_menu then
      return {state = {["current-state"] = "active", context = merge(state.context, {menu = prev_menu, history = butlast(hist)})}, effect = "open-menu"}
    else
      return __3emenu(state)
    end
  end
  local states = {idle = {activate = __3emenu}, active = {deactivate = active__3eidle, enter = __3emenu, ["start-timeout"] = add_timeout_transition, previous = __3eprevious, ["enter-app"] = __3eenter_app}}
  local function start_logger(fsm0)
    local function log_state(state)
      if state.context.history then
        local function _1141_(_241)
          return _241.title
        end
        return log.df(hs.inspect(map(_1141_, state.context.history)))
      else
        return nil
      end
    end
    return atom["add-watch"](fsm0.state, "log-state", log_state)
  end
  local modal_effect = statemachine["effect-handler"]({["open-menu"] = show_modal_menu})
  local function proxy_app_action(_1143_)
    local action = _1143_[1]
    local data = _1143_[2]
    return fsm.send(action, data)
  end
  local function init(config)
    local initial_context = {config = config, history = {}, menu = "nil"}
    local template = {state = {["current-state"] = "idle", context = initial_context}, states = states, log = "modal"}
    local unsubscribe = apps.subscribe(proxy_app_action)
    local function _1145_()
      local t_1144_ = config
      if (nil ~= t_1144_) then
        t_1144_ = t_1144_["modal-style"]
      else
      end
      return t_1144_
    end
    style = merge(default_style, _1145_())
    fsm = statemachine.new(template)
    fsm.subscribe(modal_effect)
    start_logger(fsm)
    local function cleanup()
      return unsubscribe()
    end
    return cleanup
  end
  return {init = init, ["activate-modal"] = activate_modal}
end
package.preload["lib.statemachine"] = package.preload["lib.statemachine"] or function(...)
  local atom = require("lib.atom")
  local _local_1057_ = require("lib.functional")
  local butlast = _local_1057_["butlast"]
  local call_when = _local_1057_["call-when"]
  local concat = _local_1057_["concat"]
  local conj = _local_1057_["conj"]
  local last = _local_1057_["last"]
  local merge = _local_1057_["merge"]
  local slice = _local_1057_["slice"]
  local function update_state(fsm, state)
    return atom["reset!"](fsm.state, state)
  end
  local function get_transition_function(fsm, current_state, action)
    return fsm.states[current_state][action]
  end
  local function get_state(fsm)
    return atom.deref(fsm.state)
  end
  local function send(fsm, action, extra)
    local state = get_state(fsm)
    local current_state = state["current-state"]
    local context = state["context"]
    local tx_fn = get_transition_function(fsm, current_state, action)
    if tx_fn then
      local transition = tx_fn(state, action, extra)
      local new_state
      if transition then
        new_state = transition.state
      else
        new_state = state
      end
      local effect
      if transition then
        effect = transition.effect
      else
        effect = nil
      end
      update_state(fsm, new_state)
      for _, sub in pairs(atom.deref(fsm.subscribers)) do
        sub({["prev-state"] = state, ["next-state"] = new_state, action = action, effect = effect, extra = extra})
      end
      return true
    else
      return false
    end
  end
  local function subscribe(fsm, sub)
    local sub_key = tostring(sub)
    local function _1061_(subs, sub0)
      return merge({[sub_key] = sub0}, subs)
    end
    atom["swap!"](fsm.subscribers, _1061_, sub)
    local function _1062_()
      local function _1063_(subs, key)
        subs[key] = nil
        return subs
      end
      return atom["swap!"](fsm.subscribers, _1063_, sub_key)
    end
    return _1062_
  end
  local function effect_handler(effect_map)
    local cleanup_ref = atom.new(nil)
    local function _1065_(_1064_)
      local prev_state = _1064_["prev-state"]
      local next_state = _1064_["next-state"]
      local action = _1064_["action"]
      local effect = _1064_["effect"]
      local extra = _1064_["extra"]
      call_when(atom.deref(cleanup_ref))
      return atom["reset!"](cleanup_ref, call_when(effect_map[effect], next_state, extra))
    end
    return _1065_
  end
  local function create_machine(template)
    local state = atom.new({["current-state"] = template.state["current-state"], context = template.state.context})
    local fsm
    local _1066_
    if template.log then
      _1066_ = hs.logger.new(template.log, "info")
    else
      _1066_ = nil
    end
    fsm = {state = state, states = template.states, subscribers = atom.new({}), log = _1066_}
    fsm["get-state"] = function()
      return get_state(fsm)
    end
    fsm.send = function(...)
      return send(fsm, ...)
    end
    fsm.subscribe = function(sub)
      return subscribe(fsm, sub)
    end
    return fsm
  end
  return {["effect-handler"] = effect_handler, send = send, subscribe = subscribe, new = create_machine}
end
package.preload["lib.apps"] = package.preload["lib.apps"] or function(...)
  local atom = require("lib.atom")
  local statemachine = require("lib.statemachine")
  local os = require("os")
  local _local_1068_ = require("lib.functional")
  local call_when = _local_1068_["call-when"]
  local find = _local_1068_["find"]
  local merge = _local_1068_["merge"]
  local noop = _local_1068_["noop"]
  local tap = _local_1068_["tap"]
  local _local_1079_ = require("lib.bind")
  local action__3efn = _local_1079_["action->fn"]
  local bind_keys = _local_1079_["bind-keys"]
  local lifecycle = require("lib.lifecycle")
  local actions = atom.new(nil)
  local fsm = nil
  local function gen_key()
    local random_base64_str = hs.base64.encode(string.format("%07d", math.random(10000000)))
    return string.sub(random_base64_str, 1, 7)
  end
  local function emit(action, data)
    return atom["reset!"](actions, {action, data})
  end
  local function enter(app_name)
    return fsm.send("enter-app", app_name)
  end
  local function leave(app_name)
    return fsm.send("leave-app", app_name)
  end
  local function launch(app_name)
    return fsm.send("launch-app", app_name)
  end
  local function close(app_name)
    return fsm.send("close-app", app_name)
  end
  local function by_key(target)
    local function _1089_(_241)
      return (_241.key == target)
    end
    return _1089_
  end
  local function __3eenter(state, action, app_name)
    local apps = state.context["apps"]
    local app = state.context["app"]
    local next_app = find(by_key(app_name), apps)
    return {state = {["current-state"] = "in-app", context = {apps = apps, app = next_app, ["prev-app"] = app}}, effect = "enter-app-effect"}
  end
  local function in_app__3eleave(state, action, app_name)
    return {state = state, effect = "leave-app-effect"}
  end
  local function launch_app(state, action, app_name)
    local apps = state.context["apps"]
    local app = state.context["app"]
    local next_app = find(by_key(app_name), apps)
    return {state = {["current-state"] = "in-app", context = {apps = apps, app = next_app, ["prev-app"] = app}}, effect = "launch-app-effect"}
  end
  local function __3eclose(state, action, app_name)
    return {state = state, effect = "close-app-effect"}
  end
  local app_events = {[hs.application.watcher.activated] = "activated", [hs.application.watcher.deactivated] = "deactivated", [hs.application.watcher.hidden] = "hidden", [hs.application.watcher.launched] = "launched", [hs.application.watcher.launching] = "launching", [hs.application.watcher.terminated] = "terminated", [hs.application.watcher.unhidden] = "unhidden"}
  local function watch_apps(app_name, event, app)
    local event_type = app_events[event]
    if (event_type == "activated") then
      return enter(app_name)
    elseif (event_type == "deactivated") then
      return leave(app_name)
    elseif (event_type == "launched") then
      return launch(app_name)
    elseif (event_type == "terminated") then
      return close(app_name)
    else
      return nil
    end
  end
  local function active_app_name()
    local app = hs.application.frontmostApplication()
    if app then
      return app:name()
    else
      return nil
    end
  end
  local function watch_actions(_1092_)
    local prev_state = _1092_["prev-state"]
    local next_state = _1092_["next-state"]
    local action = _1092_["action"]
    local effect = _1092_["effect"]
    local extra = _1092_["extra"]
    return emit(action, next_state.context.app)
  end
  local function get_app()
    if fsm then
      local state = fsm["get-state"]()
      return state.context.app
    else
      return nil
    end
  end
  local function subscribe(f)
    local key = gen_key()
    atom["add-watch"](actions, key, f)
    local function _1094_()
      return atom["remove-watch"](actions, key)
    end
    return _1094_
  end
  local function enter_app_effect(context)
    if context.app then
      lifecycle["activate-app"](context.app)
      local unbind_keys = bind_keys(context.app.keys)
      local function _1095_()
        return unbind_keys()
      end
      return _1095_
    else
      return nil
    end
  end
  local function launch_app_effect(context)
    if context.app then
      lifecycle["launch-app"](context.app)
      local unbind_keys = bind_keys(context.app.keys)
      local function _1097_()
        return unbind_keys()
      end
      return _1097_
    else
      return nil
    end
  end
  local function app_effect_handler(effect_map)
    local cleanup_ref = atom.new({})
    local function _1100_(_1099_)
      local prev_state = _1099_["prev-state"]
      local next_state = _1099_["next-state"]
      local action = _1099_["action"]
      local effect = _1099_["effect"]
      local extra = _1099_["extra"]
      call_when(atom.deref(cleanup_ref)[extra])
      local cleanup_map = atom.deref(cleanup_ref)
      local effect_func = effect_map[effect]
      return atom["reset!"](cleanup_ref, merge(cleanup_map, {[extra] = call_when(effect_func, next_state, extra)}))
    end
    return _1100_
  end
  local apps_effect
  local function _1101_(_241)
    return enter_app_effect(_241.context)
  end
  local function _1102_(_241)
    do
      local tmp_3_auto = _241.context["prev-app"]
      if (nil ~= tmp_3_auto) then
        lifecycle["deactivate-app"](tmp_3_auto)
      else
      end
    end
    return nil
  end
  local function _1104_(_241)
    return launch_app_effect(_241.context)
  end
  local function _1105_(_241)
    do
      local tmp_3_auto = _241.context["prev-app"]
      if (nil ~= tmp_3_auto) then
        lifecycle["close-app"](tmp_3_auto)
      else
      end
    end
    return nil
  end
  apps_effect = app_effect_handler({["enter-app-effect"] = _1101_, ["leave-app-effect"] = _1102_, ["launch-app-effect"] = _1104_, ["close-app-effect"] = _1105_})
  local function init(config)
    local active_app = active_app_name()
    local initial_context = {apps = config.apps, app = nil}
    local template = {state = {["current-state"] = "general-app", context = initial_context}, states = {["general-app"] = {["enter-app"] = __3eenter, ["leave-app"] = noop, ["launch-app"] = launch_app, ["close-app"] = __3eclose}, ["in-app"] = {["enter-app"] = __3eenter, ["leave-app"] = in_app__3eleave, ["launch-app"] = launch_app, ["close-app"] = __3eclose}}, log = "apps"}
    local app_watcher = hs.application.watcher.new(watch_apps)
    fsm = statemachine.new(template)
    fsm.subscribe(apps_effect)
    fsm.subscribe(watch_actions)
    fsm.send("enter-app", active_app)
    app_watcher:start()
    local function _1107_()
      return app_watcher:stop()
    end
    return _1107_
  end
  return {init = init, ["get-app"] = get_app, subscribe = subscribe}
end
package.preload["lib.bind"] = package.preload["lib.bind"] or function(...)
  local _local_1069_ = require("lib.functional")
  local contains_3f = _local_1069_["contains?"]
  local map = _local_1069_["map"]
  local split = _local_1069_["split"]
  local log = hs.logger.new("bind.fnl", "debug")
  local function do_action(action, args)
    local _let_1070_ = split(":", action)
    local file = _let_1070_[1]
    local fn_name = _let_1070_[2]
    local module = require(file)
    local f = module[fn_name]
    if f then
      return f(table.unpack((args or {})))
    else
      return log.wf("Could not dispatch action %s: Function \"%s\" was not found in module \"%s\".\nEnsure the correct action is referenced in config.fnl.", action, fn_name, file)
    end
  end
  local function create_action_fn(action)
    local function _1072_(...)
      return do_action(action, {...})
    end
    return _1072_
  end
  local function action__3efn(action)
    local _1073_ = type(action)
    if (_1073_ == "function") then
      return action
    elseif (_1073_ == "string") then
      return create_action_fn(action)
    else
      local _ = _1073_
      log.wf("Could not create action handler for %s", hs.inspect(action))
      local function _1074_()
        return true
      end
      return _1074_
    end
  end
  local function bind_keys(items)
    local modal = hs.hotkey.modal.new({}, nil)
    for _, item in ipairs(items) do
      local key = item["key"]
      local mods = item["mods"]
      local action = item["action"]
      local _repeat = item["repeat"]
      local mods0 = (mods or {})
      local action_fn = action__3efn(action)
      if _repeat then
        modal:bind(mods0, key, action_fn, nil, action_fn)
      else
        modal:bind(mods0, key, nil, action_fn)
      end
    end
    modal:enter()
    local function destroy_bindings()
      if modal then
        modal:exit()
        return modal:delete()
      else
        return nil
      end
    end
    return destroy_bindings
  end
  local function bind_global_keys(items)
    local function _1078_(item)
      local key = item["key"]
      local mods = (item.mods or {})
      local action_fn = action__3efn(item.action)
      local binding = hs.hotkey.bind(mods, key, action_fn)
      local function unbind()
        return binding:delete()
      end
      return unbind
    end
    return map(_1078_, items)
  end
  local function unbind_global_keys(bindings)
    for _, unbind in ipairs(bindings) do
      unbind()
    end
    return nil
  end
  local function init(config)
    local keys = (config.keys or {})
    local bindings = bind_global_keys(keys)
    local function cleanup()
      return unbind_global_keys(bindings)
    end
    return cleanup
  end
  return {init = init, ["action->fn"] = action__3efn, ["bind-keys"] = bind_keys, ["do-action"] = do_action}
end
package.preload["lib.lifecycle"] = package.preload["lib.lifecycle"] or function(...)
  local _local_1080_ = require("lib.bind")
  local do_action = _local_1080_["do-action"]
  local log = hs.logger.new("lifecycle.fnl", "debug")
  local function do_method(obj, method_name)
    local method = obj[method_name]
    local _1081_ = type(method)
    if (_1081_ == "function") then
      return method(obj)
    elseif (_1081_ == "string") then
      return do_action(method, {obj})
    else
      local _ = _1081_
      return log.wf("Could not call lifecycle method %s on %s", method_name, obj)
    end
  end
  local function activate_app(menu)
    if (menu and menu.activate) then
      return do_method(menu, "activate")
    else
      return nil
    end
  end
  local function close_app(menu)
    if (menu and menu.close) then
      return do_method(menu, "close")
    else
      return nil
    end
  end
  local function deactivate_app(menu)
    if (menu and menu.deactivate) then
      return do_method(menu, "deactivate")
    else
      return nil
    end
  end
  local function enter_menu(menu)
    if (menu and menu.enter) then
      return do_method(menu, "enter")
    else
      return nil
    end
  end
  local function exit_menu(menu)
    if (menu and menu.exit) then
      return do_method(menu, "exit")
    else
      return nil
    end
  end
  local function launch_app(menu)
    if (menu and menu.launch) then
      return do_method(menu, "launch")
    else
      return nil
    end
  end
  return {["activate-app"] = activate_app, ["close-app"] = close_app, ["deactivate-app"] = deactivate_app, ["enter-menu"] = enter_menu, ["exit-menu"] = exit_menu, ["launch-app"] = launch_app}
end
package.preload["lib.text"] = package.preload["lib.text"] or function(...)
  local _local_1109_ = require("lib.functional")
  local map = _local_1109_["map"]
  local reduce = _local_1109_["reduce"]
  local function max_length(items)
    local function _1111_(max, _1110_)
      local key = _1110_[1]
      local _ = _1110_[2]
      return math.max(max, #key)
    end
    return reduce(_1111_, 0, items)
  end
  local function pad_str(char, max, str)
    local diff = (max - #str)
    return (str .. string.rep(char, diff))
  end
  local function align_columns(items)
    local max = max_length(items)
    local function _1113_(_1112_)
      local key = _1112_[1]
      local action = _1112_[2]
      return (pad_str(" ", max, key) .. "     " .. action)
    end
    return map(_1113_, items)
  end
  return {["align-columns"] = align_columns}
end
package.preload["slack"] = package.preload["slack"] or function(...)
  local windows = require("windows")
  local function scroll_to_bottom()
    windows["set-mouse-cursor-at"]("Slack")
    return hs.eventtap.scrollWheel({0, -20000}, {})
  end
  local function add_reaction()
    return hs.eventtap.keyStroke({"cmd", "shift"}, "\\")
  end
  local function prev_element()
    return hs.eventtap.keyStroke({"shift"}, "f6")
  end
  local function next_element()
    return hs.eventtap.keyStroke(nil, "f6")
  end
  local function thread()
    hs.eventtap.keyStroke({"shift"}, "f6")
    hs.eventtap.keyStroke({}, "right")
    return hs.eventtap.keyStroke({}, "space")
  end
  local function quick_switcher()
    windows["activate-app"]("/Applications/Slack.app")
    local app = hs.application.find("Slack")
    if app then
      hs.eventtap.keyStroke({"cmd"}, "t")
      return app:unhide()
    else
      return nil
    end
  end
  local function prev_day()
    return hs.eventtap.keyStroke({"shift"}, "pageup")
  end
  local function next_day()
    return hs.eventtap.keyStroke({"shift"}, "pagedown")
  end
  local function scroll_slack(dir)
    windows["set-mouse-cursor-at"]("Slack")
    return hs.eventtap.scrollWheel({0, dir}, {})
  end
  local function scroll_up()
    return scroll_slack(3)
  end
  local function scroll_down()
    return scroll_slack(-3)
  end
  local function prev_history()
    return hs.eventtap.keyStroke({"cmd"}, "[")
  end
  local function next_history()
    return hs.eventtap.keyStroke({"cmd"}, "]")
  end
  local function up()
    return hs.eventtap.keyStroke(nil, "up")
  end
  local function down()
    return hs.eventtap.keyStroke(nil, "down")
  end
  return {["add-reaction"] = add_reaction, down = down, ["next-day"] = next_day, ["next-element"] = next_element, ["next-history"] = next_history, ["prev-day"] = prev_day, ["prev-element"] = prev_element, ["prev-history"] = prev_history, ["quick-switcher"] = quick_switcher, ["scroll-down"] = scroll_down, ["scroll-to-bottom"] = scroll_to_bottom, ["scroll-up"] = scroll_up, thread = thread, up = up}
end
package.preload["spoons"] = package.preload["spoons"] or function(...)
  local function _1150_()
    return "#<namespace: spoons>"
  end
  local _local_1151_ = {setmetatable({}, {__fennelview = _1150_, __name = "namespace"}), require("cljlib"), require("lib.atom"), require("fennel")}
  local spoons = _local_1151_[1]
  local _local_1152_ = _local_1151_[2]
  local contains_3f = _local_1152_["contains?"]
  local _local_1153_ = _local_1151_[3]
  local atom = _local_1153_["atom"]
  local deref = _local_1153_["deref"]
  local update_21 = _local_1153_["update!"]
  local fnl = _local_1151_[4]
  local loaded_spoons
  do
    local v_27_auto
    do
      local tbl_21_auto = {}
      local i_22_auto = 0
      for i, spoon in ipairs(hs.spoons.list()) do
        local val_23_auto = spoon.name
        if (nil ~= val_23_auto) then
          i_22_auto = (i_22_auto + 1)
          tbl_21_auto[i_22_auto] = val_23_auto
        else
        end
      end
      v_27_auto = tbl_21_auto
    end
    spoons["loaded-spoons"] = v_27_auto
    loaded_spoons = v_27_auto
  end
  local trim
  do
    local v_27_auto
    local function trim0(...)
      local s = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "trim"))
        else
        end
      end
      return s:gsub("^%s+", ""):gsub("%s+$", "")
    end
    v_27_auto = trim0
    spoons["trim"] = v_27_auto
    trim = v_27_auto
  end
  local exec
  do
    local v_27_auto
    local function exec0(...)
      local core_38_auto = require("cljlib")
      local _let_1156_ = core_38_auto.list(...)
      local rst = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_1156_, 1)
      return hs.execute(table.concat(rst, " "), true)
    end
    v_27_auto = exec0
    spoons["exec"] = v_27_auto
    exec = v_27_auto
  end
  if not contains_3f(loaded_spoons, "SpoonInstall") then
    local tmpdir1 = exec("mktemp -d")
    local tmpdir = trim(tmpdir1)
    local outfile = (tmpdir .. "/SpoonInstall.spoon.zip")
    local spoonfile = (tmpdir .. "/SpoonInstall.spoon")
    exec("curl -fsSL https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip -o", outfile)
    exec("cd", tmpdir, ";", "unzip SpoonInstall.spoon.zip -d ~/.hammerspoon/Spoons/")
    exec("ls -la ", tmpdir)
    exec("rm -rf ", tmpdir)
  else
  end
  hs.loadSpoon("SpoonInstall")
  local use_spoon
  do
    local v_27_auto
    local function use_spoon0(...)
      local spoon_name, opts = ...
      do
        local cnt_54_auto = select("#", ...)
        if (2 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "use-spoon"))
        else
        end
      end
      return spoon.SpoonInstall:andUse(spoon_name, opts)
    end
    v_27_auto = use_spoon0
    spoons["use-spoon"] = v_27_auto
    use_spoon = v_27_auto
  end
  use_spoon("Calendar", {})
  use_spoon("CircleClock", {})
  use_spoon("ClipboardTool", {start = true})
  use_spoon("Emojis", {})
  local toggle_emojis
  do
    local v_27_auto
    local function toggle_emojis0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "toggle-emojis"))
        else
        end
      end
      if spoon.Emojis.chooser:isVisible() then
        return spoon.Emojis.chooser:hide()
      else
        return spoon.Emojis.chooser:show()
      end
    end
    v_27_auto = toggle_emojis0
    spoons["toggle-emojis"] = v_27_auto
    toggle_emojis = v_27_auto
  end
  use_spoon("HSKeybindings", {})
  local hammerspoonKeybindingsIsShown
  do
    local v_27_auto = atom(false)
    spoons["hammerspoonKeybindingsIsShown"] = v_27_auto
    hammerspoonKeybindingsIsShown = v_27_auto
  end
  local toggleShowKeybindings
  do
    local v_27_auto
    local function toggleShowKeybindings0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "toggleShowKeybindings"))
        else
        end
      end
      local function _1162_(_241)
        return not _241
      end
      update_21(hammerspoonKeybindingsIsShown, _1162_)
      if deref(hammerspoonKeybindingsIsShown) then
        return spoon.HSKeybindings:show()
      else
        return spoon.HSKeybindings:hide()
      end
    end
    v_27_auto = toggleShowKeybindings0
    spoons["toggleShowKeybindings"] = v_27_auto
    toggleShowKeybindings = v_27_auto
  end
  use_spoon("KSheet", {})
  spoon.SpoonInstall.repos.PaperWM = {url = "https://github.com/mogenson/PaperWM.spoon", desc = "PaperWM.spoon repository", branch = "release"}
  local paper_wm
  local function _1164_(_241)
    return _241:bindHotkeys(_241.default_hotkeys)
  end
  paper_wm = use_spoon("PaperWM", {repo = "PaperWM", config = {window_gap = 35, screen_margin = 16, window_ratios = {0.3125, 0.421875, 0.625, 0.84375}}, fn = _1164_, start = true})
  return nil
end
package.preload["active-space-indicator"] = package.preload["active-space-indicator"] or function(...)
  local function _1165_()
    return "#<namespace: active-space-indicator>"
  end
  local _local_1166_ = {setmetatable({}, {__fennelview = _1165_, __name = "namespace"})}
  local active_space_indicator = _local_1166_[1]
  local get_spaces_str
  do
    local v_27_auto
    local function get_spaces_str0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "get-spaces-str"))
        else
        end
      end
      local title = {}
      local spaces_layout = hs.spaces.allSpaces()
      local active_spaces = hs.spaces.activeSpaces()
      local num_spaces = 0
      for _, screen in ipairs(hs.screen.allScreens()) do
        table.insert(title, (screen:name() .. ": "))
        local screen_uuid = screen:getUUID()
        local active_space = active_spaces[screen_uuid]
        for i, space in ipairs(spaces_layout[screen_uuid]) do
          local space_title = tostring((i + num_spaces))
          if (active_space and (active_space == space)) then
            table.insert(title, ("[" .. space_title .. "]"))
          else
            table.insert(title, (" " .. space_title .. " "))
          end
        end
        num_spaces = (num_spaces + #spaces_layout[screen_uuid])
        table.insert(title, "  ")
      end
      table.remove(title)
      return table.concat(title)
    end
    v_27_auto = get_spaces_str0
    active_space_indicator["get-spaces-str"] = v_27_auto
    get_spaces_str = v_27_auto
  end
  local handle_space_switch
  do
    local v_27_auto
    local function handle_space_switch0(...)
      local core_38_auto = require("cljlib")
      local _let_1169_ = core_38_auto.list(...)
      local rest = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_1169_, 1)
      return hs.alert(get_spaces_str())
    end
    v_27_auto = handle_space_switch0
    active_space_indicator["handle-space-switch"] = v_27_auto
    handle_space_switch = v_27_auto
  end
  local space_watcher = hs.spaces.watcher.new(handle_space_switch)
  space_watcher:start()
  local screen_watcher = hs.screen.watcher.new(handle_space_switch)
  screen_watcher:start()
  local expose = hs.expose.new()
  local function _1170_()
    return expose:toggleShow()
  end
  return hs.hotkey.bind("ctrl-cmd", "e", "Expose", _1170_)
end
package.preload["window-ops"] = package.preload["window-ops"] or function(...)
  local function _1171_()
    return "#<namespace: window-ops>"
  end
  local _local_1172_ = {setmetatable({}, {__fennelview = _1171_, __name = "namespace"})}
  local window_ops = _local_1172_[1]
  local phi
  do
    local v_27_auto = (4 / 3)
    window_ops["phi"] = v_27_auto
    phi = v_27_auto
  end
  local menubar_height
  do
    local v_27_auto = 25
    window_ops["menubar-height"] = v_27_auto
    menubar_height = v_27_auto
  end
  local window_gap
  do
    local v_27_auto = (menubar_height * 1.44)
    window_ops["window-gap"] = v_27_auto
    window_gap = v_27_auto
  end
  local resize_window_to_a4
  do
    local v_27_auto
    local function resize_window_to_a40(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "resize-window-to-a4"))
        else
        end
      end
      local win = hs.window.focusedWindow()
      local f = win:frame()
      local screen = win:screen():frame()
      local max_h = (screen.h * 0.95)
      local h = math.min((f.w * phi), max_h)
      local w = (h / phi)
      f.w = w
      f.h = h
      if ((f.y + f.h) > screen.h) then
        f.y = (screen.h - f.h - 10)
      else
      end
      return win:setFrame(f)
    end
    v_27_auto = resize_window_to_a40
    window_ops["resize-window-to-a4"] = v_27_auto
    resize_window_to_a4 = v_27_auto
  end
  local move_and_resize_window_left
  do
    local v_27_auto
    local function move_and_resize_window_left0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "move-and-resize-window-left"))
        else
        end
      end
      local win = hs.window.focusedWindow()
      local screen = win:screen()
      local f = screen:fromUnitRect("0.1 0 0.55 1")
      f.x = (f.x + window_gap)
      f.y = (f.y + window_gap + menubar_height)
      f.w = (f.w - (2 * window_gap))
      f.h = ((f.h - (2 * window_gap)) - menubar_height)
      return win:setFrame(f)
    end
    v_27_auto = move_and_resize_window_left0
    window_ops["move-and-resize-window-left"] = v_27_auto
    move_and_resize_window_left = v_27_auto
  end
  local move_and_resize_window_right
  do
    local v_27_auto
    local function move_and_resize_window_right0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "move-and-resize-window-right"))
        else
        end
      end
      local win = hs.window.focusedWindow()
      local screen = win:screen()
      local f = screen:fromUnitRect("0.55 0 1 1")
      f.x = (f.x + window_gap)
      f.y = (f.y + window_gap + menubar_height)
      f.w = (f.w - (2 * window_gap))
      f.h = ((f.h - (2 * window_gap)) - menubar_height)
      return win:setFrame(f)
    end
    v_27_auto = move_and_resize_window_right0
    window_ops["move-and-resize-window-right"] = v_27_auto
    move_and_resize_window_right = v_27_auto
  end
  local move_to_center
  do
    local v_27_auto
    local function move_to_center0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "move-to-center"))
        else
        end
      end
      return hs.window.focusedWindow():centerOnScreen()
    end
    v_27_auto = move_to_center0
    window_ops["move-to-center"] = v_27_auto
    move_to_center = v_27_auto
  end
  local move_to_center_and_resize
  do
    local v_27_auto
    local function move_to_center_and_resize0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "move-to-center-and-resize"))
        else
        end
      end
      local win = hs.window.focusedWindow()
      local screen = win:screen()
      local win_f = win:frame()
      local f = screen:frame()
      f.x = win_f.x
      f.y = (win_f.y + menubar_height)
      f.h = (f.h * 0.95)
      f.w = (f.h / phi)
      win:setFrame(f)
      return win:centerOnScreen()
    end
    v_27_auto = move_to_center_and_resize0
    window_ops["move-to-center-and-resize"] = v_27_auto
    move_to_center_and_resize = v_27_auto
  end
  local double_size
  do
    local v_27_auto
    local function double_size0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "double-size"))
        else
        end
      end
      local win = hs.window.focusedWindow()
      local screen = win:screen()
      local win_f = win:frame()
      local f = screen:fromUnitRect("0 0 1 1")
      f.x = win_f.x
      f.y = win_f.y
      f.h = (f.h * 0.95)
      f.w = (((f.h / phi) * 2) + window_gap)
      win:setFrame(f)
      return win:centerOnScreen()
    end
    v_27_auto = double_size0
    window_ops["double-size"] = v_27_auto
    double_size = v_27_auto
  end
  return nil
end
package.preload["repl"] = package.preload["repl"] or function(...)
  local coroutine = require("coroutine")
  local fennel = require("fennel")
  local jeejah = require("jeejah")
  local _local_1190_ = require("lib.functional")
  local merge = _local_1190_["merge"]
  local function fennel_middleware(f, msg)
    local _1191_ = msg.op
    if (_1191_ == "load-file") then
      local f0 = assert(io.open(msg.filename, "rb"))
      msg["op"]["eval"]["code"] = f0:read("*all"):gsub("^#![^\n]*\n", "")
      return f0:close()
    else
      local _ = _1191_
      return f(msg)
    end
  end
  local default_opts = {port = nil, fennel = true, middleware = fennel_middleware, serialize = hs.inspect}
  local repl_coro_freq = 0.05
  local function run(server)
    local repl_coro = server
    local repl_spin
    local function _1193_()
      return coroutine.resume(repl_coro)
    end
    repl_spin = _1193_
    local repl_chk
    local function _1194_()
      return (coroutine.status(repl_coro) ~= "dead")
    end
    repl_chk = _1194_
    return hs.timer.doWhile(repl_chk, repl_spin, repl_coro_freq)
  end
  local function start(custom_opts)
    local opts = merge({}, default_opts, custom_opts)
    local server = jeejah.start(opts.port, opts)
    return server
  end
  local function stop(server)
    return jeejah.stop(server)
  end
  return {run = run, start = start, stop = stop}
end
package.preload["jeejah"] = package.preload["jeejah"] or function(...)
  local socket = require "socket"
  local bencode = require "bencode"
  
  local load = loadstring or load
  
  local timeout = 0.001
  
  local d = os.getenv("DEBUG") and print or function(_) end
  local serializer = tostring
  local sessions = {}
  local compose = function(printer, serializer)
     return function(...)
          printer(serializer(...))
     end
  end
  
  local response_for = function(old_msg, msg)
     -- certain implementations break when the ns field is empty; see
     -- https://gitlab.com/technomancy/jeejah/issues/5
     msg.session, msg.id, msg.ns = old_msg.session, old_msg.id, ">"
     return msg
  end
  
  local send = function(conn, msg)
     d("Sending", bencode.encode(msg))
     conn:send(bencode.encode(msg))
  end
  
  local write_for = function(conn, msg)
     return function(...)
        send(conn, response_for(msg, {out=table.concat({...}, "\t")}))
     end
  end
  
  local print_for = function(write)
     return function(...)
        local args = {...}
        for i,x in ipairs(args) do args[i] = tostring(x) end
        table.insert(args, "\n")
        write(table.concat(args, " "))
     end
  end
  
  local read_for = function(conn, msg)
     return function()
        send(conn, response_for(msg, {status={"need-input"}}))
        while(not sessions[msg.session].input) do
           coroutine.yield()
           d("yielded")
        end
        local input = sessions[msg.session].input
        sessions[msg.session].input = nil
        return input
     end
  end
  
  local sandbox_for = function(write, provided_sandbox)
     local sandbox = { io = { write = write },
                       print = print_for(write), }
     for k,v in pairs(provided_sandbox) do
        sandbox[k] = v
     end
     return sandbox
  end
  
  -- for stuff that's shared between eval and load_file
  local execute_chunk = function(session, chunk, pp)
     local old_write, old_print, old_read = io.write, print, io.read
     if(session.sandbox) then
        setfenv(chunk, session.sandbox)
        pp = pp or compose(session.sandbox.print, serializer)
     else
        _G.print = print_for(session.write)
        _G.io.write, _G.io.read = session.write, session.read
        pp = pp or compose(_G.print, serializer)
     end
  
     local trace, err
     local result = {xpcall(chunk, function(e)
                               trace = debug.traceback()
                               err = e end)}
  
     _G.print, _G.io.write, _G.io.read = old_print, old_write, old_read
  
     if(result[1]) then
        local res, i = pp(result[2]), 3
        while i <= #result do
           res = res .. ', ' .. pp(result[i])
           i = i + 1
        end
        return res
     else
        return nil, (err or "Unknown error") .. "\n" .. trace
     end
  end
  
  local eval = function(session, code, pp)
     local chunk, err = load("return " .. code, "*socket*")
     if(err and not chunk) then -- statement, not expression
        chunk, err = load(code, "*socket*")
        if(not chunk) then
           return nil, "Compilation error: " .. (err or "unknown")
        end
     end
     return execute_chunk(session, chunk, pp)
  end
  
  local load_file = function(session, file, loader)
     local chunk, err = (loader or loadfile)(file)
     if(not chunk) then
        return nil, "Compilation error in " .. file ": ".. (err or "unknown")
     end
     return execute_chunk(session, chunk)
  end
  
  local register_session = function(conn, msg, provided_sandbox)
     local id = tostring(math.random(999999999))
     local write = write_for(conn, msg)
     local sandbox = provided_sandbox and sandbox_for(write, provided_sandbox)
     sessions[id] = { conn = conn, write = write, print = print_for(write),
                      sandbox = sandbox, coros = {}, id = id}
     return response_for(msg, {["new-session"]=id, status={"done"}})
  end
  
  local unregister_session = function(msg)
     sessions[msg.session] = nil
     return response_for(msg, {status={"done"}})
  end
  
  local describe = function(msg, handlers)
     local ops = { "clone", "close", "describe", "eval", "load-file",
                   "ls-sessions", "complete", "stdin", "interrupt" }
     for op in handlers do table.insert(ops, op) end
     return response_for(msg, {ops=ops, status={"done"}})
  end
  
  local session_for = function(conn, msg, sandbox)
     local s = sessions[msg.session] or register_session(conn, msg, sandbox)
     s.write = write_for(conn, msg)
     s.read = read_for(conn, msg)
     return s
  end
  
  local complete = function(msg, sandbox)
     local clone = function(t)
        local n = {} for k,v in pairs(t) do n[k] = v end return n
     end
     local top_ctx = clone(sandbox or _G)
     for k,v in pairs(msg.libs or {}) do
        top_ctx[k] = require(v:sub(2,-2))
     end
  
     local function cpl_for(input_parts, ctx)
        if type(ctx) ~= "table" then return {} end
        if #input_parts == 0 and ctx ~= top_ctx then
           return ctx
        elseif #input_parts == 1 then
           local matches = {}
           for k in pairs(ctx) do
              if k:find('^' .. input_parts[1]) then
                 table.insert(matches, k)
              end
           end
           return matches
        else
           local token1 = table.remove(input_parts, 1)
           return cpl_for(input_parts, ctx[token1])
        end
     end
     local input_parts = {}
     for i in string.gmatch(msg.input, "([^.%s]+)") do
        table.insert(input_parts, i)
     end
     return response_for(msg, {completions = cpl_for(input_parts, top_ctx)})
  end
  
  -- see https://github.com/clojure/tools.nrepl/blob/master/doc/ops.md
  local handle = function(conn, handlers, sandbox, msg)
     if(handlers and handlers[msg.op]) then
        d("Custom op:", msg.op)
        handlers[msg.op](conn, msg, session_for(conn, msg, sandbox),
                         send, response_for)
     elseif(msg.op == "clone") then
        d("New session.")
        send(conn, register_session(conn, msg, sandbox))
     elseif(msg.op == "describe") then
        d("Describe.")
        send(conn, describe(msg, handlers))
     elseif(msg.op == "eval") then
        d("Evaluating", msg.code)
        local value, err = eval(session_for(conn, msg, sandbox), msg.code, msg.pp)
        d("Got", value, err)
        -- monroe bug means you have to send done status separately
        send(conn, response_for(msg, {value=value, ex=err}))
        send(conn, response_for(msg, {status={"done"}}))
     elseif(msg.op == "load-file") then
        d("Loading file", msg.file)
        local value, err = load_file(session_for(conn, msg, sandbox),
                                     msg.file, msg.loader)
        d("Got", value, err)
        send(conn, response_for(msg, {value=value, ex=err, status={"done"}}))
     elseif(msg.op == "ls-sessions") then
        d("List sessions")
        local session_ids = {}
        for id in pairs(sessions) do table.insert(session_ids, id) end
        send(conn, response_for(msg, {sessions=session_ids, status={"done"}}))
     elseif(msg.op == "complete") then
        d("Complete", msg.input)
        local session_sandbox = session_for(conn, msg, sandbox).sandbox
        send(conn, complete(msg, session_sandbox))
     elseif(msg.op == "stdin") then
        d("Stdin", serializer(msg))
        sessions[msg.session].input = msg.stdin
        send(conn, response_for(msg, {status={"done"}}))
        return
     elseif(msg.op ~= "interrupt") then -- silently ignore interrupt
        send(conn, response_for(msg, {status={"unknown-op"}}))
        print("  | Unknown op", serializer(msg))
     end
  end
  
  local handler_coros = {}
  
  local function receive(conn, partial)
     local s, err = conn:receive(1) -- wow this is primitive
     -- iterate backwards so we can safely remove
     for i=#handler_coros, 1, -1 do
        local ok, err2 = coroutine.resume(handler_coros[i])
        if(coroutine.status(handler_coros[i]) ~= "suspended") then
           if(not ok) then print("  | Handler error", err2) end
           table.remove(handler_coros, i)
        end
     end
  
     if(s) then
        return receive(conn, (partial or "") .. s)
     elseif(err == "timeout" and partial == nil) then
        coroutine.yield()
        return receive(conn)
     elseif(err == "timeout") then
        return partial
     else
        return nil, err
     end
  end
  
  local function client_loop(conn, sandbox, handlers, middleware, partial)
     local input, r_err = receive(conn, partial)
     if(input) then
        local decoded, d_err = bencode.decode(input)
        if decoded and d_err < #input then
           partial = input:sub(d_err + 1)
        else
           partial = nil
        end
        coroutine.yield()
        if(decoded and decoded.op == "close") then
           d("End session.")
           return send(conn, unregister_session(decoded))
        elseif(decoded and decoded.op ~= "close") then
           -- If we don't spin up a coroutine here, we can't io.read, because
           -- that requires waiting for a response from the client. But most
           -- messages don't need to stick around.
           local coro = coroutine.create(handle)
           if(middleware) then
              middleware(function(msg)
                    local ok, err = coroutine.resume(coro, conn, handlers,
                                                     sandbox, msg)
                    if(not ok) then print("  | Handler error", err) end
                         end, decoded)
           else
              local ok, err = coroutine.resume(coro, conn, handlers,
                                               sandbox, decoded)
              if(not ok) then print("  | Handler error", err) end
           end
           if(coroutine.status(coro) == "suspended") then
              table.insert(handler_coros, coro)
           end
        else
           print("  | Decoding error:", d_err)
        end
        return client_loop(conn, sandbox, handlers, middleware, partial)
     else
        return r_err
     end
  end
  
  local connections = {}
  
  local function loop(server, sandbox, handlers, middleware, foreground)
     socket.sleep(timeout)
     local conn, err = server:accept()
     local stop = (not foreground) and (coroutine.yield() == "stop")
     if(conn) then
        conn:settimeout(timeout)
        d("Connected.")
        local coro = coroutine.create(function()
              local _, h_err = pcall(client_loop, conn, sandbox, handlers, middleware)
              if(h_err ~= "closed") then print("Connection closed: " .. h_err) end
        end)
        table.insert(connections, coro)
        return loop(server, sandbox, handlers, middleware, foreground)
     else
        if(err ~= "timeout") then print("  | Socket error: " .. err) end
        for _,c in ipairs(connections) do coroutine.resume(c) end
        if(stop or err == "closed") then
           server:close()
           print("Server stopped.")
        else
           return loop(server, sandbox, handlers, middleware, foreground)
        end
     end
  end
  
  return {
     -- Start an nrepl socket server on the given port. For opts you can pass a
     -- table with foreground=true to run in the foreground, debug=true for
     -- verbose logging, and sandbox={...} to evaluate all code in a sandbox.  You
     -- can also give an opts.handlers table keying ops to handler functions which
     -- take the socket, the decoded message, and the optional sandbox table.
     start = function(port, opts)
        port = port or 7888
        opts = opts or {}
        opts.handlers = opts.handlers or {}
        -- host should always be localhost on a PC, but not always on a micro
        local server = assert(socket.bind(opts.host or "localhost", port))
        if(opts.debug) then d = print end
        if(opts.serialize) then
           serializer = opts.serialize
        else
            local serpent = require("serpent")
            local serpent_pp = function(x)
                local serpent_opts = {maxlevel=8,maxnum=64,nocode=true}
                return serpent.block(x, serpent_opts)
            end
            serializer = serpent_pp
        end
        if(opts.timeout) then timeout = tonumber(opts.timeout) end
        if(opts.fennel) then
           local fenneleval = require("jeejah.fenneleval")
           opts.handlers.eval = fenneleval
           opts.handlers.stdin = fenneleval
        end
        assert(not opts.sandbox or setfenv, "Can't use sandbox on 5.2+")
  
        server:settimeout(timeout)
        print("Server started on port " .. port .. "...")
        if opts.foreground then
           return loop(server, opts.sandbox, opts.handlers,
                       opts.middleware, opts.foreground)
        else
           return coroutine.create(function()
                 loop(server, opts.sandbox, opts.handlers, opts.middleware)
           end)
        end
     end,
  
     -- Pass in the coroutine from jeejah.start to this function to stop it.
     stop = function(coro)
        coroutine.resume(coro, "stop")
     end,
  
     broadcast = function(msg)
        for _,session in pairs(sessions) do
           send(session.conn, msg)
        end
     end,
  }
end
package.preload["app-switcher"] = package.preload["app-switcher"] or function(...)
  local function _1195_()
    return "#<namespace: app-switcher>"
  end
  local _local_1196_ = {setmetatable({}, {__fennelview = _1195_, __name = "namespace"}), require("lib.utils")}
  local app_switcher = _local_1196_[1]
  local _local_1197_ = _local_1196_[2]
  local global_filter = _local_1197_["global-filter"]
  local calc_thumbnail_size
  local function calc_thumbnail_size0(...)
    do
      local cnt_54_auto = select("#", ...)
      if (0 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "calc-thumbnail-size"))
      else
      end
    end
    local screen = hs.screen.mainScreen()
    local _let_1199_ = screen:currentMode()
    local h = _let_1199_["h"]
    return (h / 2)
  end
  calc_thumbnail_size = calc_thumbnail_size0
  local switcher = hs.window.switcher.new(global_filter(), {textSize = 12, showSelectedTitle = true, selectedThumbnailSize = calc_thumbnail_size(), backgroundColor = {0, 0, 0, 0}, showThumbnails = false, showTitles = false})
  local init
  do
    local v_27_auto
    local function init0(...)
      local _config = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "init"))
        else
        end
      end
    end
    v_27_auto = init0
    app_switcher["init"] = v_27_auto
    init = v_27_auto
  end
  local prev_app
  do
    local v_27_auto
    local function prev_app0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "prev-app"))
        else
        end
      end
      return switcher:previous()
    end
    v_27_auto = prev_app0
    app_switcher["prev-app"] = v_27_auto
    prev_app = v_27_auto
  end
  local next_app
  do
    local v_27_auto
    local function next_app0(...)
      do
        local cnt_54_auto = select("#", ...)
        if (0 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "next-app"))
        else
        end
      end
      return switcher:next()
    end
    v_27_auto = next_app0
    app_switcher["next-app"] = v_27_auto
    next_app = v_27_auto
  end
  return app_switcher
end
package.preload["file-watchers"] = package.preload["file-watchers"] or function(...)
  local function _1203_()
    return "#<namespace: file-watchers>"
  end
  local _local_1242_ = {setmetatable({}, {__fennelview = _1203_, __name = "namespace"}), require("cljlib"), require("fennel"), require("events"), require("behaviors")}
  local file_watchers = _local_1242_[1]
  local _local_1243_ = _local_1242_[2]
  local assoc = _local_1243_["assoc"]
  local mapv = _local_1243_["mapv"]
  local nil_3f = _local_1243_["nil?"]
  local fnl = _local_1242_[3]
  local _local_1244_ = _local_1242_[4]
  local dispatch_event = _local_1244_["dispatch-event"]
  local tag_events = _local_1244_["tag-events"]
  local _local_1245_ = _local_1242_[5]
  local register_behavior = _local_1245_["register-behavior"]
  tag_events("file-watchers.events/file-change", "file-watchers", {"file-watchers.tags/file-change"})
  local handle_reload
  local function handle_reload0(...)
    local files, attrs = ...
    do
      local cnt_54_auto = select("#", ...)
      if (2 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "handle-reload"))
      else
      end
    end
    local evs
    local function _1247_(_241, _242)
      return assoc(_241, "file-path", _242)
    end
    evs = mapv(_1247_, attrs, files)
    for _, ev in ipairs(evs) do
      dispatch_event("file-watchers.events/file-change", "file-watchers", ev)
    end
    return nil
  end
  handle_reload = handle_reload0
  local my_watcher = hs.pathwatcher.new(hs.configdir, handle_reload)
  __fnl_global__file_2dwatchers_2fpath_2dwatcher = my_watcher:start()
  local reloading_3f = false
  local reload = hs.timer.delayed.new(0.5, hs.reload)
  local function _1248_(file_change_event)
    local path
    do
      local t_1249_ = file_change_event
      if (nil ~= t_1249_) then
        t_1249_ = t_1249_["event-data"]
      else
      end
      if (nil ~= t_1249_) then
        t_1249_ = t_1249_["file-path"]
      else
      end
      path = t_1249_
    end
    if (not reloading_3f and not nil_3f(path) and (".hammerspoon/init.lua" == path:sub(-21))) then
      hs.alert("reloading")
      return reload:start()
    else
      return nil
    end
  end
  register_behavior("file-watchers.behaviors/reload-hammerspoon", "When init.lua changes, reload hammerspoon.", {"file-watchers.tags/file-change"}, _1248_)
  local function _1253_(file_change_event)
    local path
    do
      local t_1254_ = file_change_event
      if (nil ~= t_1254_) then
        t_1254_ = t_1254_["event-data"]
      else
      end
      if (nil ~= t_1254_) then
        t_1254_ = t_1254_["file-path"]
      else
      end
      path = t_1254_
    end
    if (not nil_3f(path) and (".fnl" == path:sub(-4))) then
      return print(hs.execute("./compile.sh", true))
    else
      return nil
    end
  end
  register_behavior("file-watchers.behaviors/hammerspoon-compile-fennel", "Watch fennel files in hammerspoon folder and recompile them.", {"file-watchers.tags/file-change"}, _1253_)
  return file_watchers
end
package.preload["events"] = package.preload["events"] or function(...)
  local function _1204_()
    return "#<namespace: events>"
  end
  local _local_1205_ = {setmetatable({}, {__fennelview = _1204_, __name = "namespace"}), require("fennel"), require("cljlib")}
  local events = _local_1205_[1]
  local fnl = _local_1205_[2]
  local _local_1206_ = _local_1205_[3]
  local count = _local_1206_["count"]
  --[[ example-event {:event-data {:window-id 123 :x 10 :y 20} :event-name "window-move" :event-tags ["some" "tags"] :origin "windows-watcher" :timestamp 0} ]]
  local processing_3f = false
  local events_queue = {}
  local event_handlers = {}
  local get_event_tags
  do
    local v_27_auto
    do
      local pairs_105_auto
      local function _1207_(t_106_auto)
        local _1208_ = getmetatable(t_106_auto)
        if ((_G.type(_1208_) == "table") and (nil ~= _1208_.__pairs)) then
          local p_107_auto = _1208_.__pairs
          return p_107_auto(t_106_auto)
        else
          local _ = _1208_
          return pairs(t_106_auto)
        end
      end
      pairs_105_auto = _1207_
      local _let_1210_ = require("cljlib")
      local eq_108_auto = _let_1210_["eq"]
      local function _1211_(t_106_auto, ...)
        local dispatch_value_113_auto
        local function _1212_(ev)
          return {ev["event-name"], ev.origin}
        end
        dispatch_value_113_auto = _1212_(...)
        local view_114_auto
        do
          local _1213_, _1214_ = pcall(require, "fennel")
          if ((_1213_ == true) and (nil ~= _1214_)) then
            local fennel_115_auto = _1214_
            local function _1215_(_241)
              return fennel_115_auto.view(_241, {["one-line"] = true})
            end
            view_114_auto = _1215_
          else
            local _ = _1213_
            view_114_auto = tostring
          end
        end
        return (t_106_auto[dispatch_value_113_auto] or t_106_auto[(({}).default or "default")] or error(("No method in multimethod '" .. "get-event-tags" .. "' for dispatch value: " .. view_114_auto(dispatch_value_113_auto)), 2))(...)
      end
      local function _1217_(t_106_auto, key_109_auto)
        local res_110_auto = nil
        for k_111_auto, v_112_auto in pairs_105_auto(t_106_auto) do
          if res_110_auto then break end
          if eq_108_auto(k_111_auto, key_109_auto) then
            res_110_auto = v_112_auto
          else
            res_110_auto = nil
          end
        end
        return res_110_auto
      end
      v_27_auto = setmetatable({}, {__call = _1211_, __fennelview = tostring, __index = _1217_, __name = ("multifn " .. "get-event-tags"), ["cljlib/type"] = "multifn"})
    end
    events["get-event-tags"] = v_27_auto
    get_event_tags = v_27_auto
  end
  do
    local dispatch_117_auto = "default"
    local multifn_118_auto = get_event_tags
    local and_1220_ = not multifn_118_auto[dispatch_117_auto]
    if and_1220_ then
      local function fn_1219_(...)
        local _ = ...
        do
          local cnt_54_auto = select("#", ...)
          if (1 ~= cnt_54_auto) then
            error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_1219_"))
          else
          end
        end
        return {"event/unknown"}
      end
      multifn_118_auto[dispatch_117_auto] = fn_1219_
      and_1220_ = multifn_118_auto
    end
    do local _ = and_1220_ end
  end
  local tag_events
  do
    local v_27_auto
    local function tag_events0(...)
      local ev_name, orig, tags = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "tag-events"))
        else
        end
      end
      local dispatch_117_auto = {ev_name, orig}
      local multifn_118_auto = get_event_tags
      local and_1224_ = not multifn_118_auto[dispatch_117_auto]
      if and_1224_ then
        local function fn_1223_(...)
          local _ = ...
          do
            local cnt_54_auto = select("#", ...)
            if (1 ~= cnt_54_auto) then
              error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "fn_1223_"))
            else
            end
          end
          return tags
        end
        multifn_118_auto[dispatch_117_auto] = fn_1223_
        and_1224_ = multifn_118_auto
      end
      return and_1224_
    end
    v_27_auto = tag_events0
    events["tag-events"] = v_27_auto
    tag_events = v_27_auto
  end
  local add_event_handler
  do
    local v_27_auto
    local function add_event_handler0(...)
      local handler = ...
      do
        local cnt_54_auto = select("#", ...)
        if (1 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "add-event-handler"))
        else
        end
      end
      local idx = (1 + #event_handlers)
      table.insert(event_handlers, handler)
      local function _1227_()
        event_handlers[idx] = nil
        return nil
      end
      return _1227_
    end
    v_27_auto = add_event_handler0
    events["add-event-handler"] = v_27_auto
    add_event_handler = v_27_auto
  end
  local process_events
  local function process_events0(...)
    do
      local cnt_54_auto = select("#", ...)
      if (0 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "process-events"))
      else
      end
    end
    processing_3f = true
    while (0 < count(events_queue)) do
      local events0 = events_queue
      events_queue = {}
      for _, event in ipairs(events0) do
        for _0, handler in pairs(event_handlers) do
          handler(event)
        end
      end
    end
    processing_3f = false
    return nil
  end
  process_events = process_events0
  local dispatch_event
  do
    local v_27_auto
    local function dispatch_event0(...)
      local event_name, origin, event_data = ...
      do
        local cnt_54_auto = select("#", ...)
        if (3 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "dispatch-event"))
        else
        end
      end
      local event = {timestamp = hs.timer.secondsSinceEpoch(), ["event-name"] = event_name, origin = origin, ["event-data"] = event_data}
      event["event-tags"] = get_event_tags(event)
      table.insert(events_queue, event)
      if not processing_3f then
        return process_events()
      else
        return nil
      end
    end
    v_27_auto = dispatch_event0
    events["dispatch-event"] = v_27_auto
    dispatch_event = v_27_auto
  end
  local function _1231_(event)
    return print("got event", fnl.view(event))
  end
  add_event_handler(_1231_)
  return events
end
package.preload["behaviors"] = package.preload["behaviors"] or function(...)
  local function _1232_()
    return "#<namespace: behaviors>"
  end
  local _local_1233_ = {setmetatable({}, {__fennelview = _1232_, __name = "namespace"}), require("cljlib"), require("events")}
  local behaviors = _local_1233_[1]
  local _local_1234_ = _local_1233_[2]
  local hash_set = _local_1234_["hash-set"]
  local into = _local_1234_["into"]
  local mapcat = _local_1234_["mapcat"]
  local mapv = _local_1234_["mapv"]
  local _local_1235_ = _local_1233_[3]
  local add_event_handler = _local_1235_["add-event-handler"]
  --[[ example-behavior {:description "Some example behavior" :enabled? true :fn (fn [event] (print (fnl.view event))) :name "example-behavior" :respond-to ["example-tag"]} ]]
  local behaviors_register = {}
  local tag_to_behavior_map = {}
  local register_behavior
  do
    local v_27_auto
    local function register_behavior0(...)
      local name, desc, tags, f = ...
      do
        local cnt_54_auto = select("#", ...)
        if (4 ~= cnt_54_auto) then
          error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "register-behavior"))
        else
        end
      end
      local behavior = {name = name, description = desc, ["enabled?"] = true, ["respond-to"] = tags, fn = f}
      behaviors_register[name] = behavior
      for _, tag in pairs(tags) do
        if (nil == tag_to_behavior_map[tag]) then
          tag_to_behavior_map[tag] = {}
        else
        end
        table.insert(tag_to_behavior_map[tag], name)
      end
      return nil
    end
    v_27_auto = register_behavior0
    behaviors["register-behavior"] = v_27_auto
    register_behavior = v_27_auto
  end
  local get_behaviors_for_tags
  local function get_behaviors_for_tags0(...)
    local tags = ...
    do
      local cnt_54_auto = select("#", ...)
      if (1 ~= cnt_54_auto) then
        error(("Wrong number of args (%s) passed to %s"):format(cnt_54_auto, "get-behaviors-for-tags"))
      else
      end
    end
    local function _1239_(_241)
      return behaviors_register[_241]
    end
    local function _1240_(_241)
      return tag_to_behavior_map[_241]
    end
    return mapv(_1239_, into(hash_set(), mapcat(_1240_, tags)))
  end
  get_behaviors_for_tags = get_behaviors_for_tags0
  local function _1241_(event)
    local bs = get_behaviors_for_tags(event["event-tags"])
    for _, behavior in pairs(bs) do
      local f = behavior.fn
      f(event)
    end
    return nil
  end
  add_event_handler(_1241_)
  return behaviors
end
local _local_1258_ = {setmetatable({}, {__fennelview = _1_, __name = "namespace"}), require("cljlib"), require("defaults"), require("config"), require("windows"), require("app-switcher"), require("lib.bind"), require("lib.modal"), require("lib.apps"), require("file-watchers")}
local core = _local_1258_[1]
local _local_1259_ = _local_1258_[2]
local contains_3f = _local_1259_["contains?"]
local into = _local_1259_["into"]
local mapv = _local_1259_["mapv"]
local merge = _local_1259_["merge"]
local some = _local_1259_["some"]
local defaults = _local_1258_[3]
local config = _local_1258_[4]
local windows = _local_1258_[5]
local app_switcher = _local_1258_[6]
local lib_bind = _local_1258_[7]
local lib_modal = _local_1258_[8]
local lib_apps = _local_1258_[9]
local file_watchers = _local_1258_[10]
hs.ipc.cliInstall()
local function _1260_(_241)
  return _241.init(config)
end
resources = mapv(_1260_, {windows, app_switcher, lib_bind, lib_modal, lib_apps})
return hs.alert("Config is loaded successfully!")
