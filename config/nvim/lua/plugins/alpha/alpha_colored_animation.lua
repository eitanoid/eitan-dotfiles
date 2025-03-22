local M = {}

local function cloneTable(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

-- given a 2D array of chars and a map of char -> rbga hex codes, create highlight groups and return a 2d table of those highlight groups in alpha's standard.
local function colorize(_header_color_map, _colors)
	local color_names = {}
	for letter, color in pairs(_colors) do
		local color_name = "AlphaHeader" .. letter
		vim.api.nvim_set_hl(0, color_name, color)
		color_names[letter] = color_name
	end

	local colorized = {}

	for _, line in ipairs(_header_color_map) do
		local colorized_line = {}
		local pos = 0

		for j = 1, #line do
			local start = pos
			pos = pos + 1

			local color_name = color_names[line:sub(j, j)]
			if color_name then
				table.insert(colorized_line, { color_name, start, pos })
			end
		end

		table.insert(colorized, colorized_line)
	end

	return colorized
end

-- Read and interrupt frames from a text file. begin frame with `frame:` and end with a line of `=`:
--[[ 
frame:
ascii art here...
more ascii art...
=================
 ]]
local function read_ascii_frames(chosen_file)
	local file = io.open(chosen_file, "r")
	if not file then
		print("Could not open ASCII file: " .. chosen_file)
		return {}
	end

	local frames = {}
	local current_frame = {}
	local in_frame = false

	for line in file:lines() do
		if line == "Frame:" then
			in_frame = true
		elseif line:match("^=+$") then -- Matches a line of equal signs
			if #current_frame > 0 then
				table.insert(frames, current_frame)
				current_frame = {}
			end
			in_frame = false
		elseif in_frame then
			table.insert(current_frame, line)
		end
	end

	-- Add the last frame if it exists
	if #current_frame > 0 then
		table.insert(frames, current_frame)
	end

	file:close()

	-- Debug message
	print("Loaded " .. #frames .. " frames")
	return frames
end

-- Create the animation and animation timer
local function create_animation(alpha, dashboard, config) -- chosen_file, colors_file, color_codes, frame_delay
	if not config.frames then
		return
	end

	local frames = read_ascii_frames(config.frames)
	local colors = read_ascii_frames(config.color_frames)

	if #frames == 0 or #colors == 0 then
		return
	end

	-- Set initial frame
	dashboard.section.header.val = frames[1]
	dashboard.section.header.opts.hl = colorize(colors[1], cloneTable(config.color_map))
	alpha.redraw()

	local timer = vim.uv.new_timer()
	local frame_index = 1

	timer:start(
		0,
		config.frame_delay, -- 50
		vim.schedule_wrap(function()
			frame_index = (frame_index % #frames) + 1
			local color_index = (frame_index % #colors) + 1
			dashboard.section.header.val = frames[frame_index]
			dashboard.section.header.opts.hl = colorize(colors[color_index], cloneTable(config.color_map))
			alpha.redraw()
		end)
	)

	vim.api.nvim_create_autocmd("BufLeave", { -- stop animating when alpha closes
		pattern = "alpha",
		callback = function()
			timer:stop()
		end,
	})
end

local function create_scroller_animation(alpha, section, config) -- TODO: shifting isn't correct
	--[[ 
    config = {
    val = "no matter where you go, everyone's connected"
    frame_delay = 100 ms
    speed = 1 # shifts per frame
    }
     ]]

	if not config.val then
		return
	end

	-- Set initial frame
	section.val = config.val
	alpha.redraw()

	local timer = vim.uv.new_timer()
	local cycle_offset = config.speed --- shift val by 'cycle_offset' value.

	timer:start(
		0,
		config.frame_delay, -- 50
		vim.schedule_wrap(function()
			local current = section.val
			local shifted = current .. current
			cycle_offset = (cycle_offset + config.speed) % #current
			shifted = shifted:sub(cycle_offset, cycle_offset + #current - 1)
			section.val = shifted
			alpha.redraw()
		end)
	)

	vim.api.nvim_create_autocmd("BufLeave", { -- stop animating when alpha closes
		pattern = "alpha",
		callback = function()
			timer:stop()
		end,
	})
end

--[[ 
local animation_config = {
	file = animation_file, -- path to animation file
	colors = colors_file, -- path to colors animation file
	color_map = color_key, -- map of symbol to colors
	frame_delay = frame_delay, -- delay between frames in ms
}
]]

-- start animation after alpha is ready
-- this means the header is only configured after neovim has loaded
M.init_header_animation = function(alpha, dashboard, config_table)
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "AlphaReady",
		callback = function()
			create_animation(alpha, dashboard, config_table)
		end,
	})
end

M.init_section_scroller = function(alpha, section, config_table)
	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "AlphaReady",
		callback = function()
			create_scroller_animation(alpha, section, config_table)
		end,
	})
end

return M
