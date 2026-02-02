return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 5000,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
			},
		})

		vim.keymap.set("n", "<leader>b", function()
			require("conform").format({ bufnr = 0 })
		end)
	end,
}
