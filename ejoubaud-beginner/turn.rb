class Turn
  def initialize(warrior, health, retreat, orientation)
    @warrior = warrior
    @health = health.update(warrior)
    @retreat = retreat.update(warrior)
    @orientation = orientation.update(warrior)
    @next_step = @orientation.next_step
  end

  def go!
    if @retreat.advisable?
      @retreat.do!
    elsif @health.low? && !under_attack?
      @warrior.rest!
    else
      move_next_step!
    end
  end

  def move_next_step!
    if @warrior.feel(@next_step).captive?
      @warrior.rescue!(@next_step)
    elsif @warrior.feel(@next_step).enemy?
      @retreat.report_attack
      @warrior.attack!(@next_step)
    else
      @warrior.walk!(@next_step)
    end
  end

private

  def under_attack?
    @health.declining? || @warrior.feel(@next_step).enemy?
  end
end
