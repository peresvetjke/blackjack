class Deck
  BLANKS = %w[2 3 4 5 6 7 8 9 10].freeze
  FACES = %w[J Q K].freeze
  ACE = 'A'.freeze
  SUITS = %w[hearts diamond spades clubs].freeze

  attr_reader :round, :undrawn, :hands

  def initialize(round)
    @round = round
    @undrawn = new_card_deck
    @hands = {}
  end

  def draw_card(hand)
    hand.add_card(@undrawn.pop)
  end

  def draw_initial_hands
    @hands[:live_player] = Hand.new(self, round.game.live_player)
    @hands[:dealer] = Hand.new(self, round.game.dealer)
    2.times { draw_card(hands[:live_player]) }
    2.times { draw_card(hands[:dealer]) }
  end

  private

  def new_card_deck
    cards = []
    SUITS.each do |suit|
      BLANKS.each { |blank| cards << Card.new(self, blank, suit, blank.to_i) }
      FACES.each { |face| cards << Card.new(self, face, suit, 10) }
      cards << Card.new(self, ACE, suit, 11, true)
    end
    cards.shuffle
  end
end

# def initialize(deck, blank, suit, value, is_ace = false)
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