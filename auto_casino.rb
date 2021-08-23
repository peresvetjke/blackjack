# frozen_string_literal: true

class AutoCasino
  attr_reader :name

  def initialize(name)
    @name = name
    @dealer = Dealer.new('Dealer')
  end

  def main_menu
    puts "Welcome to #{name}!"
    player_name = request_user_name
    live_player = LivePlayer.new(player_name)
    puts ' '
    play_black_jack(live_player)
  end

  private

  def play_black_jack(live_player)
    game = create_new_game(live_player)
    show_game_header(game)
    loop do
      round = game.start_new_round
      show_round_header(game, round)
      show_hands(round)
      request_players_turn(round)
      request_dealers_turn(round) unless round.status == :finished
      show_hands(round)
      game.charge_winner(round)
      show_result(round)
      suggest_new_game(live_player) if game.chips[:dealer].zero? || game.chips[:live_player].zero?
    end
  end

  def show_game_header(game)
    puts "Game ##{game.class.instances}. Let's play some BlackJack!"
  end

  def show_hands(round)
    puts '--------'
    puts "Your hand: #{round.deck.hands[:live_player].output}. Value: #{round.deck.hands[:live_player].value}"
    if round.status == :ongoing
      puts "Dealer's hand: *******unknown*******"
    else
      puts "Dealer's hand: #{round.deck.hands[:dealer].output}. Value: #{round.deck.hands[:dealer].value}"
    end
  end

  def show_round_header(game, round)
    puts '----------------------------------------------------'
    puts "Round ##{round.class.all.count { |r| r.game == game }}"
  end

  def show_result(round)
    puts '--------'
    winner = round.winner
    case winner
    when :none
      puts 'Draw!'
    when :dealer
      puts 'Dealer wins.'
    when :live_player
      puts 'You won.'
    end
    puts "#{round.game.live_player.name} - #{round.game.chips[:live_player]}$; #{round.game.dealer.name} - #{round.game.chips[:dealer]}$."
  end

  def request_players_turn(round)
    puts 'Please make your choice:'
    puts '1. Stand'
    puts '2. Hit'
    puts '3. Open cards now'
    input = gets.chomp.to_i
    case input
    when 1
      puts 'You decided to Stand.'
      round.status = :finishing
    when 2
      puts 'You decided to Hit a card.'
      round.deck.draw_card(round.deck.hands[:live_player])
      round.status = :finishing
    when 3
      round.status = :finished
    else
      puts 'Wrong input.'
      request_players_turn(round)
    end
  end

  def request_dealers_turn(round)
    show_hands(round)
    print "Dealer's turn"
    little_pause
    if round.game.hit_card_to_dealer?(round) == true
      round.draw_card(:dealer)
      puts 'Dealer decided to Hit a card.'
    else
      puts 'Dealer decided to Stand.'
    end
    round.status = :finished
  end

  def little_pause
    3.times do
      sleep(0.8)
      print '.'
      sleep(0.8)
    end
    puts ' '
  end

  def request_user_name
    print 'Enter your name: '
    gets.chomp
  end

  def create_new_game(live_player)
    @game = BlackJackGame.new(self, @dealer, live_player)
  end

  def suggest_new_game(live_player)
    puts ' '
    puts "#{live_player.name}, would you like to start a new game?"
    print 'Your choice (y/n): '
    input = gets.chomp
    if input =~ /\A[Yy]/
      puts ' '
      play_black_jack(live_player)
    elsif input =~ /\A[Nn]/
      exit
    end
  end
end
