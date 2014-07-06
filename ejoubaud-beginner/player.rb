require 'health'
require 'orientation'
require 'retreat'
require 'turn'

class Player
  def play_turn(warrior)
    Turn.new(warrior, health, retreat, orientation).go!
  end

  def health
    @health ||= Health.new
  end

  def orientation
    @orientation ||= Orientation.new
  end

  def retreat
    @retreat ||= Retreat.new(health, orientation)
  end
end
