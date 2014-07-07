require 'delegate'

class OrientatedWarrior < SimpleDelegator
  def initialize(warrior, orientation)
    @warrior = warrior
    @orientation = orientation.update(warrior)
    super(warrior)
  end

  OVERRIDDEN_DIRECTION_ACTIONS = [
    :feel, :rescue!, :attack!, :walk!
  ]

  EXTRA_DIRECTIONS = [
    :next_step, :away
  ]

  # Overrides the warrior's directional methods
  # to accept new dynamic directions (see EXTRA_DIRECTIONS)
  # The default is also overriden to :next_step
  OVERRIDDEN_DIRECTION_ACTIONS.each do |name|
    define_method(name) do |direction = :next_step|
      overriden_direction = override(direction)
      @warrior.send(name, overriden_direction)
    end
  end

  def update_orientation
    @orientation.update(@warrior)
  end

private

  def override(direction)
    if EXTRA_DIRECTIONS.include?(direction)
      @orientation.send(direction)
    else
      direction
    end
  end
end
