# frozen_string_literal: true

class Round
  include InstanceCounter

  def initialize(game, pot)
    @game = game
    @pot = pot
    game.rounds << self
    register_instance
  end
end
