local addonName, addonTable = ...

-- Helper to create an item icon + border
function addonTable.CreateWotLKItemIcon(parent, itemIconPath, itemQualityColor)
    local FRAME_BORDER = addonTable.FRAME_BORDER

    local icon = parent:CreateTexture(nil, "ARTWORK")
    icon:SetTexture(itemIconPath)
    icon:SetSize(36, 36)
    icon:SetPoint("LEFT", parent, "LEFT", 5, 0)


    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

    local border = CreateFrame("Frame", nil, parent)
    border:SetFrameLevel(parent:GetFrameLevel() + 1)
    border:SetPoint("TOPLEFT", icon, -1, 1)
    border:SetPoint("BOTTOMRIGHT", icon, 1, -1)

    border:SetBackdrop({
        edgeFile = FRAME_BORDER,
        edgeSize = 1,
    })

    local r, g, b = GetItemQualityColor(itemQualityColor)
    border:SetBackdropBorderColor(r, g, b, 1)

    return icon, border
end

-- Get the item info using the WoW API
function addonTable.GetItemInfoById(itemID)
    local itemName, _, itemQuality, _, _, _, _, _, _, itemIcon = GetItemInfo(itemID)
    return {
        itemName = itemName,
        itemQuality = itemQuality,
        itemIcon = itemIcon
    }
end

-- Check if the player has already equipped the item
function addonTable.HasEquippedItem(itemID)
    for slot = 1, 19 do
        local equippedID = GetInventoryItemID("player", slot)
        if equippedID == itemID then
            return true
        end
    end
    return false
end
