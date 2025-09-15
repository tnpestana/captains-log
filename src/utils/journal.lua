local M = {}

function M.get_todays_entry_path(dir)
  local now = os.date('*t')
  local year, month, day = now.year, now.month, now.day
  local path = string.format("%s/%04d/%02d/%02d.md", dir, year, month, day)
  return path
end

function M.format_date_header()
  local date_str = os.date("%A, %B %d, %Y")
  return "# Captain's Log - " .. date_str
end

function M.format_entry_timestamp()
  local time_str = os.date("%H:%M")
  local timestamp = "\n\n## " .. time_str
  return timestamp
end

function M.format_entry_prefix()
  local prefix = "\n"
  return prefix
end

return M
