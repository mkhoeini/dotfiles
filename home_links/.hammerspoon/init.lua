hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("ReloadConfiguration", { start = true })

spoon.SpoonInstall:andUse("Calendar", {})
-- spoon.SpoonInstall:andUse("HCalendar", { start = true })
-- Pomodoro Menubar: spoon.SpoonInstall:andUse("Cherry", {})
spoon.SpoonInstall:andUse("CircleClock", {})
spoon.SpoonInstall:andUse("ClipboardTool", { start = true })
spoon.SpoonInstall:andUse("Emojis", {})

-- Make setFrame behave more correctly. e.g. terminal windows
--hs.window.setFrameCorrectness = true

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

local phi = 4/3 -- (1 + math.sqrt(2)) / 2
local menubarHeight = 25
local windowGap = menubarHeight * 1.44

function resizeWindowToA4()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen():frame()

  local max_h = screen.h * 0.95
  local h = math.min(f.w * phi, max_h)
  local w = h / phi

  f.w = w
  f.h = h

  if (f.y + f.h) > screen.h then
    f.y = screen.h - f.h - 10
  end

  win:setFrame(f)
end

function moveAndResizeWindowLeft()
  local win = hs.window.focusedWindow()
  local screen = win:screen()

  local f = screen:fromUnitRect("0.1 0 0.55 1")

  f.x = f.x + windowGap
  f.y = f.y + windowGap + menubarHeight
  f.w = f.w - 2 * windowGap
  f.h = f.h - 2 * windowGap - menubarHeight

  win:setFrame(f)
end

function moveAndResizeWindowRight()
  local win = hs.window.focusedWindow()
  local screen = win:screen()

  local f = screen:fromUnitRect("0.55 0 1 1")

  f.x = f.x + windowGap
  f.y = f.y + windowGap + menubarHeight
  f.w = f.w - 2 * windowGap
  f.h = f.h - 2 * windowGap - menubarHeight

  win:setFrame(f)
end

function moveToCenter()
  hs.window.focusedWindow():centerOnScreen()
end

function moveToCenterAndResize()
  local win = hs.window.focusedWindow()
  local screen = win:screen()

  local win_f = win:frame()
  local f = screen:frame()

  f.x = win_f.x
  f.y = win_f.y + menubarHeight
  f.h = f.h * 0.95
  f.w = f.h / phi

  win:setFrame(f)
  win:centerOnScreen()
end

function doubleSize()
  local win = hs.window.focusedWindow()
  local screen = win:screen()

  local win_f = win:frame()
  local f = screen:fromUnitRect("0 0 1 1")

  f.x = win_f.x
  f.y = win_f.y
  f.h = f.h * 0.95
  f.w = f.h / phi * 2 + windowGap

  win:setFrame(f)
  win:centerOnScreen()
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
    [k('c', 'move to center')] = moveToCenter,
    [k('C', 'move and resize to center')] = moveToCenterAndResize,
    [k('d', 'double size')] = doubleSize,
    [k('h', 'resize to left')] = moveAndResizeWindowLeft,
    [k('l', 'resize to right')] = moveAndResizeWindowRight,
    [k('p', 'proportionate')] = resizeWindowToA4,
  },
}

-- TODO write a desktop drawing version
-- spoon.SpoonInstall:andUse("SpeedMenu", {})
-- TODO use URLDispatcher instead of browserasorous

hs.hotkey.bind({'option'}, 'space', keyMap)
hs.alert.show("Config Loaded")
