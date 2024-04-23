local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')

lsp.preset('recommended')

lsp.setup_servers({'dartls', force = true})

-- Settings for LSPs
lspconfig.ltex.setup({
    settings = {
        additionalRules = {
            enablePickyRules = true,
        },
    },
})
lspconfig.clangd.setup{}
lspconfig.nixd.setup{}
lspconfig.bashls.setup{}
lspconfig.jedi_language_server.setup{}
lspconfig.ansiblels.setup{}
lspconfig.docker_compose_language_service.setup{}
lspconfig.lua_ls.setup{}
lspconfig.texlab.setup{}

-- cmp setup
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = cmp.config.sources({
        { name = 'path', priority = 1250 },
        { name = 'omni', priority = 1250 },
        { name = 'nvim_lsp', priority = 750 },
        { name = 'luasnip', priority = 500 },
    }),
    mapping = cmp.mapping.preset.insert({
        -- Confirm completion
        ['<Tab>'] = cmp.mapping.confirm({select = true}),

        -- Trigger completion menu
        ['<A-Enter>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholders
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- Scroll through completions
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    })
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<A-Enter>', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<leader>lo', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
end)

lsp.setup()
