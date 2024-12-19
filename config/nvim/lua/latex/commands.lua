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
		vim.api.nvim_put(full_mat, "l", true, false)
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
--
