local M = {}

local str_utils = require("utils/string")

function M.parse_args(args)
  local options = {
    mode = "default", -- "default", "write", "search", "help"
    text = "" -- entry_text for write mode, search_query for search mode
  }

  local mode_map = {
    ["-w"] = "write", ["--write"] = "write",
    ["-s"] = "search", ["--search"] = "search",
    ["-h"] = "help", ["--help"] = "help"
  }

  for i, arg in ipairs(args) do
    if mode_map[arg] then
      options.mode = mode_map[arg]
      local text_arg = args[i + 1]
      if text_arg and str_utils.is_nonempty_string(text_arg) then
        options.text = text_arg
      end
    end
  end

  return options
end

function M.print_help()
  print([[
Captain's Log ⚓ - A simple command-line daily journaling tool

Usage: clog [options] [text]

Options:
  -w, --write <text>   Add timestamped entry to today's log
                       Requires text argument
  -s, --search <query> Search through all journal entries
                       Requires search query
  -h, --help           Show this help message

Examples:
  clog                    Create or open today's entry
  clog -w "Quick note"    Add entry without opening editor
  clog -s "project notes" Search for "project notes" in all entries
]])
end

return M