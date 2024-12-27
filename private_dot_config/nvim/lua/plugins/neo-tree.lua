return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				hijack_netrw_behavior = "open_current",
			},
		})
		vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right toggle<CR>", {})
	end,
}
--nnoremap / :Neotree toggle current reveal_force_cwd<cr>
--nnoremap | :Neotree reveal<cr>
--nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
--nnoremap <leader>b :Neotree toggle show buffers right<cr>
--nnoremap <leader>s :Neotree float git_status<cr>
