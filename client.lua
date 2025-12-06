local skinShop = {
    currentSkin = 1,
    previewPed = nil,
    skinsList = nil,
    gui = {
        closeButton = nil,
        window = nil,
        prevSkinButton = nil,
        nextSkinButton = nil,
        selectSkinButton = nil,
        skinNameLabel = nil,
        skinPriceLabel = nil
    }
}

function createPreviewPed()
    if not isElement(skinShop.previewPed) then
        skinShop.previewPed = createPed(0, 181.0801, -88.2861, 1002.0307, 90)
        setElementInterior(skinShop.previewPed, 18)
    end

    local skinID = skinShop.skinsList[skinShop.currentSkin].id
    setElementModel(skinShop.previewPed, skinID)
    
    local skinName = skinShop.skinsList[skinShop.currentSkin].name
    local skinPrice = skinShop.skinsList[skinShop.currentSkin].price
    local priceText = skinPrice == 0 and "FREE" or ("$" .. skinPrice)
    
    guiSetText(skinShop.gui.skinNameLabel, skinName)
    guiSetText(skinShop.gui.skinPriceLabel, priceText)
end

function changeSkin(offset)
    skinShop.currentSkin = skinShop.currentSkin + offset
    if skinShop.currentSkin > #skinShop.skinsList then
        skinShop.currentSkin = 1
    elseif skinShop.currentSkin < 1 then
        skinShop.currentSkin = #skinShop.skinsList
    end
    createPreviewPed()
end

