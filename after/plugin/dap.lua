local dap = require("dap")

-- Adapters
-- codelldb >= 1.11.0 supports stdio DAP directly
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
}
-- cpptools/AD7 (gdb) - used by launch.json files with `"type": "cppdbg"`
dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "OpenDebugAD7",
}

dap.defaults.fallback.switchbuf = "usevisible,usetab,newtab"

-- dap-ui
local dapui = require("dapui")
dapui.setup()

require("overseer").setup()

dap.event:subscribe("stopped", function()
  dapui.toggle()
end)

vim.keymap.set("n", "<F5>", dap.continue(), { desc = "DAP Start/Continue" })

-- Keymaps
vim.keymap.set("n", "[f", dap.up(), { desc = "DAP Up" })
vim.keymap.set("n", "]f", dap.down(), { desc = "DAP Down" })
vim.keymap.set("n", "<F7>", dap.focus_frame(), { desc = "DAP Focus Frame" })
vim.keymap.set("n", "<F8>", function()
  vim.ui.input({ prompt = "Log point message: " }, function(input)
    dap.set_breakpoint(nil, nil, input)
  end)
end, { desc = "Toggle Logpoint" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint(), { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over(), { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into(), { desc = "Step Into" })
vim.keymap.set("n", "<F16>", function()
  dap.terminate({ hierarchy = true })
end, { desc = "DAP Terminate" })
vim.keymap.set("n", "<F18>", dap.run_to_cursor(), { desc = "Run To Cursor" })
vim.keymap.set("n", "<F21>", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(input)
    dap.set_breakpoint(input)
  end)
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<F23>", dap.step_out(), { desc = "Step Out" })

-- Signs
for _, group in pairs({ "DapBreakpoint", "DapBreakpointCondition", "DapBreakpointRejected", "DapLogPoint" }) do
  vim.fn.sign_define(group, { text = "●" })
end
vim.fn.sign_define("DapStopped", { text = "󰎯", numhl = "debugPC" })
