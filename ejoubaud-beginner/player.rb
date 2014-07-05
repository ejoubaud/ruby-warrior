require 'health'
require 'turn'

class Player
  def play_turn(warrior)
    Turn.new(warrior, health).go!
  end

  def health
    @health ||= Health.new
  end
end
