local script_dir = debug.getinfo(1, "S").source:match("@(.*/)")
if script_dir then
  package.path = package.path .. ";" .. script_dir .. "?.lua"
  package.path = package.path .. ";" .. script_dir .. "?/init.lua"
end

local libexec = require("utils/libexec")
local file = require("utils/file")
local str = require("utils/string")
local journal = require("utils/journal")
local config = require("utils/config")
local cli = require("utils/cli")
local search = require("utils/search")

local function handle_write_mode(entry_path, text)
    if not str.is_nonempty_string(text) then
      print("Error: -w flag requires text input")
      os.exit(1)
    end

    local entry_timestamp = journal.format_entry_timestamp()
    file.append_to_file(entry_path, entry_timestamp)

    local entry_text = journal.format_entry_prefix() .. text
    file.append_to_file(entry_path, entry_text)
    os.exit(0)
end

local function launch_editor(path, editor)
  local command = editor .. " '" .. path .. "'"
  os.execute(command)
end

local function main()
  libexec.setup()

  local options = cli.parse_args(arg)
  local configs = config.load()

  if options.mode == "help" then
    cli.print_help()
    return
  elseif options.mode == "search" then
    search.search_entries(configs.base_dir, options.text, true)
    return
  elseif options.mode == "regex" then
    search.search_entries(configs.base_dir, options.text, false)
    return
  elseif options.mode == "write" then
    local output_dir = configs.base_dir
    local entry_path = journal.get_todays_entry_path(output_dir)
    file.create_dir(entry_path)
    local header = journal.format_date_header()
    file.create_file(entry_path, header)
    handle_write_mode(entry_path, options.text)
  else
    -- Default mode: open today's entry in editor
    local output_dir = configs.base_dir
    local entry_path = journal.get_todays_entry_path(output_dir)
    file.create_dir(entry_path)
    local header = journal.format_date_header()
    file.create_file(entry_path, header)
    launch_editor(entry_path, configs.editor)
  end
end

-- Run the app
main()
