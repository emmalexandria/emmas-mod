ALEXANDRIA = {vars={}, funcs={}, content=SMODS.current_mod}

local config =  ALEXANDRIA.content.config

function ALEXANDRIA.content.config_tab()
    return {n = G.UIT.C, config = {align = "cm", padding = 0.1}, nodes = {
        {n = G.UIT.T, config = {text = "Hello, world!", colour = G.C.UI.TEXT_LIGHT, scale = 0.5}}
     }}
end

SMODS.Atlas {
    key="CustomJokers-emod",
    path="CustomJokers-emod.png",
    px=71,
    py=95,
}

SMODS.Joker {
    key = 'horsejoker',
    loc_txt = {
        name='Evil and Intimidating Horse',
        text={
            "Gains {X:mult,C:white} X#1#{} mult per hand played where",
            "{C:attention}Blueprint{} and {C:attention}Brainstorm{} copy each-other",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} mult)"
        }
    },
    config = { extra = {Xmult=1, Xmult_gain=0.75}},
    rarity=2,
    atlas="CustomJokers-emod",
    pos={x=0,y=0},
    cost=4,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context)
        if context.pre_joker then 
            local jokers = G.jokers.cards

            for key,joker in ipairs(jokers) do
                print(key)
            end
        end
        if context.joker_main then 
            return {
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker {
    key='slot_machine',
    loc_txt = {
        name='Slot Machine',
        text={
            "Has a {C:attention}#1# in #2#{} chance to",
            "give {C:money}15${} if scoring hand",
            "contains 3 or more {C:attention}7{}s"
        }
    },
    rarity=2,
    config = {extra={odds=4}},
    atlas="CustomJokers-emod",
    pos={x=1,y=0},
    cost=5,
    loc_vars = function(self, info_queue, card)
        return {vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds}}
    end,
    calculate = function(self, card, context) 
        if context.joker_main then 
                local count = 0
                for _,card in ipairs(context.scoring_hand) do
                    if card:get_id() == 7 then 
                        count = count + 1
                    end
                end
                if pseudorandom('jackpot') < G.GAME.probabilities.normal / card.ability.extra.odds and count >= 3 then 
                    return {
                        remove_default_message = true,
                        dollars = 15,
                        message = "Jackpot!"
                    }
                end
                return {
            
                }
        end
    end
}
--- Register re-skinned texture atlases

SMODS.Atlas{key="Joker", path="Jokers-emod.png", px=71, py=95, prefix_config = {key=false}}