function createSkinShopGUI()
    local screenW, screenH = guiGetScreenSize()
    
    -- Create close button (top right corner)
    skinShop.gui.closeButton = guiCreateButton(screenW - 90, 20, 70, 40, "X", false)
    guiSetProperty(skinShop.gui.closeButton, "AlwaysOnTop", "True")
    
    -- Create select window (centered at bottom)
    skinShop.gui.window = guiCreateWindow(screenW/2 - 192, screenH - 220, 385, 150, "Skin Shop", false)
    guiWindowSetMovable(skinShop.gui.window, false)
    guiWindowSetSizable(skinShop.gui.window, false)
    guiSetProperty(skinShop.gui.window, "AlwaysOnTop", "True")
    
    -- Create skin control buttons inside the window
    skinShop.gui.prevSkinButton = guiCreateButton(28, 75, 72, 51, "<", false, skinShop.gui.window)
    skinShop.gui.nextSkinButton = guiCreateButton(286, 75, 72, 51, ">", false, skinShop.gui.window)
    skinShop.gui.selectSkinButton = guiCreateButton(108, 75, 170, 51, "Select Skin", false, skinShop.gui.window)

    -- Configure button styles
    local buttons = {
        skinShop.gui.closeButton, 
        skinShop.gui.prevSkinButton, 
        skinShop.gui.nextSkinButton, 
        skinShop.gui.selectSkinButton
    }
    
    for _, button in ipairs(buttons) do
        guiSetProperty(button, "NormalTextColour", "FFFFFFFF")    -- White text
        guiSetProperty(button, "HoverTextColour", "FFFFD700")     -- Gold text on hover
        guiSetProperty(button, "PressedTextColour", "FFAAAAAA")   -- Gray text on click
        guiSetProperty(button, "NormalBackgroundColour", "FF2C2C2C80")  -- Dark semi-transparent
        guiSetProperty(button, "HoverBackgroundColour", "FF1E1E1EB0")   -- Darker on hover
        guiSetProperty(button, "PressedBackgroundColour", "FF000000B0")  -- Black on click
        guiSetProperty(button, "Border", "Normal")
    end
    
    -- Special styling for close button (red theme)
    guiSetProperty(skinShop.gui.closeButton, "NormalBackgroundColour", "FF8B000080")  -- Dark red
    guiSetProperty(skinShop.gui.closeButton, "HoverBackgroundColour", "FFFF0000B0")   -- Bright red on hover
    
    -- Special styling for select skin button (green theme)
    guiSetProperty(skinShop.gui.selectSkinButton, "NormalBackgroundColour", "FF00640080")  -- Dark green
    guiSetProperty(skinShop.gui.selectSkinButton, "HoverBackgroundColour", "FF00FF00B0")   -- Bright green on hover
    
    -- Style the window
    guiSetProperty(skinShop.gui.window, "CaptionColour", "FFFFFFFF")
    guiSetProperty(skinShop.gui.window, "BackgroundColour", "FF1A1A1AD0")
    
    -- Skin name label
    skinShop.gui.skinNameLabel = guiCreateLabel(0, 30, 385, 25, "", false, skinShop.gui.window)
    guiLabelSetHorizontalAlign(skinShop.gui.skinNameLabel, "center")
    guiLabelSetVerticalAlign(skinShop.gui.skinNameLabel, "center")
    guiLabelSetColor(skinShop.gui.skinNameLabel, 255, 255, 255) -- White color
    
    -- Skin price label
    skinShop.gui.skinPriceLabel = guiCreateLabel(0, 55, 385, 25, "", false, skinShop.gui.window)
    guiLabelSetHorizontalAlign(skinShop.gui.skinPriceLabel, "center")
    guiLabelSetVerticalAlign(skinShop.gui.skinPriceLabel, "center")
    guiLabelSetColor(skinShop.gui.skinPriceLabel, 255, 215, 0) -- Gold color

    -- Mouse events for visual effects
    addEventHandler("onClientMouseEnter", getRootElement(),
    function ()
        if source == skinShop.gui.closeButton or source == skinShop.gui.prevSkinButton or 
           source == skinShop.gui.nextSkinButton or source == skinShop.gui.selectSkinButton then
            guiSetAlpha(source, 0.8)
        end
    end)

    addEventHandler("onClientMouseLeave", getRootElement(),
    function ()
        if source == skinShop.gui.closeButton or source == skinShop.gui.prevSkinButton or 
           source == skinShop.gui.nextSkinButton or source == skinShop.gui.selectSkinButton then
            guiSetAlpha(source, 1)
        end
    end)

    -- Click events
    addEventHandler("onClientGUIClick", getRootElement(),
    function ()
        if source == skinShop.gui.closeButton then
            closeSkinShop()
        elseif source == skinShop.gui.prevSkinButton then
            changeSkin(-1)
        elseif source == skinShop.gui.nextSkinButton then
            changeSkin(1)
        elseif source == skinShop.gui.selectSkinButton then
            triggerServerEvent("onPlayerSelectSkin", localPlayer, 
                skinShop.skinsList[skinShop.currentSkin].id, 
                skinShop.skinsList[skinShop.currentSkin].price)
        end
    end)
end

addEvent("showSkinShopPanel", true)
addEventHandler("showSkinShopPanel", resourceRoot, function(receivedSkinsList)
    skinShop.skinsList = receivedSkinsList
    skinShop.currentSkin = 1

    setCameraMatrix(177.61839294434, -88.623497009277, 1002.772277832, 178.60823059082, -88.525047302246, 1002.6696166992)
    
    if not isElement(skinShop.gui.closeButton) then
        createSkinShopGUI()
    else
        guiSetVisible(skinShop.gui.closeButton, true)
        guiSetVisible(skinShop.gui.window, true)
    end
    
    showCursor(true)
    createPreviewPed()
end)

function closeSkinShop()
    if isElement(skinShop.gui.closeButton) then
        guiSetVisible(skinShop.gui.closeButton, false)
    end
    if isElement(skinShop.gui.window) then
        guiSetVisible(skinShop.gui.window, false)
    end
    setCameraTarget(localPlayer) 
    showCursor(false)
    skinShop.currentSkin = 1
    if isElement(skinShop.previewPed) then
        destroyElement(skinShop.previewPed)
        skinShop.previewPed = nil
    end
end

addEvent("hideSkinShopPanel", true)
addEventHandler("hideSkinShopPanel", resourceRoot, function()
    closeSkinShop()
end)
