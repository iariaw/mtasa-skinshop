local EnterPickup = createPickup(461.7012, -1500.7793, 31.0455, 3, 1318, 0)
createBlip(461.7012, -1500.7793, 31.0455, 45)
local ExitPickup = createPickup(161.4219, -97.1094, 1001.8047, 3, 1318, 0)
setElementInterior(ExitPickup, 18)

-- Function to handle entry into the Skin Shop
addEventHandler("onPickupHit", EnterPickup, function(thePlayer)
    local pWanted = getPlayerWantedLevel(thePlayer)
    if pWanted == 0 then
        if not isPedInVehicle(thePlayer) then
            outputChatBox("You are now entering the Skin Shop.", thePlayer, 255, 255, 255)
            setElementFrozen(thePlayer, true)
            setTimer(function()
                setElementPosition(thePlayer, 161.4219, -97.1094, 1001.8047)
                setElementInterior(thePlayer, 18)
                setElementRotation(thePlayer, 0, 0, 0, "default", true)
                fadeCamera(thePlayer, true)
                setElementFrozen(thePlayer, false)
            end, 1000, 1)
            fadeCamera(thePlayer, false)
        end
    else
        outputChatBox("You cannot enter the Skin Shop because you have a wanted level!", thePlayer, 255, 0, 0)
    end
end)

-- Function to handle exit from the Skin Shop
addEventHandler("onPickupHit", ExitPickup, function(thePlayer)
    outputChatBox("You are now leaving the Skin Shop.", thePlayer, 255, 255, 255)
    setElementFrozen(thePlayer, true)
    setTimer(function()
        setElementPosition(thePlayer, 461.7012, -1500.7793, 31.0455)
        setElementInterior(thePlayer, 0)
        setElementDimension(thePlayer, 0)
        setElementRotation(thePlayer, 0, 0, 270, "default", true)
        fadeCamera(thePlayer, true)
        setElementFrozen(thePlayer, false)
    end, 1000, 1)
    fadeCamera(thePlayer, false)
end)