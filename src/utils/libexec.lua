local M = {}

-- Call this at the start of main.lua
function M.setup()
    -- Determine directory of the running script
    local libexec_dir = arg[0]:match("(.*/)")
    
    -- Prepend paths to package.path
    package.path = table.concat({
        libexec_dir .. "?.lua",
        libexec_dir .. "?/init.lua",
        libexec_dir .. "utils/?.lua",
        package.path
    }, ";")
end

return M
