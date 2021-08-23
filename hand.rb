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
    @cards.each { |card| v += (v > 10 && card.is_ace == true) ? 1 : card.value }
    v
  end

  def output
    # card_cover = Proc.new { |card| "#{card.blank}-#{card.suit}" }
    cards.map { |c| c.cover }.join(' | ')
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