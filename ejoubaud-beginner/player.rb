require 'health'
require 'orientated_warrior'
require 'orientation'
require 'retreat'
require 'turn'

class Player
  def play_turn(warrior)
    orientated_warrior = OrientatedWarrior.new(warrior, orientation)
    Turn.new(orientated_warrior, health, retreat).go!
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
