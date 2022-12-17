Exps = {
    [1] = 2000,
    [2] = 3000,
    [3] = 3500,
    [4] = 5000,
    [5] = 8000,
    [6] = 8200,
    [7] = 8500,
    [8] = 9000,
    [9] = 10000,
    [10] = 11000,
}

function importLevels()
    return Exps
end

function test()
    local data = getElementData(localPlayer, "level:data")
    print(data)
end
addEventHandler("test", test)