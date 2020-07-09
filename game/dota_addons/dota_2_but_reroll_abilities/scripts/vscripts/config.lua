if config == nil then
    config = class({})
end

local function on_hero_picked(event)
    local hero = EntIndexToHScript(event.heroindex)

    hero:AddAbility('all_reroll')
    hero:FindAbilityByName('all_reroll'):SetLevel(1)
end

function config:set_up_quick_start()
    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetHeroSelectionTime(15)
    GameRules:SetStrategyTime(0)
    GameRules:SetPreGameTime(0)
    GameRules:SetShowcaseTime(0)
end

function config:set_up_reroll_ability()
    local pick_hero_event_name = 'dota_player_pick_hero'
    local event_context = nil

    ListenToGameEvent(pick_hero_event_name, on_hero_picked, event_context)
end
