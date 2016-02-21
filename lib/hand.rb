class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck, cards = 5)
  end

  attr_reader :cards

  def initialize(cards)
  end

  def has_card?(value)
  end

  def receive_cards(cards)
  end

  def take_cards(value)
  end

  def books
  end

  def fish(deck)
  end

  def to_s
    @cards.join(",")
  end
end
