local M = {}

local str_utils = require("utils/string")

function M.parse_args(args)
  local options = {
    write_mode = false,
    entry_text = "",
    help = false
  }

  for i, arg in ipairs(args) do
    if arg == "-w" or arg == "--write" then
      options.write_mode = true
      local entry_text = args[i + 1]
      if entry_text and str_utils.is_nonempty_string(entry_text) then
        options.entry_text = entry_text
      end
    elseif arg == "-h" or arg == "--help" then
      options.help = true
    end
  end

  return options
end

function M.print_help()
  print([[
Captain's Log ⚓ - A simple command-line daily journaling tool

Usage: clog [options] [text]

Options:
  -w, --write [text]    Add timestamped entry to today's log
                        Optional text argument to add entry without opening editor
  -h, --help           Show this help message

Examples:
  clog                 Create or open today's entry
  clog -w              Add timestamped entry and open editor
  clog -w "Quick note" Add entry without opening editor
]])
end

return M