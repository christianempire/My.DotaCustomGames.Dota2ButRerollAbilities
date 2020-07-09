if ability_picker_component == nil then
    ability_picker_component = class({})
end

require('../data/abilities_data')

local callback
local hero
local listener

local function is_valid_ability(ability)
    if ability == nil then return false end
    if ability:IsHidden() then return false end
    if ability:GetName():sub(1, #'special') == 'special' then return false end
    if ability:GetName() == 'all_reroll' then return false end

    return true
end

local function get_hero_abilities()
    local abilities = {}

    for ability_index = 0, hero:GetAbilityCount() - 1 do
        local ability = hero:GetAbilityByIndex(ability_index)

        if is_valid_ability(ability) then
            table.insert(abilities, ability:GetAbilityName())
        end
    end

    return abilities
end

local function on_ability_selected(event, data)
    local ability_level = hero:FindAbilityByName(data.ability_name):GetLevel()
    local new_ability_name = ability_data:get_random_ability();

    hero:RemoveAbility(data.ability_name)
    hero:AddAbility(new_ability_name)

    hero:FindAbilityByName(new_ability_name):SetLevel(ability_level)

    CustomGameEventManager:UnregisterListener(listener)

    EmitSoundOn('Hero_Tinker.RearmStart', hero)

    callback()
end

function ability_picker_component:start(callback)
    local currentPlayer = hero:GetPlayerOwner()
    local eventName = 'reroll_started';
    local data = get_hero_abilities()
    CustomGameEventManager:Send_ServerToPlayer(currentPlayer, eventName, data)

    listener = CustomGameEventManager:RegisterListener('ability_selected', on_ability_selected )
end

function ability_picker_component:set_callback(p_callback)
    callback = p_callback;
end

function ability_picker_component:set_hero(p_hero)
    hero = p_hero;
end
