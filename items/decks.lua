SMODS.Back {
    name="Pandora's Deck",
    key="pandoradeck",
    atlas="Decks-emod",
    pos={x=0,y=0},
    loc_txt = {
        name="Pandora's Deck",
        text = {
            "Any non-playing card can",
            "appear in any {C:attention}booster pack"
        }
    }

}

SMODS.Back {
    name="Lucky Deck",
    key="luckydeck",
    atlas="Decks-emod",
    pos={x=1,y=0},
    loc_txt = {
        name="Lucky Deck",
        text={
            "All listed probabilities are doubled,",
            "All shop prices increased by {C:attention}50%"
        }
    },
    apply = function(self,back) 
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v*2
        end
        G.E_MANAGER:add_event(Event({func = function()
            G.GAME.discount_percent = -50
            for k, v in pairs(G.I.CARD) do
                if v.set_cost then v:set_cost() end
            end
            return true end }))
    end
}