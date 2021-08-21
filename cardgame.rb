# frozen_string_literal: true

class CardGame
  include InstanceCounter

  BLANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[hearts diamond spades clubs].freeze

  attr_reader :casino, :rounds, :card_deck

  def initialize(casino)
    @casino = casino
    @card_deck = define_card_deck
    register_instance
  end

  protected

  def define_card_deck
    blanks = BLANKS
    suits = SUITS

    card_deck = []
    blanks.each do |blank|
      suits.each do |suit|
        card_deck << "#{blank}-#{suit}"
      end
    end
    card_deck
  end
end
