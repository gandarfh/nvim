local dap = require("dap")

require("dap-install").setup({})

require("dap-install").config("python", {})

local original_notify = vim.notify
local retry_in_progress = false
local retry_count = 0
local max_retries = 30

local function try_attach()
	if retry_count >= max_retries then
		vim.notify("Máximo de tentativas de attach atingido.", vim.log.levels.WARN)
		retry_in_progress = false
		retry_count = 0
		return
	end

	retry_count = retry_count + 1
	vim.notify("Tentando attach (tentativa " .. retry_count .. " de " .. max_retries .. ")...", vim.log.levels.INFO)

	require("dap").run({
		type = "go",
		name = "Attach remote",
		mode = "remote",
		request = "attach",
		port = "2345",
	})

	vim.defer_fn(function()
		if require("dap").session() then
			vim.notify("Attach realizado com sucesso!", vim.log.levels.INFO)
			retry_in_progress = false
			retry_count = 0
		else
			vim.notify("Attach não realizado, tentando novamente...", vim.log.levels.INFO)
			try_attach() -- Tenta novamente
		end
	end, 500) -- aguarda 500ms para verificar se a sessão foi estabelecida
end

vim.notify = function(msg, level, opts)
	if msg and msg:match("Debug adapter disconnected") then
		if not retry_in_progress then
			retry_in_progress = true
			retry_count = 0
			try_attach()
		end
	end
	original_notify(msg, level, opts)
end

require("dap-go").setup({
	dap_configurations = {},
	delve = {
		path = "dlv",
		port = "${port}",
		args = {},
		build_flags = {},
		detached = true,
		cwd = nil,
	},
	tests = {
		verbose = false,
	},
})

require("dapui").setup({
	expand_lines = true,
	icons = { expanded = "", collapsed = "", circular = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			size = 0.20,
			position = "right",
		},
		{
			elements = {
				{ id = "repl", size = 1.00 },
				-- { id = "console", size = 0.30 },
			},
			size = 0.25,
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.25,
		max_width = 0.5, -- Floats will be treated as percentage of your screen.
		border = vim.g.rounded, -- Border style. Can be 'single', 'double' or 'rounded'
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

dap.configurations.go = {
	{
		type = "go",
		name = "Attach remote",
		mode = "remote",
		request = "attach",
		port = "2345",
	},
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		name = "Run gotestsum",
		type = "gotestsum", -- Referencia o adapter definido acima
		request = "launch",
		program = "./${relativeFileDirname}",
		showLog = true,
		logOutput = "dap",
		mode = "test",
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
		logOutput = "dap",
		showLog = true,
	},
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

dap.adapters.gotestsum = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local opts = {
		stdio = { nil, stdout },
		args = { "--format", "testname", "--watch", "--", "-coverprofile=cover.out" },
		detached = true,
	}

	handle, pid_or_err = vim.loop.spawn("gotestsum", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("gotestsum exited with code", code)
		end
	end)

	assert(handle, "Error running gotestsum: " .. tostring(pid_or_err))

	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)

	vim.defer_fn(function()
		callback({ type = "executable", command = "gotestsum", args = opts.args })
	end, 100)
end

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
