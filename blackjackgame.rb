# frozen_string_literal: true

class BlackJackGame
  include InstanceCounter

  BUYIN = 100
  BET = 10

  attr_reader :casino, :rounds, :dealer, :live_player
  attr_accessor :chips

  def initialize(casino, dealer, live_player, buyin = BUYIN)
    @casino = casino
    @dealer = dealer
    @live_player = live_player
    @chips = { dealer: buyin, live_player: buyin }
    register_instance
  end

  def start_new_round(bet = BET)
    collect_bets(bet)
    pot = bet * 2
    Round.new(self, pot)
  end

  def charge_winner(round)
    raise StandardError.new, "Round is not finished yet." unless round.status == :finished

    case round.winner
    when :live_player
      chips[:live_player] += round.pot
    when :dealer
      chips[:dealer] += round.pot
    else
      return_bets(round.pot / 2)
    end
  end

  def hit_card_to_dealer?(round)
    round.deck.hands[:dealer].value < 17
  end

  private

  def collect_bets(bet = BET)
    raise StandardError.new, 'Not enough chips. New game should be started' if @chips[:dealer] < bet || @chips[:live_player] < bet

    @chips[:dealer] -= bet
    @chips[:live_player] -= bet
  end

  def return_bets(bet = BET)
    @chips[:dealer] += bet
    @chips[:live_player] += bet
  end
end
