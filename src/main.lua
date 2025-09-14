local function get_todays_entry_path(dir)
  local now = os.date('*t')
  local year, month, day = now.year, now.month, now.day
  local path = string.format("%s/%04d/%02d/%02d.md", dir, year, month, day)
  return path
end

local function parse_args(args)
  local options = {
    write_mode = false
  }

  for i, arg in ipairs(args) do
    if arg == "-w" then
      options.write_mode = true
    end
  end

  return options
end

local function launch_editor(path)
  local command = "nvim + '" .. path .. "'"
  os.execute(command)
end

local function main()
  -- Add the current script's directory to Lua's module path
  local script_dir = debug.getinfo(1, "S").source:match("@(.*/)")
  if script_dir then
    package.path = package.path .. ";" .. script_dir .. "?.lua"
    package.path = package.path .. ";" .. script_dir .. "?/init.lua"
  end

  local libexec = require("utils/libexec")
  local file_utils = require("utils/file")

  libexec.setup()

  -- Parse command-line arguments
  local options = parse_args(arg)

  local home_dir = os.getenv("HOME")
  local entry_dir = home_dir .. "/Documents/CaptainsLog"
  file_utils.create_dir(entry_dir)

  local entry_path = get_todays_entry_path(entry_dir)

  if options.write_mode then
    -- Write mode: append a new timestamped entry
    local date_str = os.date("%A, %B %d, %Y")
    local entry_header = "# Captain's Log - " .. date_str .. "\n\n"
    file_utils.create_dir(entry_path)
    file_utils.create_file(entry_path, entry_header)

    local time_str = os.date("%H:%M")
    local timestamp_entry = "\n## " .. time_str .. "\n\n"
    file_utils.append_to_file(entry_path, timestamp_entry)
  else
    -- Normal mode: create file if doesn't exist
    local date_str = os.date("%A, %B %d, %Y")
    local entry_header = "# Captain's Log - " .. date_str .. "\n\n"
    file_utils.create_dir(entry_path)
    file_utils.create_file(entry_path, entry_header)
  end

  launch_editor(entry_path)
end

-- Run the app
main()
