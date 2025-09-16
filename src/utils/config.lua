local M = {}

local default_config = {
  base_dir = os.getenv("HOME") .. "/Documents/captains-log",
  editor = "vi"
}

function M.get_config_path()
  local config_dir = os.getenv("XDG_CONFIG_HOME") or
                     os.getenv("HOME") .. "/.config"
  return config_dir .. "/captains-log/config.lua"
 end

function M.load()
  local config_path = M.get_config_path()
  local success, user_config = pcall(dofile, config_path)

  local merged_config = {}

  for key, value in pairs(default_config) do
    merged_config[key] = value
  end

  if success and type(user_config) == "table" then
    for key, value in pairs(user_config) do
      merged_config[key] = value
    end
  end

  return merged_config
end

return M
