SMODS.PokerHand {
    key="stone_five",
    mult = 4,
    chips = 30,
    l_chips = 10,
    l_mult = 3,
    visible=false,
    example = {
        {S_K, true, enhancement='m_stone'},
        {S_K, true, enhancement='m_stone'},
        {S_K, true, enhancement='m_stone'},
        {S_K, true, enhancement='m_stone'},
        {S_K, true, enhancement='m_stone'},
    },
    loc_txt = {
        name="Stone Five",
        text="5 Stone cards"
    },
    evaluate = function(parts, hand)
        local valid = true
        for card in ipairs(parts) do
            print(parts)
        end
    end
}