require 'player'

describe Player do
  subject(:player) do
    Player.new("Nick the Greek")
  end

  it "assigns the name" do
    expect(player.name).to eq("Nick the Greek")
  end

  it "accepts a hand" do
    hand = double(:hand)
    player.hand = hand

    expect(player.hand).to eq(hand)
  end

  describe "#score_books" do
    it "adds a point for a book" do
      hand = double(:hand, :books => [:deuces], :take_cards => nil)
      player.hand = hand

      player.score_books

      expect(player.score).to eq(1)
    end

    it "does not add any points when no books" do
      hand = double(:hand, :books => [], :take_cards => nil)
      player.hand = hand

      player.score_books

      expect(player.score).to eq(0)
    end

    it "adds a point for each book" do
      hand = double(:hand, :books => [:a, :b, :c], :take_cards => nil)
      player.hand = hand

      player.score_books

      expect(player.score).to eq(3)
    end

    it "increments score on new books" do
      hand = double(:hand, :books => [:a], :take_cards => nil)
      player.hand = hand

      player.score_books
      player.score_books

      expect(player.score).to eq(2)
    end

    it "takes all books out from hand" do
      hand = double(:hand)
      allow(hand).to receive(:books).and_return([:a], [])
      player.hand = hand

      expect(hand).to receive(:take_cards).with(:a)
      player.score_books
      expect(player.score).to eq(1)
      player.score_books
      expect(player.score).to eq(1)
    end
  end
end
