-- VimTeX settings and binds

vim.api.nvim_create_user_command(
	"CreateLatexMatrix",
	function(opts) -- create a latex matrix at cursor with rows cols and env args.
		-- get args
		local rows = tonumber(opts.fargs[1])
		local cols = tonumber(opts.fargs[2])
		local env = tostring(opts.fargs[3])

		local err = ""
		if not rows or rows <= 0 then
			err = err .. "Rows invalid"
		end
		if not cols or cols <= 0 then
			err = err .. "Cols invalid"
		end
		if err ~= "" then
			return err
		end

		-- make matrix
		local full_mat = {}
		local line = "	" .. "(<>)" .. string.rep(" & (<>)", rows - 1) .. " \\" .. "\\" -- indent + first char + rest of chars + newline char
		table.insert(full_mat, "\\begin{" .. env .. "}")
		for var = 1, cols do
			table.insert(full_mat, line)
		end
		table.insert(full_mat, "\\end{" .. env .. "}")
		-- print matrix
		vim.api.nvim_put(full_mat, "c", true, false)
	end,
	{
		nargs = "*",
		desc = "CreateLaTeXMatrix rows cols env. Create a latex matrix environment with (<>) placeholder entires in the indecies. ",
	}
)

vim.api.nvim_create_user_command(
	"PromptLatexMatrix",
	function() -- prompt user for line and col and create matrix at cursor
		-- get user input
		local rows = tonumber(vim.fn.input("Rows: "))
		if not rows or rows <= 0 then
			print("Invalid number of rows.")
			return
		end
		local cols = tonumber(vim.fn.input("Cols:"))
		if not cols or cols <= 0 then
			print("Invalid number of rows.")
			return
		end

		local env = tostring(vim.fn.input("Matrix (default is placeholder): ")) -- default is placeholder
		if not env or env == "" then
			env = "(<>)"
		end
		vim.cmd("CreateLatexMatrix " .. tostring(rows) .. " " .. tostring(cols) .. " " .. env)
	end,
	{}
)
-- CreateLaTeXMatrix rows cols pmatrix
--[[
-- \begin{pmatrix}
-- (<>) & (<>) ... & (<>) \\
-- (<>) & (<>) ... & (<>) \\
-- (<>) & (<>) ... & (<>) \\
-- ...
-- \end{pmatrix}
--]]
--

vim.api.nvim_create_user_command(
	"CreateLatexCycle",
	function(opts) -- create a len cycle with spacing dividers (default \quad)
		-- get args
		local len = tonumber(opts.fargs[1])
		local spacing = tostring(opts.fargs[2])

		local err = "" --verify user input
		if not len or len <= 0 then
			err = err .. "Len invalid"
		end
		if spacing == "" then
			spacing = "\\quad"
		end

		if err ~= "" then
			return err
		end

		-- make cycle
		local line = "( " .. "(<>) " .. string.rep(spacing .. " (<>) ", len - 1) .. ")" -- indent + first char + rest of chars + newline char
		-- print cycle
		vim.api.nvim_put({ line }, "c", true, false)
		vim.cmd("%") -- for some reason cursor is being moved, this moves it back.
	end,
	{
		nargs = "*",
		desc = "CreateLaTeXCycle len spacing. Create a latex cycle of the form (a ... b) with length `len` and element spacing `spacing`. (<>) placeholder entires in the indecies. ",
	}
)

vim.api.nvim_create_user_command(
	"PromptLatexCycle",
	function() -- prompt user for line and col and create matrix at cursor
		-- get user input
		local len = tonumber(vim.fn.input("Cycle Length: "))
		if not len or len <= 0 then
			print("Invalid Length.")
			return
		end

		local spacing = tostring(vim.fn.input("Spacing style (default is '\\quad'): ")) -- default is placeholder
		if not spacing or spacing == "" then
			spacing = "\\quad"
		end
		vim.cmd("CreateLatexCycle " .. tostring(len) .. " " .. spacing)
	end,
	{}
)

vim.api.nvim_create_user_command("CreateLatexList", function(opts) -- Create a latex list env with len items[suffix]
	-- get args
	local env = tostring(opts.fargs[1] or "")
	local len = tonumber(opts.fargs[2])
	local suffix = tostring(opts.fargs[3] or "")

	local err = "" --verify user input

	if not env or env == "" then
		env = "(<>)"
	end

	if not len or len <= 0 then
		err = err .. "Len invalid"
	end

	suffix = suffix or "" -- sets default value for suffix

	if err ~= "" then
		return err
	end

	-- make list
	local full_list = {}
	local line = "	\\item" .. suffix .. " (<>)"
	table.insert(full_list, "\\begin{" .. env .. "}")
	for var = 1, len do
		table.insert(full_list, line)
	end
	table.insert(full_list, "\\end{" .. env .. "}")
	-- print matrix
	vim.api.nvim_put(full_list, "c", true, false)
end, {
	nargs = "*",
	desc = "CreateLaTeXList env len suffix. Create a latex list environment with (<>) placeholder entires in the items.",
})

vim.api.nvim_create_user_command(
	"PromptLatexList",
	function() -- prompt user for line and col and create matrix at cursor
		-- get user input
		local env = tostring(vim.fn.input("Type of list: ") or "")

		local len = tonumber(vim.fn.input("Number of bullet points:"))
		if not len or len <= 0 then
			print("Invalid Length.")
			return
		end

		local suffix = tostring(vim.fn.input("Suffix for each item: ") or "")

		vim.cmd("CreateLatexList " .. env .. " " .. tostring(len) .. " " .. suffix)
	end,
	{}
)

vim.api.nvim_create_user_command("LatexSurroundWrap", function(opts) -- Create a latex list env with len items[suffix]
	-- get args
	local env = tostring(opts.fargs[1] or "")
	local start_row, start_col = vim.fn.getpos("v")[2], vim.fn.getpos("v")[3]
	local end_row, end_col = vim.fn.getpos(".")[2], vim.fn.getpos(".")[3]

	-- make list
	-- set end of env
	vim.api.nvim_win_set_cursor(0, { end_row, end_col - 1 })
	vim.api.nvim_put({ "}" }, "c", true, false)

	--set start of env
	vim.api.nvim_win_set_cursor(0, { start_row, start_col - 1 })
	vim.api.nvim_put({ "\\" .. env .. "{" }, "c", false, false)

	--set back to previous pos
	vim.api.nvim_win_set_cursor(0, { end_row, end_col - 1 })
	vim.api.nvim_input("<Esc>") -- go back to normal mode
end, {
	nargs = "*",
	desc = "CreateLaTeXList env len suffix. Create a latex list environment with (<>) placeholder entires in the items.",
})

vim.api.nvim_create_user_command(
	"PromptLatexSurroundWrap",
	function() -- prompt user for line and col and create matrix at cursor
		-- get user input
		local cmd = tostring(vim.fn.input("Command: ") or "")

		vim.cmd("LatexSurroundWrap " .. cmd)
	end,
	{}
)
