local M = {}

local file = require("utils/file")

function M.find_all_entries(base_dir)
  local entries = {}
  local find_command = string.format("find '%s' -name '*.md' -type f 2>/dev/null", base_dir)
  local handle = io.popen(find_command)

  if handle then
    for line in handle:lines() do
      table.insert(entries, line)
    end
    handle:close()
  end

  return entries
end

function M.search_in_file(file_path, query)
  local matches = {}
  local file_handle = io.open(file_path, "r")

  if not file_handle then
    return matches
  end

  local line_number = 0
  local query_lower = string.lower(query)

  for line in file_handle:lines() do
    line_number = line_number + 1
    local line_lower = string.lower(line)

    if string.find(line_lower, query_lower, 1, true) then
      table.insert(matches, {
        line_number = line_number,
        content = line,
        file_path = file_path
      })
    end
  end

  file_handle:close()
  return matches
end

function M.search_entries(base_dir, query)
  if not query or query == "" then
    print("Error: Search query cannot be empty")
    return
  end

  local entries = M.find_all_entries(base_dir)
  local total_matches = 0

  for _, entry_path in ipairs(entries) do
    local matches = M.search_in_file(entry_path, query)

    if #matches > 0 then
      -- Extract date from path (YYYY/MM/DD.md)
      local date_part = string.match(entry_path, "(%d%d%d%d/%d%d/%d%d)%.md$")
      if date_part then
        print("\n" .. date_part .. ":")
        for _, match in ipairs(matches) do
          print("  " .. match.line_number .. ": " .. match.content)
        end
        total_matches = total_matches + #matches
      end
    end
  end

  if total_matches == 0 then
    print("No matches found for: " .. query)
  else
    print("\nFound " .. total_matches .. " matches")
  end
end

return M