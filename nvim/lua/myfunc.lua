function DBG(content)
    local file = io.open("/home/wu/.config/nvim/log.txt", "a+")
    if not file then
        error("Could not open file for writing")
    end

    file:write(content)
    file:close()
end

