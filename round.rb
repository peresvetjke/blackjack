# frozen_string_literal: true

class Round
  attr_reader :game, :pot, :hands, :undrawn, :deck
  attr_accessor :status, :cards

  def initialize(game, pot)
    @game = game
    @pot = pot
    @deck = Deck.new(self)
    @status = :ongoing
    game.rounds << self
    deck.draw_initial_hands
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
end
