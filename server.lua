local skinsList = {
    -- Structure: {id = skin model, name = skin name, price = price}
    {id = 2, name = "Business Man", price = 5000},
    {id = 3, name = "Normal Guy", price = 0},
    {id = 4, name = "Young Man", price = 0},
    {id = 5, name = "Old Man", price = 0},
    {id = 6, name = "Business Woman", price = 5000},
    {id = 7, name = "Casual Guy", price = 4000},
    {id = 9, name = "Normal Girl", price = 0},
    {id = 10, name = "Young Girl", price = 0},
    {id = 13, name = "Old Woman", price = 0},
    {id = 14, name = "Worker", price = 0},
    {id = 15, name = "Mafia Boss", price = 8000},
    {id = 16, name = "Farmer", price = 0},
    {id = 17, name = "Biker", price = 4500},
    {id = 18, name = "Sportsman", price = 0},
    {id = 19, name = "Tourist", price = 0},
    {id = 20, name = "Student", price = 0},
    {id = 21, name = "Pilot", price = 6000},
    {id = 22, name = "Police Officer", price = 5500},
    {id = 23, name = "Military", price = 7000},
    {id = 24, name = "Mechanic", price = 0},
    {id = 25, name = "Artist", price = 0},
    {id = 26, name = "Gangster", price = 5000},
    {id = 27, name = "Clerk", price = 0},
    {id = 28, name = "Bodyguard", price = 6500},
    {id = 29, name = "Doctor", price = 0},
    {id = 30, name = "Chef", price = 0},
    {id = 31, name = "Teacher", price = 0},
    {id = 38, name = "Waitress", price = 0},
    {id = 39, name = "Casual Girl", price = 4000},
    {id = 40, name = "Shopkeeper", price = 0},
    {id = 41, name = "Housewife", price = 0},
    {id = 53, name = "Secretary", price = 0},
    {id = 54, name = "Student Girl", price = 0},
    {id = 55, name = "Tourist Girl", price = 0},
    {id = 56, name = "Dancer", price = 4500},
    {id = 63, name = "Fitness Girl", price = 4000},
    {id = 64, name = "Police Woman", price = 5500},
    {id = 69, name = "Mafia Lady", price = 8000},
    {id = 75, name = "Model", price = 6000},
    {id = 76, name = "Nurse", price = 5000},
    {id = 77, name = "Artist Girl", price = 0},
    {id = 85, name = "Executive", price = 7000},
    {id = 86, name = "Mechanic Girl", price = 0},
    {id = 87, name = "Military Woman", price = 6500},
}

local skinShopMarker = createMarker(161.4189, -84.2295, 1000.6, "cylinder", 1.5, 47, 122, 255, 150)
setElementInterior(skinShopMarker, 18)

addEventHandler("onMarkerHit", skinShopMarker, function(hitElement, matchingDimension)
    if matchingDimension and getElementType(hitElement) == "player" then
        triggerClientEvent(hitElement, "showSkinShopPanel", resourceRoot, skinsList)
    end
end)

addEventHandler("onMarkerLeave", skinShopMarker, function(leaveElement, matchingDimension)
    if matchingDimension and getElementType(leaveElement) == "player" then
        triggerClientEvent(leaveElement, "hideSkinShopPanel", resourceRoot)
        setCameraTarget(leaveElement, leaveElement)
        showCursor(leaveElement, false)
    end
end)

function onPlayerSelectSkin(skinID, skinPrice)
    local player = client
    local playerMoney = getPlayerMoney(player)
    
    if skinPrice > playerMoney then
        outputChatBox("[ERROR] You don't have enough money!", player, 255, 0, 0, true)
        return
    end
    
    takePlayerMoney(player, skinPrice)
    
    -- Find skin name
    local skinName = "Unknown"
    for _, skin in ipairs(skinsList) do
        if skin.id == skinID then
            skinName = skin.name
            break
        end
    end
    
    outputChatBox("[SUCCESS] Skin '" .. skinName .. "' purchased successfully!", player, 0, 255, 0, true)
    setElementModel(player, skinID)
    triggerClientEvent(player, "hideSkinShopPanel", resourceRoot)
end

addEvent("onPlayerSelectSkin", true)
addEventHandler("onPlayerSelectSkin", root, onPlayerSelectSkin)