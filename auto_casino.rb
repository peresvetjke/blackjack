class AutoCasino
  attr_reader :name
  attr_accessor :games

  def initialize(name)
    @name = name
    @dealer = Dealer.new("Dealer")
    @games = []
  end

  def main_menu    
    player_name = request_user_name
    live_player = create_new_live_player(player_name)
    game = create_new_game(live_player)
    @games << game
    round = game.start_new_round
    show_hands(round)
    request_players_turn(round)
    request_dealers_turn(round)
    show_hands(round)
    show_result(round)
  end

  private

  def show_hands(round)
    puts '----------------------------------------'
    puts "Your hand: #{round.cards[:live_player].join(' | ')}. Value: #{round.game.evaluate_hand(round.cards[:live_player])}"
    if round.status == :ongoing
      puts "Dealer's hand: *******unknown*******"
    else
      puts "Dealer's hand: #{round.cards[:dealer].join(' | ')}. Value: #{round.game.evaluate_hand(round.cards[:dealer])}"
    end
  end

  def show_result(round)
    puts '----------------------------------------'
    winner = round.winner
    if winner == :none
      puts "Draw!"
    elsif winner == :dealer
      puts "Dealer wins."
    elsif winner == :live_player
      puts "You won."
    end
  end

  def request_players_turn(round)
    puts "Please make your choice:"
    puts "1. Stand"
    puts "2. Hit"
    input = gets.chomp.to_i
    case input
    when 1
      puts "You decided to Stand."
    when 2
      puts "You decided to Hit a card."
      round.draw_card(:live_player)
    else
      puts "Wrong input."
      request_players_turn(round) # Не работает переход. Нижняя часть вызывается несколько раз после этого...
    end
    round.status = :finishing
  end

  def request_dealers_turn(round)
    show_hands(round)
    puts "Dealer's turn..."
    sleep(3)
    if round.game.hit_card_to_dealer?(round) == true
      round.draw_card(:dealer)
      puts "Dealer decided to Hit a card."
    else
      puts "Dealer decided to Stand."
    end
    round.status = :finished
  end

  def create_new_live_player(name)
    LivePlayer.new(name)
  end

  def request_user_name
    # print "Enter your name: "
    "Harry"
    # gets.chomp
  end
  
  def create_new_game(live_player)
    @game = BlackJackGame.new(self, @dealer, live_player)
  end
end