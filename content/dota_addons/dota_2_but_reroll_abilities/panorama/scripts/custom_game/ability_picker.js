'use-strict';

GameEvents.Subscribe('reroll_started', onRerollStarted);

var abilities = {};

function onRerollStarted(data) {
    $('#ability-picker-panel').SetHasClass('invisible', false);

    var abilitySlots = ['1', '2', '3', '4'];
    abilitySlots.forEach(function (abilitySlot) {
        abilities[abilitySlot] = data[abilitySlot];
        $('#ability-image-' + abilitySlot).abilityname = data[abilitySlot];
    });
}

function selectAbilityOnSlot(slot) {
    var eventName = 'ability_selected';
    var data = { ability_name: abilities[slot] };
    GameEvents.SendCustomGameEventToServer(eventName, data);

    $('#ability-picker-panel').SetHasClass('invisible', true);
}