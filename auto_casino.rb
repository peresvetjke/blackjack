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
    #loop
    round = game.start_new_round
    show_hands(round)
    request_players_turn(round)
    # dealer_decision
    # calculate_result
    # charge_the_winner
    #end
  end

  private

  def show_hands(round)
    puts '----------------------------------------'
    if round.round_info[:status] == :ongoing
      puts "Dealer's hand: *******unknown*******"
    else
      puts "Dealer's hand: #{round.round_info[:dealers_hand].join(' | ')}. Value: #{round.round_info[:dealers_hand_value]}"
    end
    puts "Your hand: #{round.round_info[:players_hand].join(' | ')}. Value: #{round.round_info[:players_hand_value]}"
  end

  def request_players_turn(round)
    puts "Please make your choice:"
    puts "1. Stand"
    puts "2. Hit"
    input = gets.chomp.to_i
    case input
    when 1
      request_dealers_turn(round)
    when 2
      hit(round)
      show_hands(round)
      request_dealers_turn(round)
    else
      puts "Wrong input."
      request_players_turn
    end
  end

  def request_dealers_turn(round)
    round.status = :finished
    round.dealers_decision
    show_hands(round)
  end

  def hit(round)
    round.hit
  end

  def stand(round)

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