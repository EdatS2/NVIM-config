require("codecompanion").setup({
    adapters = {
        ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
                env = {
                    url = "https://192.168.88.181:8000",
                    api_key = "OLLAMA_API_KEY",
                },
                headers = {
                    ["Content-Type"] = "application/json",
                    ["Authorization"] = "Bearer ${api_key}",
                },
                parameters = {
                    sync = true,
                },
            })
        end,
    },
    strategies = {
        chat = {
            adapter = "ollama",
        },
        inline = {
            adapter = "ollama",
        },
    },
})
