local M = {}

-- Check if a file exists
function M.create_dir(path)
  local dir_path = string.match(path, "(.+)/[^/]+$")
  if dir_path then
    os.execute("mkdir -p '" .. dir_path .. "'")
  end
end

-- Create empty file with optional content
function M.create_file(path, content)
  local file = io.open(path, "r")
  if file then
    file:close()
    return
  end

  local new_file = io.open(path, "w")
  if new_file then
    new_file:write(content)
    new_file:close()
  else
    print("Error: could not create entry file")
  end
end

-- Append content to file
function M.append_to_file(path, content)
  local file = io.open(path, "a")
  if file then
    file:write(content)
    file:close()
  else
    print("Error: could not append to entry file")
  end
end


return M
