describe("singularity.load()", function()
	before_each(function()
		-- Reset config to defaults
		local cfg = require("singularity.config")
		cfg.italic = true
		cfg.bold   = true
		cfg.overrides = {}
		cfg.integrations = {
			treesitter = true, lsp = true, python = true,
			typescript = true, rust = true, window_groups = true,
		}
	end)

	it("loads without error", function()
		local ok = require("singularity").load()
		assert.is_true(ok)
	end)

	it("sets vim.g.colors_name to 'singularity'", function()
		require("singularity").load()
		assert.equals("singularity", vim.g.colors_name)
	end)

	it("loads with italic = false without error", function()
		require("singularity").setup({ italic = false })
		local ok = require("singularity").load()
		assert.is_true(ok)
	end)

	it("loads with bold = false without error", function()
		require("singularity").setup({ bold = false })
		local ok = require("singularity").load()
		assert.is_true(ok)
	end)

	it("loads with all integrations disabled without error", function()
		require("singularity").setup({
			integrations = {
				treesitter = false, lsp = false, python = false,
				typescript = false, rust = false, window_groups = false,
			},
		})
		local ok = require("singularity").load()
		assert.is_true(ok)
	end)
end)
