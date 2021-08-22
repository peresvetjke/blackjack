class Hand
  def initialize(deck, player)
    @deck = deck
    @player = player
    @cards = []
    @value = evaluate_hand(cards)
  end

  def add_card(card)
    @cards << card
  end

  def value
    v = 0
    @cards.each do |card|
      v += (v > 10 && card.is_ace == true) 1 ? card.value
    @value = v
  end

  def hand_info
  end
end

=begin
    blank = make_blank(card)
    if %w[2 3 4 5 6 7 8 9 10].include?(blank)
      blank.to_i
    elsif %w[J Q K].include?(blank)
      10
    elsif blank == 'A'
      hand.value <= 10 ? 11 : 1
    end

=end