local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Settings for LSPs
vim.lsp.config("ltex", {
    filetypes = { 'bib', 'gitcommit', 'markdown', 'org', 'plaintex', 'rst', 'rnoweb', 'tex', 'pandoc', 'quarto', 'rmd', 'context', 'html', 'xhtml', 'mail', 'text' },
    settings = {
        additionalRules = {
            enablePickyRules = true,
        },
    },
})
vim.lsp.enable("ltex")
vim.lsp.config("clangd",
    { capabilities = capabilities, 
    cmd = require('devcontainers').lsp_cmd({ "clangd", "-header-insertion=never", "--query-driver=/opt/sdk-jetson-*/*/*/usr/bin/*/*-g++"}), 
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    -- Use the OUTERMOST .git (the git superproject) so files inside git
    -- submodules root at the top-level repo and reuse its single devcontainer,
    -- instead of trying to boot a second container per submodule.
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root
        for dir in vim.fs.parents(fname) do
            if vim.uv.fs_stat(dir .. '/.git') then
                root = dir -- keep going; last match = outermost .git
            end
        end
        on_dir(root)
    end})
vim.lsp.config("nixd", {
    capabilities = capabilities,
    filetypes = { 'nix' },
    settings = {
        nixd = {
            nixpkgs = { expr = "import <nixpkgs> {}" },
        },
    },
})
-- vim.lsp.config("bashls", { capabilities = capabilities, filetypes = { 'bash', 'sh' } })
-- -- lspconfig.jedi_language_server.setup{capabilities=capabilities}
vim.lsp.config("pyright", { capabilities = capabilities })
-- vim.lsp.config("lua_ls", { capabilities = capabilities, filetypes = { 'lua' } })
-- vim.lsp.config("texlab", { capabilities = capabilities, filetypes = { 'tex', 'plaintex', 'bib' } })
-- vim.lsp.config("zls", { capabilities = capabilities, filetypes = { 'zig', 'zir' } })
-- vim.lsp.config("marksman", { capabilities = capabilities, filetypes = { 'markdown', 'markdown.mdx' } })
vim.lsp.config("typescript-language-server",
    { capabilities = capabilities, cmd = { "typescript-language-server", "--stdio" }, filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } })
vim.lsp.enable({ 'clangd', 'nixd', 'pyright', 'typescript-language-server' })

vim.cmd [[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd('LspAttach', {

    group = vim.api.nvim_create_augroup('my.lsp', {}),

    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        -- if client:supports_method('textDocument/implementation') then
        --
        --   -- Create a keymap for vim.lsp.buf.implementation ...
        --
        -- end



        -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|

        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!

            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end

            client.server_capabilities.completionProvider.triggerCharacters = chars



            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end



        -- Auto-format ("lint") on save.

        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".

        if not client:supports_method('textDocument/willSaveWaitUntil')

            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {

                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),

                buffer = ev.buf,

                callback = function()
                    vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
                end,

            })
        end
    end,

})

-- cmp setup
local cmp = require('cmp')

cmp.setup({
    sources = cmp.config.sources({
        { name = 'path',          priority = 1250 },
        { name = 'omni',          priority = 1250 },
        { name = 'nvim_lsp',      priority = 750 },
        { name = 'luasnip',       priority = 500 },
        { name = 'codecompanion', priority = 950 },
    }),
    mapping = cmp.mapping.preset.insert({
        -- Confirm completion
        --        ['<Tab>'] = cmp.mapping.confirm({select = true}),

        -- Trigger completion menu
        ['<A-Enter>'] = cmp.mapping.complete(),

        -- -- Navigate between snippet placeholders
        -- ['<C-f>'] = cmp.mapping(cmp_action.luasnip_jump_forward(), {"i","s"}),
        -- ['<C-b>'] = cmp.mapping(cmp_action.luasnip_jump_backward(), {"i","s"}),

        -- Scroll through completions
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    }),
    snippet = {
        expand = function(args)
            -- require('luasnip').lsp_expand(args.body)
            vim.snippet.expand(args.body)
        end,
    },
})

-- vim.lsp.on_attach(function(client, bufnr)
--     local opts = {buffer = bufnr, remap = false}
--     vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format() end, opts)
--     vim.keymap.set('n', '<leader>rn', function ()
--         vim.lsp.buf.rename()
--     end, opts)
-- end)
--
-- vim.lsp.setup()
