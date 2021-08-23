class Card
  attr_reader :blank, :suit, :value, :is_ace

  def initialize(deck, blank, suit, value, is_ace = false)
    # @deck = deck
    @blank = blank
    @suit = suit
    @value = value
    @is_ace = is_ace
  end

  def cover
    "#{blank}-#{suit}"
  end
end