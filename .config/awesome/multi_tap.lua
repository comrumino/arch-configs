--.config/awesome/multi-tap.lua
-- Standard awesome library
local gears = require("gears")
-- Notification library
local naughty = require("naughty")
local awful = require("awful")

local multi_tap = {}
multi_tap.count = 0

local double_tap = [[bash -c 'xmodmap -pke | sed "s/  / /g" | egrep "keycode (45|110|59|115|46|112|60|117|34|111|47|113|48|114|61|116) =" | sed "s/$/,/g" | tr -d \\n | sed -E "s/(.*)(keycode 45 = )([^,]*)(,.*)(keycode 110 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 59 = )([^,]*)(,.*)(keycode 115 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 46 = )([^,]*)(,.*)(keycode 112 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 60 = )([^,]*)(,.*)(keycode 117 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 34 = )([^,]*)(,.*)(keycode 111 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 47 = )([^,]*)(,.*)(keycode 113 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 48 = )([^,]*)(,.*)(keycode 114 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/(.*)(keycode 61 = )([^,]*)(,.*)(keycode 116 = )([^,]*)(.*)/\1\2\6\4\5\3\7/g; s/,$/\"/g; s/,/\" -e \"/g; s/^/xmodmap -e \"/g" | source /dev/stdin']] 

local callback_timeout = 0.3
local function multi_tap_callback()
  -- reset tap count
  multi_tap.count = 0
  return false
end
multi_tap.timer = gears.timer.start_new(callback_timeout, multi_tap_callback)

local function is_second_tap()
  return multi_tap.count == 2
end

local function increment_tap_count() 
  multi_tap.count = multi_tap.count + 1
end

local function prepare_timer()
  if multi_tap.timer.started then
    multi_tap.timer:again()
  else
    multi_tap.timer:start()
  end
end

function multi_tap.routine()
  -- routine binded to Alt_R that counts the number of times it has be tapped
  -- requires that time between taps is less than the callback timeout
  prepare_timer()
  increment_tap_count()
  
  if is_second_tap() then
    naughty.notify({ text = "We got a double tap" })
    awful.util.spawn(double_tap)
  end
end

return multi_tap
-- vim:se ts=2 sw=2 et: 
