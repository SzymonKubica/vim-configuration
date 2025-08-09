--===[ Telescope Configuration ]===--
local telescope = require("telescope")

-- Set up Telescope to handle LSP code actions selections (this is needed
-- to display the choices closer to the cursor instead of showing them
-- in the vim command line at the bottom).
telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}

telescope.load_extension("ui-select")
