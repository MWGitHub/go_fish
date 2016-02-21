class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck, cards = 5)
    Hand.new(deck.take(cards))
  end

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def has_card?(value)
    cards.any? { |card| card.value == value }
  end

  def take_cards(value)
    raise StandardError.new unless has_card?(value)

    taken_cards = cards.select { |card| card.value == value }
    @cards = cards.reject { |card| card.value == value }
    taken_cards
  end

  def books
    count_map = Hash.new(0)
    cards.each { |card| count_map[card.value] += 1 }
    count_map.select { |value, count| count == 4 }.keys
  end

  def fish(deck)
    @cards += deck.take(1)
  end

  def to_s
    @cards.join(",")
  end
end
