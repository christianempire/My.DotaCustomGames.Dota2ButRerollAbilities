all_reroll = class({})

require('../components/ability_picker_component')

function all_reroll:OnSpellStart()
    local caster = self:GetCaster();

    self:SetActivated(false)

    ability_picker_component:set_hero(caster)
    ability_picker_component:set_callback(function() self:SetActivated(true) end)
    ability_picker_component:start()
end