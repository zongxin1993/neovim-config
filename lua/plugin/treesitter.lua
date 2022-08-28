local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
	"bash",
	"c",
	"cpp",
	"cmake",
	"dockerfile",
	"json",
	"lua",
	"make",
	"markdown",
	"ninja",
	"python",
	"vim",
	"yaml"
	}, -- one of "all" or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python" } },
})
