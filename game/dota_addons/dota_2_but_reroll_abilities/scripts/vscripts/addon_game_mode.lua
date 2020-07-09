require('config')

function Activate()
	config:set_up_reroll_ability()
end

function Precache(context)
	PrecacheResource('soundfile', 'soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts', context)
end