-------------------------------------------------
-- Pomodoro Widget for Awesome Window Manager
-- Shows the pomodoro timer status, begin, pause and stop sessions

-- @author David Silva
-------------------------------------------------
local awful = require("awful")
local beautiful = require("beautiful")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local naughty = require("naughty")

local HOME_DIR = os.getenv("HOME")
local WIDGET_DIR = HOME_DIR .. "/.config/awesome/modules/pomodoro-widget/"
local GET_pomodoro_CMD = WIDGET_DIR .. "pomo clock"
local PAUSE_pomodoro_CMD = WIDGET_DIR .. "pomo pause"
local START_pomodoro_CMD = WIDGET_DIR .. "pomo start"
local STOP_pomodoro_CMD = WIDGET_DIR .. "pomo stop"

local pomoarc_widget = {}

local function worker(user_args)
	local args = user_args or {}

	local font = args.font or "Play 6"
	local arc_thickness = args.arc_thickness or 2
	local size = args.size or 20
	local show_notification_on_hover = args.show_notification_on_hover or true
	local notification_position = args.notification_position or "top_right" -- see naughty.notify position argument

	local main_color = args.main_color or beautiful.fg_color
	local bg_color = args.bg_color or "#ffffff11"
	local last5_color = args.last5_color or "#BF616A"
	local last15_color = args.last15_color or "#EBCB8B"
	local break_color = args.break_color or "#A3BE8C"
	local pause_color = args.pause_color or "#81A1C1"

	local warning_msg_title = args.warning_msg_title or "Pomodoro break time!"
	local warning_msg_text = args.warning_msg_text or "Take a small break from work."
	local warning_msg_position = args.warning_msg_position or "bottom_right"
	local warning_msg_icon = args.warning_msg_icon or WIDGET_DIR .. "/spaceman.jpg"
	local enable_battery_warning = args.enable_battery_warning
	if enable_battery_warning == nil then
		enable_battery_warning = true
	end

	local text = wibox.widget({
		font = font,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local text_with_background = wibox.container.background(text)

	pomoarc_widget = wibox.widget({
		text_with_background,
		max_value = 1,
		rounded_edge = true,
		thickness = arc_thickness,
		start_angle = 4.71238898, -- 2pi*3/4
		forced_height = size,
		forced_width = size,
		bg = bg_color,
		paddings = 2,
		widget = wibox.container.arcchart,
	})

	local last_pomodoro_check = os.time()

	local function show_pomodoro_break_warning()
		naughty.notify({
			icon = warning_msg_icon,
			icon_size = 100,
			text = warning_msg_text,
			title = warning_msg_title,
			timeout = 25, -- show the warning for a longer time
			hover_timeout = 0.5,
			position = warning_msg_position,
			bg = "#BF616A",
			fg = "#D8DEE9",
			width = 300,
		})
	end

	local update_widget = function(widget, stdout, _, _, _)
		local pomostatus = string.match(stdout, "  (%D?%D?):%D?%D?")

		if pomostatus == "--" then
			widget.colors = { main_color }
			text.text = "25"
			widget.value = 1
		else
			local pomomin = string.match(stdout, "[ P]?[BW](%d?%d?):%d?%d?")
			local pomosec = string.match(stdout, "[ P]?[BW]%d?%d?:(%d?%d?)")
			local pomodoro = pomomin * 60 + pomosec

			local status = string.match(stdout, "([ P]?)[BW]%d?%d?:%d?%d?")
			local workbreak = string.match(stdout, "[ P]?([BW])%d?%d?:%d?%d?")
			text.text = pomomin

			if status == " " then -- clock ticking
				if workbreak == "W" then
					widget.value = tonumber(pomodoro / (25 * 60))
					if tonumber(pomomin) < 5 then -- last 5 min of pomo
						widget.colors = { last5_color }
					elseif tonumber(pomomin) < 15 then -- last 15 min of pomo
						widget.colors = { last15_color }
					else
						widget.colors = { main_color }
					end
				elseif workbreak == "B" then -- color during break
					if enable_battery_warning and os.difftime(os.time(), last_pomodoro_check) >= 1500 then
						-- if 25 minutes or more have elapsed since the last warning
						last_pomodoro_check = os.time()
						show_pomodoro_break_warning()
					end
					widget.colors = { break_color }
					widget.value = tonumber(pomodoro / (5 * 60))
				end
			elseif status == "P" then -- paused
				if workbreak == "W" then
					widget.colors = { pause_color }
					widget.value = tonumber(pomodoro / (25 * 60))
					text.text = "PW"
				elseif workbreak == "B" then
					widget.colors = { pause_color }
					widget.value = tonumber(pomodoro / (5 * 60))
					text.text = "PB"
				end
			end
		end
	end

	watch(GET_pomodoro_CMD, 1, update_widget, pomoarc_widget)

	-- Popup with battery info
	local notification
	local function show_pomodoro_status()
		spawn.easy_async(GET_pomodoro_CMD, function(stdout, _, _, _)
			naughty.destroy(notification)
			notification = naughty.notify({
				text = stdout,
				title = "Pomodoro Status",
				timeout = 5,
				width = 200,
				position = notification_position,
			})
		end)
	end

	if show_notification_on_hover then
		pomoarc_widget:connect_signal("mouse::enter", function()
			show_pomodoro_status()
		end)
		pomoarc_widget:connect_signal("mouse::leave", function()
			naughty.destroy(notification)
		end)
	end

	-- Button actions (Start, Stop, Pause)
	local start_stop_status = "stop"
	pomoarc_widget:connect_signal("button::press", function(_, _, _, button)
		if button == 1 then
			if start_stop_status == "start" then
				start_stop_status = "stop"
				awful.spawn(STOP_pomodoro_CMD, false)
			else
				start_stop_status = "start"
				awful.spawn(START_pomodoro_CMD, false)
			end
		elseif button == 3 then
			awful.spawn(PAUSE_pomodoro_CMD, false)
		end

		spawn.easy_async(GET_pomodoro_CMD, function(stdout, stderr, exitreason, exitcode)
			update_widget(pomoarc_widget, stdout, stderr, exitreason, exitcode)
		end)
	end)

	return pomoarc_widget
end

return setmetatable(pomoarc_widget, {
	__call = function(_, ...)
		return worker(...)
	end,
})
