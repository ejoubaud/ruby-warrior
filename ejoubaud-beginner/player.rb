require 'health'
require 'retreat'
require 'turn'

class Player
  def play_turn(warrior)
    Turn.new(warrior, health, retreat).go!
  end

  def health
    @health ||= Health.new
  end

  def retreat
    @retreat ||= Retreat.new(health)
  end
end
