local lsp = require('lsp-zero')
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
lspconfig.clangd.setup{capabilties=capabilities, cmd={ "clangd", "-header-insertion=never"}}
lspconfig.nixd.setup{capabilties=capabilities}
lspconfig.bashls.setup{capabilties=capabilities}
lspconfig.jedi_language_server.setup{capabilties=capabilities}
lspconfig.ansiblels.setup{capabilties=capabilities}
lspconfig.docker_compose_language_service.setup{capabilties=capabilities}
lspconfig.lua_ls.setup{capabilties=capabilities}
lspconfig.texlab.setup{capabilties=capabilities}
lspconfig.zls.setup{capabilities=capabilities}
lspconfig.marksman.setup{capabilities=capabilities}

-- cmp setup
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = cmp.config.sources({
        { name = 'path', priority = 1250 },
        { name = 'omni', priority = 1250 },
        { name = 'nvim_lsp', priority = 750 },
        { name = 'luasnip', priority = 500 },
        { name = 'codecompanion', priority = 950 },
    }),
    mapping = cmp.mapping.preset.insert({
        -- Confirm completion
--        ['<Tab>'] = cmp.mapping.confirm({select = true}),

        -- Trigger completion menu
        ['<A-Enter>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholders
        ['<C-f>'] = cmp.mapping(cmp_action.luasnip_jump_forward(), {"i","s"}),
        ['<C-b>'] = cmp.mapping(cmp_action.luasnip_jump_backward(), {"i","s"}),

        -- Scroll through completions
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    }),
    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body)
    end,
},
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev)
    vim.keymap.set('n', '<leader>lo', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end, opts)
    vim.keymap.set('n', '<leader>rn', function ()
        vim.lsp.buf.rename()
    end, opts)
end)

lsp.setup()
