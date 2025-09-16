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

local function handle_write_mode(entry_path, options)
    local entry_timestamp = journal.format_entry_timestamp()
    file.append_to_file(entry_path, entry_timestamp)

    if str.is_nonempty_string(options.entry_text) then
      local entry_text = journal.format_entry_prefix() .. options.entry_text
      file.append_to_file(entry_path, entry_text)
      os.exit(0)
    end
end

local function launch_editor(path)
  local command = "nvim + '" .. path .. "'"
  os.execute(command)
end

local function main()
  libexec.setup()

  local options = cli.parse_args(arg)
  if options.help then
    cli.print_help()
    return
  end

  local configs = config.load()
  local output_dir = configs.base_dir
  local entry_path = journal.get_todays_entry_path(output_dir)
  file.create_dir(entry_path)
  local header = journal.format_date_header()
  file.create_file(entry_path, header)

  if options.write_mode then
    handle_write_mode(entry_path, options)
  end

  launch_editor(entry_path)
end

-- Run the app
main()
