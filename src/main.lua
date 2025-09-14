local libexec = require("utils/libexec")
local file_utils = require("utils/file")
local str_utils = require("utils/string")

local function get_todays_entry_path(dir)
  local now = os.date('*t')
  local year, month, day = now.year, now.month, now.day
  local path = string.format("%s/%04d/%02d/%02d.md", dir, year, month, day)
  return path
end

local function parse_args(args)
  local options = {
    write_mode = false,
    entry_text = ""
  }

  for i, arg in ipairs(args) do
    if arg == "-w" then
      options.write_mode = true
      local entry_text = args[i + 1]
      if entry_text and str_utils.is_nonempty_string(entry_text) then
        options.entry_text = entry_text
      end
    end
  end

  return options
end

local function launch_editor(path)
  local command = "nvim + '" .. path .. "'"
  os.execute(command)
end

local function main()
  local script_dir = debug.getinfo(1, "S").source:match("@(.*/)")
  if script_dir then
    package.path = package.path .. ";" .. script_dir .. "?.lua"
    package.path = package.path .. ";" .. script_dir .. "?/init.lua"
  end


  libexec.setup()

  local options = parse_args(arg)

  local home_dir = os.getenv("HOME")
  local entry_dir = home_dir .. "/Documents/captains-log"
  file_utils.create_dir(entry_dir)

  local entry_path = get_todays_entry_path(entry_dir)

  if options.write_mode then
    local date_str = os.date("%A, %B %d, %Y")
    local entry_header = "# Captain's Log - " .. date_str
    file_utils.create_dir(entry_path)
    file_utils.create_file(entry_path, entry_header)

    local time_str = os.date("%H:%M")
    local entry_timestamp = "\n\n## " .. time_str
    file_utils.append_to_file(entry_path, entry_timestamp)

    if str_utils.is_nonempty_string(options.entry_text) then
      local entry_text = "\n" .. options.entry_text
      file_utils.append_to_file(entry_path, entry_text)
      return -- early return since the entry is complete
    end
  else
    local date_str = os.date("%A, %B %d, %Y")
    local entry_header = "# Captain's Log - " .. date_str .. "\n\n"
    file_utils.create_dir(entry_path)
    file_utils.create_file(entry_path, entry_header)
  end

  launch_editor(entry_path)
end

-- Run the app
main()
