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

-- Read and interrupt frames from a text file
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
local function create_animation_timer(dashboard, alpha, chosen_file, colors_file, color_codes, frame_delay)
	if not chosen_file then
		return
	end

	local frames = read_ascii_frames(chosen_file)
	local colors = read_ascii_frames(colors_file)

	if #frames == 0 or #colors == 0 then
		return
	end

	-- Set initial frame
	dashboard.section.header.val = frames[1]
	dashboard.section.header.opts.hl = colorize(colors[1], cloneTable(color_codes))
	alpha.redraw()

	local timer = vim.loop.new_timer()
	local frame_index = 1

	timer:start(
		0,
		frame_delay, -- 50
		vim.schedule_wrap(function()
			frame_index = (frame_index % #frames) + 1
			local color_index = (frame_index % #colors) + 1
			dashboard.section.header.val = frames[frame_index]
			dashboard.section.header.opts.hl = colorize(colors[color_index], cloneTable(color_codes))
			alpha.redraw()
		end)
	)

	vim.api.nvim_create_autocmd("BufLeave", {
		pattern = "alpha",
		callback = function()
			timer:stop()
		end,
	})
end

-- Set up initial header at the 1st frame.
M.init_header = function(dashboard, animation_file, color_codes, colors_file)
	if animation_file then
		local initial_frames = read_ascii_frames(animation_file)
		local initial_colors = read_ascii_frames(colors_file)
		if #initial_frames > 0 then
			dashboard.section.header.val = initial_frames[1]
			dashboard.section.header.opts.hl = colorize(initial_colors[1], cloneTable(color_codes))
		end
	end
end

-- start animation after alpha is ready
M.init_animation = function(dashboard, alpha, animation_file, colors_file, color_codes, frame_delay)
	vim.api.nvim_create_autocmd("User", {
		pattern = "AlphaReady",
		callback = function()
			create_animation_timer(dashboard, alpha, animation_file, colors_file, color_codes, frame_delay)
		end,
	})
end

return M
