require_relative 'player'

class Game
  attr_reader :players, :current_player

  def initialize(*players)
    @players = players
    @current_player = players[0]
  end

  def next_player!
    index = players.find_index(current_player) + 1
    @current_player = players[index % players.length]
  end

  def handle_ask(asked_player, value)
    if asked_player.hand.has_card?(value)
      current_player.take_cards_from(asked_player, value)
    else
      current_player.hand.fish
      next_player!
    end
  end

  def leader
    players.max_by { |player| player.score }
  end
end
