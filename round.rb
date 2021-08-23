# frozen_string_literal: true

class Round
  include InstanceCounter

  attr_reader :game, :pot, :hands, :undrawn
  attr_accessor :status, :cards, :deck

  def initialize(game, pot)
    @game = game
    @pot = pot
    @deck = Deck.new(self)
    @status = :ongoing
    deck.draw_initial_hands
    register_instance
  end

  def winner
    return unless status == :finished

    players_hv = deck.hands[:live_player].value
    dealers_hv = deck.hands[:dealer].value
    # puts "players_hv = #{players_hv}; dealers_hv = #{dealers_hv}"
    if (players_hv == dealers_hv) || (players_hv > 21 && dealers_hv > 21)
      @winner = :none
    elsif (players_hv > dealers_hv && players_hv <= 21 && dealers_hv <= 21) || (players_hv <= 21 && dealers_hv > 21)
      @winner = :live_player
    elsif (players_hv < dealers_hv && players_hv <= 21 && dealers_hv <= 21) || (players_hv > 21 && dealers_hv <= 21)
      @winner = :dealer
    end    
  end
end
