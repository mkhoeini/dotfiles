hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })

spoon.SpoonInstall:andUse("Calendar", {})
-- spoon.SpoonInstall:andUse("HCalendar", { start = true })
-- Pomodoro Menubar: spoon.SpoonInstall:andUse("Cherry", {})
spoon.SpoonInstall:andUse("CircleClock", {})
spoon.SpoonInstall:andUse("ClipboardTool", { start = true })
spoon.SpoonInstall:andUse("Emojis", {})

function toggleEmojis()
  if spoon.Emojis.chooser:isVisible() then
    spoon.Emojis.chooser:hide()
  else
    spoon.Emojis.chooser:show()
  end
end

spoon.SpoonInstall:andUse("HSKeybindings", {})

hammerspoonKeybindingsIsShown = false
function toggleShowKeybindings()
  hammerspoonKeybindingsIsShown = not hammerspoonKeybindingsIsShown
  if hammerspoonKeybindingsIsShown then
    spoon.HSKeybindings:show()
  else
    spoon.HSKeybindings:hide()
  end
end

spoon.SpoonInstall:andUse("KSheet", {})

function resizeWindowToA4()
  local phi = 4/3 -- (1 + math.sqrt(2)) / 2

  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  local max_h = screen.h * 0.85
  local h = math.min(f.w * phi, max_h)
  local w = h / phi

  f.w = w
  f.h = h

  if (f.y + f.h) > screen.h then
    f.y = screen.h - f.h - 10
  end

  win:setFrame(f)
end

spoon.SpoonInstall:andUse("RecursiveBinder", {})
local k = spoon.RecursiveBinder.singleKey
local keyMap = spoon.RecursiveBinder.recursiveBind{
  [k('a', 'applications')] = {
    [k('e', 'emojis')] = toggleEmojis,
  },
  [k('k', 'keyboard shortcuts')] = {
    -- TODO find a way to bind ESC once for closing
    [k('h', 'hammerspoon')] = toggleShowKeybindings,
    [k('a', 'application')] = function() spoon.KSheet:toggle() end,
  },
  [k('w', 'window')] = {
    [k('p', 'proportionate')] = resizeWindowToA4,
  },
}

-- TODO write a desktop drawing version
-- spoon.SpoonInstall:andUse("SpeedMenu", {})
-- TODO use URLDispatcher instead of browserasorous

hs.hotkey.bind({'option'}, 'space', keyMap)
hs.alert.show("Config Loaded")
