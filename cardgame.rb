class CardGame
  BLANKS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  SUITS = %w{hearts diamond spades clubs}

  attr_reader :casino, :rounds, :card_deck

  def initialize(casino)
    @casino = casino
    @card_deck = define_card_deck
    casino.games << self
  end

  protected

  def define_card_deck
    blanks = BLANKS
    suits = SUITS

    card_deck = []
    blanks.each do |blank|
      suits.each do |suit|
        card_deck << "#{blank}-#{suit}"
      end
    end
    card_deck
  end

  def collect_bets(bet = BET)
    raise StandardError.new, "Not enough chips. New game should be started" if @chips[:dealer] < bet || @chips[:live_player] < bet
    @chips[:dealer] -= bet
    @chips[:live_player] -= bet
  end
end