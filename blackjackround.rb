class BlackJackRound < Round
  # instance_number: Integer
  # bank

  attr_reader :game, :pot, :hands, :undrawn, :winner
  attr_accessor :status, :cards

  def initialize(game, pot) 
    super(game, pot)
    @cards = {}
    @cards[:undrawn] = game.card_deck.shuffle
    @cards[:dealer] = []
    @cards[:live_player] = []
    draw_initial_hands
    @status = :ongoing
    self
  end
  
  def draw_initial_hands
    2.times { draw_card(:dealer) }
    2.times { draw_card(:live_player) }
  end

  def round_info
    {dealers_hand: cards[:dealer], dealers_hand_value: game.evaluate_hand(cards[:dealer]), players_hand: cards[:live_player], 
      players_hand_value: game.evaluate_hand(cards[:live_player]), pot: pot, winner: winner, status: status}
  end

  def draw_card(player)
    cards[player.to_sym] << cards[:undrawn].last
    cards[:undrawn].pop
  end  
end

=begin
Test
  evaluate_hand(["A-spades", "2-spades"])
  evaluate_hand(["A-spades", "A-hearts"])
  evaluate_hand(["2-spades", "5-hears"])
  card_value("A-hearts", 10)
  card_value("A-hearts", 11)
  card_value("A-hearts", evaluate_hand(["A-spades", "2-spades"]))
  evaluate_hand(["A-hearts", "5-spades", "2-spades"])
  evaluate_hand(["5-spades", "K-spades", "A-hearts"])

=end