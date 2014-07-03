require 'health'
require 'turn'

class Player
  def play_turn(warrior)
    Turn.new(warrior, health(warrior)).go!
  end

  def health(warrior)
    @health ||= Health.new(warrior)
  end
end
