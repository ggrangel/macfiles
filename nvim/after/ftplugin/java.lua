local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")

local data_dir = "/Users/ggrangel/.local/share/jdtls/data/" .. project_name

local ws_folders_lsp = {}
local ws_folders_jdtls = {}
if root_dir then
    local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r")
    if file then
        for line in file:lines() do
            table.insert(ws_folders_lsp, line)
            table.insert(ws_folders_jdtls, string.format("file://%s", line))
        end
        file:close()
    end
end

local config = {
    root_dir = root_dir,
    cmd = {
        "/Library/Java/JavaVirtualMachines/jdk-17.0.4.jdk/Contents/Home/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. "/Users/ggrangel/.config/nvim/configuration/java/lombok.jar",
        "-jar",
        "/Users/ggrangel/.config/nvim/configuration/java/jdt-language-server-1.6.0-202111261512/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        "-configuration",
        "/Users/ggrangel/.config/nvim/configuration/java/jdt-language-server-1.6.0-202111261512/config_mac/",
        "-data",
        data_dir,
    },
    init_options = {
        workspaceFolders = ws_folders_jdtls,
    },
    settings = {
        -- java = {
        --     format = {
        --         url = "/Users/ggrangel/.config/nvim/configuration/java/fintech-business-checkstyle.xml",
        --     },
        -- },
    },
}

require("jdtls").start_or_attach(config)

-- for _, line in ipairs(ws_folders_lsp) do
--     vim.lsp.buf.add_workspace_folder(line)
-- end
