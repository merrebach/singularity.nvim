local function get_hl(name)
	return vim.api.nvim_get_hl(0, { name = name, link = false })
end

describe("singularity highlights", function()
	before_each(function()
		local cfg = require("singularity.config")
		cfg.italic = true
		cfg.bold   = true
		cfg.overrides = {}
		cfg.integrations = {
			treesitter = true, lsp = true, python = true,
			typescript = true, rust = true, window_groups = true,
		}
		require("singularity").load()
	end)

	it("sets Normal highlight", function()
		local hl = get_hl("Normal")
		assert.is_not_nil(hl.fg)
	end)

	it("@keyword is not italic (control flow)", function()
		local hl = get_hl("@keyword")
		assert.is_not_true(hl.italic)
	end)

	it("@keyword.function is italic (declaration axis)", function()
		local hl = get_hl("@keyword.function")
		assert.is_true(hl.italic)
	end)

	it("@function is not italic", function()
		local hl = get_hl("@function")
		assert.is_not_true(hl.italic)
	end)

	it("@function.builtin is italic (foreign axis)", function()
		local hl = get_hl("@function.builtin")
		assert.is_true(hl.italic)
	end)

	it("@type.definition is bold (definition site)", function()
		local hl = get_hl("@type.definition")
		assert.is_true(hl.bold)
	end)

	it("@type is not bold (plain reference)", function()
		local hl = get_hl("@type")
		assert.is_not_true(hl.bold)
	end)

	it("@comment is italic (organizational axis)", function()
		local hl = get_hl("@comment")
		assert.is_true(hl.italic)
	end)

	it("GroupsActive is defined", function()
		local hl = get_hl("GroupsActive")
		assert.is_not_nil(hl.fg or hl.bg)
	end)

	describe("with italic = false", function()
		before_each(function()
			require("singularity").setup({ italic = false })
			require("singularity").load()
		end)

		it("@keyword.function is not italic", function()
			local hl = get_hl("@keyword.function")
			assert.is_not_true(hl.italic)
		end)

		it("@function.builtin is not italic", function()
			local hl = get_hl("@function.builtin")
			assert.is_not_true(hl.italic)
		end)

		it("@comment is not italic", function()
			local hl = get_hl("@comment")
			assert.is_not_true(hl.italic)
		end)
	end)

	describe("with bold = false", function()
		before_each(function()
			require("singularity").setup({ bold = false })
			require("singularity").load()
		end)

		it("@type.definition is not bold", function()
			local hl = get_hl("@type.definition")
			assert.is_not_true(hl.bold)
		end)
	end)
end)
