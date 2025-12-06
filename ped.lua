local SkinShopPed = createPed(33, 161.4189, -80.8838, 1001.8047, 180)
setElementInterior(SkinShopPed, 18)
setElementFrozen(SkinShopPed, true)
addEventHandler("onClientPedDamage", SkinShopPed, cancelEvent)