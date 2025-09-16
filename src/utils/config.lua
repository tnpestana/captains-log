local M = {}

local default_config = {
  base_dir = os.getenv("HOME") .. "/Documents/captains-log"
}

function M.get_config_path()
  local config_dir = os.getenv("XDG_CONFIG_HOME") or
                     os.getenv("HOME") .. "/.config"
  return config_dir .. "/captains-log/config.lua"
 end

function M.load()
  local config_path = M.get_config_path()
  local success, config = pcall(dofile, config_path)

  if success then
    return config
  else
    return default_config
  end
end

return M
