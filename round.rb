class Round
  def initialize(game, pot) 
    @game = game
    @pot = pot
    game.rounds << self
  end
end
