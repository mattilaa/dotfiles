-- Set up nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

local util = require('lspconfig/util')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

-- robotframework_ls config
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- local root = vim.fn.system("git rev-parse --show-toplevel")
local root = "/home/mattilaa/ws/master/kcegc"
root = root:gsub("%s+$", "")

local pythonpath = {
    root .. "/tests/libraries",
    root .. "/tests/resources",
    root .. "/tests",
}

lsp.configure("robotframework_ls", {
   settings = {
      robot = {
         pythonpath = pythonpath,
         loadVariablesFromArgumentsFile = root .. "/.lsp.resource",
         variables = {
             EXECDIR = root .. "/tests",
         },
         lint = {
             keywordResolvesToMultipleKeywords = false,
         },
         libraries = {
             libdoc = {
                 needsArgs = {"common.libdcid", "terminals.py"},
             },
         },
      },
   },
})

lsp.configure("clangd", {
   cmd = {
        "clangd",
        "--clang-tidy",
        "--background-index",
        "--all-scopes-completion",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--cross-file-rename",
   },
   filetypes = { "c", "cpp", "objc", "objcpp" },
   root_dir = util.root_pattern("compile_commands.json", ".git"),
   settings = {
       clangd = {
           semanticHighlighting = true,
           completion = {
               filterAndSort = true,
           },
           diagnostics = {
               disabled = { "clang-diagnostic-unused-parameter" },
           },
       },
   },
})

lsp.setup()

vim.api.nvim_create_autocmd('LspAttach', {
group = vim.api.nvim_create_augroup('UserLspConfig', {}),
callback = function(ev)
   -- Enable completion triggered by <c-x><c-o>
   vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

   -- Buffer local mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   local opts = { buffer = ev.buf }
   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
   vim.keymap.set("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
   vim.keymap.set("n", "<space>e", "<cmd>Explore<cr>", opts)
   vim.keymap.set('v', '<leader>f', vim.lsp.buf.format, { remap = false })
   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
   vim.keymap.set('n', '<A-j>', ":m .+1<cr>", opts)
   vim.keymap.set('n', '<A-k>', ":m .-2<cr>", opts)
   -- vim.keymap.set('n', 'gn', vim.lsp.diagnostic.goto_next)
   -- vim.keymap.set('n', 'gp', vim.lsp.diagnostic.goto_next)
   -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
   -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
   -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
   -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
   -- vim.keymap.set('n', '<space>wl', function()
   --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   -- end, opts)
   -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
   -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
   -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
   -- vim.keymap.set('n', '<space>f', function()
   --   vim.lsp.buf.format { async = true }
   -- end, opts)
end,
})

