require 'game'

describe Game do
  let(:player_one) do
    hand = double(:hand, :fish => nil)
    player = double(:player_one, :score => 0, :hand => hand)
    player
  end
  let(:player_two) { double(:player_two, :score => 2) }
  let(:player_three) { double(:player_three, :score => 1) }
  subject(:game) { Game.new(player_one, player_two, player_three) }

  describe "#initialize" do
    it "sets up a game with the given players" do
      expect(game.players.count).to eq(3)
    end

    it "sets the starting player as the first added player" do
      expect(game.current_player).to eq(player_one)
    end
  end

  describe "#next_player!" do
    it "switches to the next player" do
      game.next_player!
      expect(game.current_player).to eq(player_two)
    end

    it "switches players multiple times" do
      game.next_player!
      game.next_player!
      expect(game.current_player).to eq(player_three)
    end

    it "wraps on last player" do
      game.next_player!
      game.next_player!
      game.next_player!
      expect(game.current_player).to eq(player_one)
    end
  end

  describe "#handle_ask" do
    it "makes the player fish when card not found" do
      hand = double(:hand)
      allow(player_two).to receive(:hand).and_return(hand)

      expect(hand).to receive(:has_card?).with(:ace).and_return(false)

      expect(player_one.hand).to receive(:fish)
      game.handle_ask(player_two, :ace)
    end

    it "take cards from other player when card found" do
      hand = double(:hand, :has_card? => true)
      allow(player_two).to receive(:hand).and_return(hand)

      expect(player_one).to receive(:take_cards_from).with(player_two, :ace)
      game.handle_ask(player_two, :ace)
    end

    it "should go to next player when card not found" do
      hand = double(:hand, :has_card? => false)
      allow(player_two).to receive(:hand).and_return(hand)

      expect(game).to receive(:next_player!)
      game.handle_ask(player_two, :ace)
    end

    it "should not go to next player when card found" do
      hand = double(:hand, :has_card? => true)
      allow(player_two).to receive(:hand).and_return(hand)

      allow(player_one).to receive(:take_cards_from)

      expect(game).to_not receive(:next_player!)
      game.handle_ask(player_two, :ace)
    end
  end

  describe "#take_turn" do
    it "handles ask until no card found"

    it "removes makes the player score books"
  end

  describe "#leader" do
    it "retrieves the leader" do
      expect(game.leader).to eq(player_two)
    end
  end
end
