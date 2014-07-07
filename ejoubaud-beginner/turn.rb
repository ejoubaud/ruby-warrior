class Turn
  def initialize(orientated_warrior, health, retreat)
    @warrior = orientated_warrior
    @health = health.update(orientated_warrior)
    @retreat = retreat.update(orientated_warrior)
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
    if @warrior.feel.captive?
      @warrior.rescue!
    elsif @warrior.feel.enemy?
      @retreat.report_attack
      @warrior.attack!
    else
      @warrior.walk!
    end
  end

private

  def under_attack?
    @health.declining? || @warrior.feel.enemy?
  end
end
