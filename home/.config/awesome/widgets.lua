--.config/awesome/widgets.lua

local naughty = require("naughty")

local widgets = {}
local modules_file = '/proc/modules'
local capacity_file = '/sys/class/power_supply/BAT0/capacity'
local status_file = '/sys/class/power_supply/BAT0/status'

local function open_close_file(filename)
  local file=io.open(filename,"r")
  file:close()
end

local function open_close_error()
end

local function file_exists(filename)
  return xpcall(open_close_file, open_close_error, filename)
end

local function battery_not_found()
  -- xpcall will default to false
end

local function substring_exists(superstring, substring)
  return (superstring:find(substring) ~= nil)
end

local function battery_module_loaded()
  -- uses the linux kernel modules to check for a battery power supply
  local filehandle = io.open(modules_file, "r")
  local proc_modules = filehandle:read("*all")
  filehandle:close()
  assert(substring_exists(proc_modules, 'battery'))
  -- require that capacity and status file exists
  assert(file_exists(capacity_file))
  assert(file_exists(status_file))
  -- if here then return true else return false
end

function widgets.is_mobile()
  local has_battery = xpcall(battery_module_loaded, battery_not_found)
  return has_battery
end

local function capacity()
  local capacity_handle = io.open(capacity_file, "r")
  local capacity = capacity_handle:read()
  capacity_handle:close()
  return capacity
end

function widgets.battery_text()
  return "  " .. capacity() .. "%  "
end

local function is_discharging()
  local status_handle = io.open(status_file, "r")
  local status = status_handle:read()
  status_handle:close()
  return (status:match("Discharging") ~= nil)
end

function widgets.battery_notify()
  if (tonumber(capacity()) < 11 and is_discharging()) then
    naughty.notify({ text = "Charge me up, I'm feeling low", timeout = 2 })
  end
end

return widgets
