class Hand
  attr_reader :cards

  def initialize(deck, player)
    @deck = deck
    @player = player
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def value
    v = 0
    @cards.each do |card|
      v += (v > 10 && card.is_ace == true) ? 1 : card.value
    end
    #@value =
    v
  end

  def output
    cards.map(&:cover).join(' | ')
  end
end
