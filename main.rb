require_relative 'auto_casino'
require_relative 'player'
require_relative 'live_player'
require_relative 'dealer'
require_relative 'cardgame'
require_relative 'blackjackgame'
require_relative 'round'
require_relative 'blackjackround'
require 'pry'

def test_data
  player = LivePlayer.new("Player1", 100)
  dealer = Dealer.new("Dealer")
  game1 = BlackJack.new(dealer, player)
  round1 = Round.new(game1)
  round1.hands[0].evaluate_hand
end

casino1 = AutoCasino.new("JQ21-Casino")
casino1.main_menu