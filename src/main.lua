local function get_todays_entry_path(dir)
  local now = os.date('*t')
  local year, month, day = now.year, now.month, now.day
  local path = string.format("%s/%04d/%02d/%02d.md", dir, year, month, day)
  return path
end

local function launch_editor(path)
  local command = "nvim '" .. path .. "'"
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

  local home_dir = os.getenv("HOME")
  local entry_dir = home_dir .. "/Documents/CaptainsLog"
  file_utils.create_dir(entry_dir)

  local entry_path = get_todays_entry_path(entry_dir)

  local date_str = os.date("%A, %B %d, %Y")
  local entry_content = "# Captain's Log - " .. date_str .. "\n\n"
  file_utils.create_dir(entry_path)  -- Create directories for the full file path
  file_utils.create_file(entry_path, entry_content)

  launch_editor(entry_path)
end

-- Run the app
main()
