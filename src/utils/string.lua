local M = {}

function M.is_nonempty_string(s)
  return s and s ~= "" and s:match("%a") ~= nil
end

return M
