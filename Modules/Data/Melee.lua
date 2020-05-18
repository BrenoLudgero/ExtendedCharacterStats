---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


-- Get melee crit chance
function Data:MeleeCrit()
    return DataUtils:Round(GetCritChance(), 2) .. "%"
end

-- Gets the current bonus hit chance
function Data:MeleeHitBonus()
    return DataUtils:Round(GetHitModifier(), 2) .. "%"
end

-- Gets the hit chance against enemies on the player level
function Data:MeleeHitMissChanceSameLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = 0
    if DataUtils:IsShapeshifted() then
        missChance = 6
    else
        missChance = DataUtils:GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    local hitFromItems = GetHitModifier()
    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        missChance = missChance - hitFromItems
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

-- Gets the hit chance against enemies 3 level above the player level
function Data:MeleeHitMissChanceBossLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = 0
    if DataUtils:IsShapeshifted() then
        missChance = 9
    else
        missChance = DataUtils:GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    local hitFromItems = GetHitModifier()
    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        missChance = missChance - hitFromItems
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end