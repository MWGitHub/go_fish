require 'card'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of five cards" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(5).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      expect(hand.cards).to match_array(deck_cards)
    end

    it "deals a hand of seven cards" do
      deck_cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :three),
        Card.new(:spades, :four),
        Card.new(:spades, :five),
        Card.new(:spades, :six),
        Card.new(:spades, :seven),
        Card.new(:spades, :eight)
      ]

      deck = double("deck")
      expect(deck).to receive(:take).with(7).and_return(deck_cards)

      hand = Hand.deal_from(deck, 7)

      expect(hand.cards).to match_array(deck_cards)
    end
  end

  describe "#has_card?" do
    it "checks if it has a four" do
      hand = Hand.new([
          Card.new(:spades, :deuce),
          Card.new(:spades, :four)
        ])

      expect(hand.has_card?(:four)).to be(true)
    end

    it "checks that it does not a four" do
      hand = Hand.new([
          Card.new(:spades, :ten),
          Card.new(:spades, :ace)
        ])

      expect(hand.has_card?(:four)).to be(false)
    end
  end

  describe "#take_cards" do
    it "takes a four" do
      four = Card.new(:spades, :four)
      hand = Hand.new([
          Card.new(:spades, :deuce),
          four
        ])

      expect(hand.take_cards(:four)).to eq([four])
    end

    it "takes all jacks" do
      cards = [
          Card.new(:spades, :deuce),
          Card.new(:spades, :four),
          Card.new(:spades, :jack),
          Card.new(:hearts, :jack),
          Card.new(:clubs, :jack)
        ]
      jacks = cards[2..-1]
      hand = Hand.new(cards)

      expect(hand.take_cards(:jack)).to eq(jacks)
    end

    it "removes the fours" do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:spades, :four),
        Card.new(:clubs, :four)
      ]
      deuce = cards[0]
      hand = Hand.new(cards)
      hand.take_cards(:four)

      expect(hand.cards.count).to eq(1)
      expect(hand.cards[0]).to eq(deuce)
    end

    it "raises an error when taking cards that are not in the hand" do
      hand = Hand.new([
          Card.new(:spades, :deuce)
        ])

      expect { hand.take_cards(:four) }.to raise_error
    end
  end

  describe "#books" do
    it "returns set values" do
      cards = [
        Card.new(:spades, :deuce),
        Card.new(:hearts, :deuce),
        Card.new(:clubs, :deuce),
        Card.new(:diamonds, :deuce),
        Card.new(:spades, :four),
        Card.new(:hearts, :four),
        Card.new(:clubs, :four),
        Card.new(:diamonds, :four),
        Card.new(:diamonds, :five),
      ]
      hand = Hand.new(cards)

      expect(hand.books).to eq([:deuce, :four])
    end
  end

  describe "#fish" do
    it "draws a card from deck" do
      deck = double("deck")
      card = double("card")
      expect(deck).to receive(:take).with(1).and_return([card])

      hand = Hand.new([])
      hand.fish(deck)

      expect(hand.cards).to include(card)
    end
  end
end
