require_relative 'player'

class Game
  attr_reader :players, :current_player

  def initialize(*players)
  end

  def next_player!
  end

  def handle_ask(asked_player, value)
  end

  def leader
  end
end
