--[[
Originally written for UO Sagas by: Hawks
Modified and extended by: Loonatik
Description: Enhanced lumberjacking macro with targeting validation, weight handling, and automatic hatchet management.
]]

-- Configuration
local MAX_WEIGHT_DIFF = 10
local MAX_WEIGHT = 390
local ITEM_ID_WOODEN_LOGS = 0x1BDD
local TOOL_NAME = "hatchet"
local MAX_RETRIES = 5

-- Equipment layer constants
local LAYER_RIGHT_HAND = 1
local LAYER_LEFT_HAND = 2
local HAND_LAYERS = {LAYER_RIGHT_HAND, LAYER_LEFT_HAND}

function FindEquippedTool()
    for _, layer in ipairs(HAND_LAYERS) do
        local item = Items.FindByLayer(layer)
        if item and string.find(string.lower(item.Name or ""), TOOL_NAME) then
            return item
        end
    end
    return nil
end

function GetHatchet()
    -- Step 1: Check hands for a hatchet
    local axe = FindEquippedTool()

    -- Step 2: Only equip a hatchet if one is not equipped
    if not axe then
        Player.ClearHands("both")
        Pause(1000)

        -- Step 3: Equip a hatchet
        local item = Items.FindByName("Hatchet")
        if item ~= nil then
            Player.Equip(item.Serial)
            Pause(1000)
            axe = FindEquippedTool()
        end
    end

    if not axe then
        Messages.Overhead("No hatchet found to equip!", 33, Player.Serial)
        return nil
    end

    return axe
end

function GetLogs()
    local items = Items.FindByFilter({})
    for _, item in ipairs(items) do
        if item and item.RootContainer == Player.Serial and item.Graphic == ITEM_ID_WOODEN_LOGS then
            return item
        end
    end
    return nil
end

function CreateBoards(hatchet)
    local log = GetLogs()
    if hatchet and log then
        Messages.Overhead("Chopping boards!", 33, Player.Serial)
        Player.UseObject(hatchet.Serial)
        if Targeting.WaitForTarget(1000) then
            Targeting.Target(log.Serial)
            Pause(1000)
        else
            Messages.Overhead("Failed to target log.", 33, Player.Serial)
        end
    elseif not hatchet then
        Messages.Overhead("No hatchet to make boards.", 33, Player.Serial)
    elseif not log then
        Messages.Overhead("No logs to make boards.", 33, Player.Serial)
    end
end

function CheckTreeStatus()
    local noWoodMessages = {
        "There is no wood here to chop.",
        "You cannot see that.",
        "That is too far away.",
        "You can't use an axe on that.",
        "You cannot reach that.",
        "You have worn out your tool!",
        "There's not enough wood here to harvest."
    }
    for _, msg in ipairs(noWoodMessages) do
        if Journal.Contains(msg) then
            local result = "tree_empty"
            if msg == "You can't use an axe on that." then
                result = "invalid_target"
            end
            Journal.Clear()
            return result
        end
    end
    return nil
end

function WaitForTargetCompletion()
    -- Wait until targeting mode ends (by selection or cancel)
    if Targeting.WaitForTarget(2000) then
        while Targeting.WaitForTarget(100) do
            Pause(500)
        end
        return true
    end
    return false

end

function Main()
    Journal.Clear()
    local needNewTree = true
    
    while true do
        local hatchet = GetHatchet()
        if not hatchet then
            Messages.Overhead("Could not find or equip a hatchet. Stopping.", 33, Player.Serial)
            return
        end

        if Player.Weight > MAX_WEIGHT - MAX_WEIGHT_DIFF then
            Messages.Overhead("Weight high. Converting to boards...", 33, Player.Serial)
            CreateBoards(hatchet)
            if Player.Weight > MAX_WEIGHT - MAX_WEIGHT_DIFF then
                Messages.Overhead("Still too heavy after making boards. Stopping.", 33, Player.Serial)
                return
            end
            needNewTree = true
        end

        Player.UseObject(hatchet.Serial)
        if Targeting.WaitForTarget(1000) then
            if needNewTree then
                Messages.Overhead("Select a tree.", 33, Player.Serial)
                needNewTree = false
                if not WaitForTargetCompletion() then
                    Messages.Overhead("Target canceled. Stopping.", 33, Player.Serial)
                    return
                end
            else
                Targeting.TargetLast()
            end
        else
            Messages.Overhead("Targeting failed, retrying...", 33, Player.Serial)
            Pause(1000)
            goto continue_loop
        end

        Pause(2000)

        status = CheckTreeStatus()
        if status == "invalid_target" then
            Messages.Overhead("Invalid target. Please select a tree.", 33, Player.Serial)
            needNewTree = true
            goto continue_loop
        elseif status == "tree_empty" then
            Messages.Overhead("Tree exhausted. Please select another.", 33, Player.Serial)
            needNewTree = true
        end

        ::continue_loop::
        Pause(500)
    end
end

Main()
