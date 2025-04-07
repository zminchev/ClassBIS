local addonName, addonTable = ...

local FRAME_BACKGROUND = addonTable.FRAME_BACKGROUND
local BLIZZARD_FRAME_BACKGROUND = addonTable.BLIZZARD_FRAME_BACKGROUND
local FRAME_BORDER = addonTable.FRAME_BORDER
local CLASS_LIST = addonTable.CLASS_LIST
local PHASES = addonTable.PHASES
local MAIN_FRAME_TITLE = addonTable.MAIN_FRAME_TITLE
local LEFT_FRAME_TITLE = addonTable.LEFT_FRAME_TITLE
local RIGHT_FRAME_TITLE = addonTable.RIGHT_FRAME_TITLE
local PHASED_ITEM_DATA = addonTable.PHASED_ITEM_DATA

local CreateWotLKItemIcon = addonTable.CreateWotLKItemIcon
local GetItemInfoById = addonTable.GetItemInfoById
local HasEquippedItem = addonTable.HasEquippedItem

local E, L, V, P, G
local S

if ElvUI then
    E, L, V, P, G = unpack(ElvUI)
    S = E:GetModule("Skins")
end

local phaseTextMapping = {
    ["PRE_RAID"] = "Pre-Raid BIS",
    ["TIER_4"] = "Tier 4 BIS",
    ["TIER_5"] = "Tier 5 BIS",
    ["TIER_6"] = "Tier 6 BIS"
}

--------------------------------
-- Frames
--------------------------------
local mainFrame = CreateFrame("Frame", "ClassBISFrame", UIParent)
local leftFrameInMainFrame = CreateFrame("Frame", nil, mainFrame)
local rightFrameInMainFrame = CreateFrame("Frame", nil, mainFrame)
local phaseFrame = CreateFrame("Frame", nil, mainFrame)
local closeButton = CreateFrame("Button", nil, mainFrame, "UIPanelCloseButton")

--------------------------------
-- Title Text
--------------------------------
local frameTitle = mainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
local classListTitle = leftFrameInMainFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")

local function SetFrameBackdrop(frame, useElvUI)
    if useElvUI then
        -- Use your custom ElvUI-specified textures (from your addon data)
        frame:SetBackdrop({
            bgFile = addonTable.FRAME_BACKGROUND,
            edgeFile = addonTable.FRAME_BORDER,
            tile = true,
            tileSize = 16,
            edgeSize = 1,
            insets = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0
            }
        })
        frame:SetBackdropColor(0, 0, 0, 0.8)
        frame:SetBackdropBorderColor(0, 0, 0, 1)
    else
        -- Use Blizzard defaults
        frame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = false,
            tileSize = 16,
            edgeSize = 16,
            insets = {
                left = 4,
                right = 4,
                top = 4,
                bottom = 4
            }
        })
    end
end

SetFrameBackdrop(mainFrame, S and S.HandleCloseButton)
SetFrameBackdrop(leftFrameInMainFrame, S and S.HandleCloseButton)
SetFrameBackdrop(rightFrameInMainFrame, S and S.HandleCloseButton)
SetFrameBackdrop(phaseFrame, S and S.HandleCloseButton)

--------------------------------
-- MainFrame Config
--------------------------------
mainFrame:SetSize(1010, 520)
mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)
mainFrame:SetMovable(true)
mainFrame:EnableMouse(true)
mainFrame:RegisterForDrag("LeftButton")
mainFrame:SetScript("OnDragStart", function(self)
    self:StartMoving()
end)
mainFrame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)

mainFrame:Hide()

--------------------------------
-- Left Frame Config
--------------------------------
leftFrameInMainFrame:SetSize(300, 480)
leftFrameInMainFrame:SetPoint("LEFT", mainFrame, "LEFT", 10, -10)

--------------------------------
-- Right Frame Config
--------------------------------
rightFrameInMainFrame:SetSize(680, 480)
rightFrameInMainFrame:SetPoint("RIGHT", mainFrame, "RIGHT", -10, -10)

--------------------------------
-- Phase Frame Config
--------------------------------
phaseFrame:SetSize(300, 480)
phaseFrame:SetPoint("LEFT", mainFrame, "LEFT", 10, -10)
phaseFrame:Hide()
local phaseBackButton = CreateFrame("Button", nil, phaseFrame, "UIPanelButtonTemplate")
phaseBackButton:SetSize(120, 20)
phaseBackButton:SetPoint("BOTTOM", phaseFrame, "BOTTOM", 0, 10)
phaseBackButton:SetText("Back to Class List")
phaseBackButton:SetScript("OnClick", function()
    phaseFrame:Hide()
    leftFrameInMainFrame:Show()
end)
--------------------------------
-- Close Button Config
--------------------------------
closeButton:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -5, -5)
closeButton:SetScript("OnClick", function()
    mainFrame:Hide()
end)

if S and S.HandleCloseButton then
    S:HandleCloseButton(closeButton)
    S:HandleButton(phaseBackButton)
end

--------------------------------
-- Title Text Config
--------------------------------
classListTitle:SetPoint("TOP", leftFrameInMainFrame, "TOP", 0, -10)
classListTitle:SetText(LEFT_FRAME_TITLE)
classListTitle:SetTextColor(1, 1, 1, 1)

frameTitle:SetPoint("TOP", mainFrame, "TOP", 0, -10)
frameTitle:SetText(MAIN_FRAME_TITLE)
frameTitle:SetTextColor(1, 1, 1, 1)

