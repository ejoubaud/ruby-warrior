class Turn
  def initialize(warrior, health, retreat)
    @warrior = warrior
    @health = health.update(warrior)
    @retreat = retreat.update(warrior)
  end

  def go!
    if @retreat.advisable?
      @retreat.do!
    elsif @health.low? && !under_attack?
      @warrior.rest!
    else
      move_forward!
    end
  end

  def move_forward!
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
