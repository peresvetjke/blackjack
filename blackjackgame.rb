class BlackJackGame < CardGame
  BUYIN = 30
  BET = 10
  
  attr_reader :players
  attr_accessor :chips

  def initialize(casino, dealer, live_player, buyin = BUYIN)
    super(casino)
    @rounds = []
    @players = {dealer: dealer, live_player: live_player}
    @chips = {dealer: buyin, live_player: buyin}
  end

  def start_new_round(bet = BET)
    collect_bets(bet)
    pot = bet * 2
    round = BlackJackRound.new(self, pot)
  end

  def charge_winner(round)
    raise StandardError.new unless round.status == :finished
    if round.winner == :live_player
      self.chips[:live_player] += round.pot
    elsif round.winner == :dealer
      self.chips[:dealer] += round.pot
    else
      return_bets(round.pot / 2)
    end
  end

  def evaluate_hand(cards_to_evaluate)
    value = 0
    blank_hand = cards_to_evaluate.map { |card| make_blank(card) }
    # return 'Blackjack' if (cards.size == 2) && (blank_hand.first == 'A' && blank_hand.last == 'A')
    cards_to_evaluate.each do |card| 
      value += card_value(card, value) 
    end
    value
  end

  def hit_card_to_dealer?(round)
    evaluate_hand(round.cards[:dealer]) < 17 ? true : false
  end

  private

  def make_blank(card)
    card.match(/(^\w+)/)[0]
  end

  def card_value(card, hand_value = 0)
    blank = make_blank(card)
    if %w{2 3 4 5 6 7 8 9 10}.include?(blank)
      blank.to_i
    elsif %w{J Q K}.include?(blank)
      10
    elsif blank == 'A'
      hand_value <= 10 ? 11 : 1
    end
  end

  def collect_bets(bet = BET)
    raise StandardError.new, "Not enough chips. New game should be started" if @chips[:dealer] < bet || @chips[:live_player] < bet
    @chips[:dealer] -= bet
    @chips[:live_player] -= bet
  end

  def return_bets(bet = BET)
    @chips[:dealer] += bet
    @chips[:live_player] += bet
  end
end