local function ShowItemsForClassTier(className, tierKey, parentFrame)
    if not parentFrame.itemFrames then
        parentFrame.itemFrames = {}
    else
        -- Hide all frames from previous display
        for _, oldFrame in ipairs(parentFrame.itemFrames) do
            oldFrame:Hide()
        end
        wipe(parentFrame.itemFrames) -- empties the table
    end

    if not parentFrame.checkFrames then
        parentFrame.checkFrames = {}
    else
        -- Hide all frames from previous display
        for _, oldFrame in ipairs(parentFrame.checkFrames) do
            oldFrame:Hide()
        end
        wipe(parentFrame.checkFrames) -- empties the table
    end

    local phasedItems = PHASED_ITEM_DATA

    if not phasedItems then
        return
    end

    local selectedClass = string.upper(className)
    local classData = phasedItems[selectedClass]

    if not classData then
        return
    end

    local items = classData[tierKey]

    if not items then
        -- No items found for the selected class and tier
        print('No items found for the selected class: ' .. selectedClass .. ' and tier: ' .. tierKey)
        return
    end

    -- Define sizing/spacing for two columns
    local itemWidth = 330
    local itemHeight = 32
    local xSpacing = 20
    local ySpacing = 10
    local startX = 10
    local startY = -50

    for i, itemData in ipairs(items) do
        -- i starts at 1
        local index = i - 1
        local col = index % 2 -- 0 or 1
        local row = math.floor(index / 2)

        -- Calculate x/y offsets for each item
        local xOffset = startX + col * (itemWidth + xSpacing)
        local yOffset = startY - row * (itemHeight + ySpacing)

        local itemFrame = CreateFrame("Frame", nil, parentFrame)
        itemFrame:EnableMouse(true)
        itemFrame:SetSize(itemWidth, itemHeight)
        itemFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", xOffset, yOffset)
        itemFrame:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink("item:" .. itemData.itemID)
            GameTooltip:Show()
        end)
        itemFrame:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)

        local itemInfo = GetItemInfoById(itemData.itemID)
        local icon, border = CreateWotLKItemIcon(itemFrame, itemInfo.itemIcon, itemInfo.itemQuality)
        if HasEquippedItem(itemData.itemID) then
            itemFrame:SetAlpha(0.5)
            local checkFrame = CreateFrame("Frame", nil, parentFrame)
            checkFrame:SetPoint("LEFT", itemFrame, "LEFT", 0, 0)
            checkFrame:SetSize(50, 50)

            local checkMark = checkFrame:CreateTexture(nil, "OVERLAY")
            checkMark:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
            checkMark:SetPoint("LEFT", itemFrame, "LEFT", 0, 0)
            checkMark:SetSize(50, 50)
            checkMark:SetAlpha(1)
            table.insert(parentFrame.checkFrames, checkFrame)
        end

        local nameText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        nameText:SetPoint("LEFT", icon, "RIGHT", 8, 10)
        nameText:SetText(itemInfo.itemName)

        local locationText = itemFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        locationText:SetPoint("LEFT", icon, "RIGHT", 8, -10)
        locationText:SetText(itemData.location or "Unknown")

        table.insert(parentFrame.itemFrames, itemFrame)
    end
end

local function UpdateTextForSelectedClassBisPanel(className, phaseName, frame)
    if not frame.bisFrameText then
        frame.bisFrameText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        frame.bisFrameText:SetPoint("TOP", frame, "TOP", 0, -10)
    end

    local trimmedString = string.gsub(phaseTextMapping[phaseName], "BIS", "") -- Remove "BIS" from the string
    frame.bisFrameText:SetText(RIGHT_FRAME_TITLE .. className .. " for " .. trimmedString or "Unkown")
    frame.bisFrameText:SetTextColor(1, 1, 1, 1)
end

-- =====================================
-- Creating the Class List inside the Left Frame
-- =====================================
local classButtons = {}
local phaseButtons = {}

for i, className in ipairs(CLASS_LIST) do
    classButtons[i] = CreateFrame("Button", nil, leftFrameInMainFrame, "UIPanelButtonTemplate")
    classButtons[i]:SetSize(120, 20)
    classButtons[i]:SetPoint("TOP", leftFrameInMainFrame, "TOP", 0, -50 - (i - 1) * 35)
    classButtons[i]:SetText(className)
    classButtons[i]:SetScript("OnClick", function()
        leftFrameInMainFrame:Hide()
        phaseFrame.selectedClass = className
        phaseFrame:Show()
    end)
    if S and S.HandleButton then
        S:HandleButton(classButtons[i])
    end
end

for i, phaseName in ipairs(PHASES) do
    phaseButtons[i] = CreateFrame("Button", nil, phaseFrame, "UIPanelButtonTemplate")
    phaseButtons[i]:SetSize(120, 20)
    phaseButtons[i]:SetPoint("TOP", phaseFrame, "TOP", 0, -50 - (i - 1) * 35)
    phaseButtons[i]:SetText(phaseTextMapping[phaseName] or phaseName)
    phaseButtons[i]:SetScript("OnClick", function()
        ShowItemsForClassTier(phaseFrame.selectedClass, phaseName, rightFrameInMainFrame)
        UpdateTextForSelectedClassBisPanel(phaseFrame.selectedClass, phaseName, rightFrameInMainFrame)
    end)
    if S and S.HandleButton then
        S:HandleButton(phaseButtons[i])
    end
end

SLASH_CLASSBIS1 = "/classbis"
SLASH_CLASSBIS2 = "/cbis"
SlashCmdList["CLASSBIS"] = function(msg)
    if mainFrame:IsShown() then
        mainFrame:Hide()
    else
        mainFrame:Show()
    end
end

mainFrame:RegisterEvent("PLAYER_LOGIN")
mainFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        -- Initialize the addon here
        print(MAIN_FRAME_TITLE .. " loaded! Type /cbis or /classbis to open your BIS List.")
    end
end)

