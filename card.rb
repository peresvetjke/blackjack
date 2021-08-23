class Card
  attr_reader :blank, :suit, :value

  def initialize(deck, blank, suit, value, is_ace = false)
    @deck = deck
    @blank = blank
    @suit = suit
    @value = value
  end

  def cover
    "#{blank}-#{suit}"
  end
end