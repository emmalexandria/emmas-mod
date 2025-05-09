ALEXANDRIA = {vars={}, funcs={}, content=SMODS.current_mod}

local config =  ALEXANDRIA.content.config

SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {
		
	}, nodes = {
        {n=G.UIT.C, config={align='cm'}, nodes = {
            create_toggle({
                label="Vanilla Reskins",
                ref_table = config,
                ref_value="vanilla_reskins"
            })
        }}
		-- work your UI wizardry here, see 'Building a UI' page
	}}
end

SMODS.Atlas {
    key="CustomJokers-emod",
    path="CustomJokers-emod.png",
    px=71,
    py=95,
}

SMODS.Atlas {
    key="Decks-emod",
    path="Decks-emod.png",
    px=71,
    py=95
}

SMODS.Atlas {
    key="Stickers-emod",
    path="Stickers-emod.png",
    px=71,
    py=95
}

SMODS.Atlas {
    key="Chips-emod",
    path="Chips-emod.png",
    px=29,
    py=29
}

SMODS.Atlas {
    key="Planets-emod",
    path="Planets-emod.png",
    px=71,
    py=95
}

SMODS.Atlas {
    key="Spectrals-emod",
    path="Spectrals-emod.png",
    px=71,
    py=95
}

local function reskin_vanilla()
    SMODS.Atlas{key="Joker", path="Jokers-emod.png", px=71, py=95, prefix_config = {key=false}}
end

--- Quality of life 
local function qol_changes()

end

SMODS.load_file('./items/jokers.lua')()
SMODS.load_file('./items/decks.lua')()
SMODS.load_file('./items/stakes.lua')()
SMODS.load_file('./items/consumables.lua')()


if config.vanilla_reskins then 
    reskin_vanilla()
end

if config.features.qol then
    qol_changes()
end


