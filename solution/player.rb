class Player
  attr_reader :name, :score
  attr_accessor :hand

  def initialize(name)
    @name = name
    @score = 0
  end

  def take_cards_from(player, value)
    cards = player.hand.take_cards(value)
    hand.receive_cards(cards)
  end

  def score_books
    books = hand.books
    @score += books.length
    books.each do |value|
      hand.take_cards(value)
    end
  end
end
