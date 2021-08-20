class CardDeck
  BLANKS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  SUITS = %w{hearts diamond spades clubs}
  # добавить все масти

  def initialize(round)
  end

  def cards_list
    blanks = BLANKS
    suits = SUITS

    blanks.each do |blank|
      suits.each do |suit|
        puts "#{blank}-#{suit}"
        @carddeck << "#{blank}-#{suit}"
        puts @carddeck
      end
    end
  end

end