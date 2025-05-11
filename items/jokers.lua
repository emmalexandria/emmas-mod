SMODS.Joker {
    key="queen",
    loc_txt = {
        name="Queen",
        text = {
            "Each non face card",
            "drawn in initial hand",
            "gives {C:attention}+1{} hand size"
        }
    },
    rarity=3,
    atlas="CustomJokers-emod",
    pos={x=0,y=0},
    cost=8,
    blueprint_compat = false,
    calculate = function(self, card, context)


    end
}

SMODS.Joker {
    key='gambler',
    loc_txt = {
        name='Gambler',
        text={
            "Has a {C:green}#1# in #2#{} chance to",
            "give {C:money}15${} if scoring hand",
            "contains 3 or more 7s"
        }
    },
    rarity=2,
    config = {extra={odds=3}},
    atlas="CustomJokers-emod",
    pos={x=1,y=0},
    cost=5,
    blueprint_compat = true,
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

SMODS.Joker {
    name="Ouroboros",
    key="ouroboros",
    atlas="CustomJokers-emod",
    pos={x=2,y=0},
    rarity=2,
    config={extra={Xmult=1, Xmult_gain= 1.5}},
    cost=5,
    blueprint_compat = true,
    eternal_compat = false,
    loc_txt = {
        name="Ouroboros",
        text = {
            "Gains {X:mult,C:white}X#1#{} mult when sold.",
            "Downgrades to {C:chips}common{} when first sold.",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} mult)"
        }

    },
    loc_vars = function(self, info_queue, card) 
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult}}
    end,
    calculate = function(self, card, context) 
        if context.selling_card then
            if context.card == card then 
                self.config.extra.Xmult = self.config.extra.Xmult + card.ability.extra.Xmult_gain
            end
        end
    end,
}

SMODS.Joker {
    name="Mountaineer",
    key="mountaineer",
    atlas="CustomJokers-emod",
    pos={x=3,y=0},
    rarity=2,
    config={extra={Xmult=1, Xmult_gain = 0.1, prev_high = 0}},
    cost=5,
    blueprint_compat = true,
    eternal_compat = true,
    loc_txt = {
        name="Mountaineer",
        text = {
            "Gains {X:mult,C:white}X#1#{} mult when a hand",
            "scores a run high score",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} mult, {C:chips}#3#{C:inactive} chips)"
        }

    },
    loc_vars = function(self, info_queue, card) 
        return {vars = {card.ability.extra.Xmult_gain, card.ability.extra.Xmult, number_format(card.ability.extra.prev_high)}}
    end,
    set_ability = function(self, card, inital, delay_sprites)
        card.ability.extra.prev_high = G.GAME.round_scores['hand'].amt
    end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers then
            if G.GAME.round_scores['hand'].amt > card.ability.extra.prev_high then
                card.ability.extra.prev_high = G.GAME.round_scores['hand'].amt
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message="Peak!"
                }
            end
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        
    end
}