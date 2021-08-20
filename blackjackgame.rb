class BlackJackGame < CardGame
  BUYIN = 100
  BET = 10
  
  attr_reader :dealer, :player

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

  def dealers_decision(round)
    if round.round_info[:dealers_hand_value] < 17
      round.draw_card(self.hands.first)
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
end