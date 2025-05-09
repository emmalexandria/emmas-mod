SMODS.Consumable({
    key = "fortuna",
    set = "Planet",
    atlas = "Planets-emod",
    pos = { x = 0, y = 0 },
    cost = 4,
    config = { extra = { odds = 5 } },
    loc_txt = {
        name = "Fortuna",
        text = {
            "{C:green}#1# in #2#{} chance to upgrade",
            "every {C:purple}poker hand{} by {C:attention}1{} level"
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
            if pseudorandom('fortuna') < G.GAME.probabilities.normal / card.ability.extra.odds then
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                    { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = true
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.8, 0.5)
                        G.TAROT_INTERRUPT_PULSE = nil
                        return true
                    end
                }))
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
                delay(1.3)
                for k, v in pairs(G.GAME.hands) do
                    level_up_hand(self, k, true)
                end
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                    { mult = 0, chips = 0, handname = '', level = '' })
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.PLANET,
                        align = (G.STATE == G.STATES.CELESTIAL_PACK) and 'tm' or 'cm',
                        offset = {x = 0, y = (G.STATE == G.STATES.CELESTIAL_PACK) and -0.2 or 0},
                        silent = true
                        })
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                            play_sound('tarot2', 0.76, 0.4);return true end}))
                        play_sound('tarot2', 1, 0.4)
                        card:juice_up(0.3, 0.5)
                return true end }))
            end
    end
})

SMODS.Consumable({
    key="twin",
    set="Spectral",
    atlas="Spectrals-emod",
    pos={x=0,y=0},
    config = {
        max_highlighted = 1,
    },
    loc_txt = {
        name="Twin",
        text = {
            "Destroys selected card and creates {C:attention}1{} copy with",
            "a random {C:attention}seal{}, {C:attention}edition{}, and {C:attention}enhancement"
        }
    },
    can_use = function(self, card)
        return G.hand.cards == 1
    end,
    use = function(self, card, area, copier)
        local selected_card = G.hand.highlighted[0]:destroy()
    end
})