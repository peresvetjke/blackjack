# frozen_string_literal: true

class BlackJackRound < Round
  attr_reader :game, :pot, :hands, :undrawn
  attr_accessor :status, :cards

  def initialize(game, pot)
    super(game, pot)
    @cards = {}
    @cards[:undrawn] = game.card_deck.shuffle
    @cards[:dealer] = []
    @cards[:live_player] = []
    draw_initial_hands
    @status = :ongoing
  end

  def draw_initial_hands
    2.times { draw_card(:dealer) }
    2.times { draw_card(:live_player) }
  end

  def winner
    return unless status == :finished

    players_hv = game.evaluate_hand(cards[:live_player])
    dealers_hv = game.evaluate_hand(cards[:dealer])
    if (players_hv == dealers_hv) || (players_hv > 21 && dealers_hv > 21)
      @winner = :none
    elsif (players_hv > dealers_hv && players_hv <= 21 && dealers_hv <= 21) || (players_hv <= 21 && dealers_hv > 21)
      @winner = :live_player
    elsif (players_hv < dealers_hv && players_hv <= 21 && dealers_hv <= 21) || (players_hv > 21 && dealers_hv <= 21)
      @winner = :dealer
    end
  end

  def draw_card(player)
    cards[player.to_sym] << cards[:undrawn].last
    cards[:undrawn].pop
  end
end
