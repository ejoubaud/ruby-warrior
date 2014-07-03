class Turn
  def initialize(warrior, health)
    @warrior = warrior
    @health = health.update(warrior)
  end

  def go!
    if @warrior.feel.captive?
      @warrior.rescue!
    elsif should_charge?
      charge!
    elsif @health.low?
      @warrior.rest!
    else
      @warrior.walk!
    end
  end

  def under_attack?
    @health.declining?
  end

  def should_charge?
    @warrior.feel.enemy? || under_attack?
  end

  def charge!
    if @warrior.feel.enemy?
      @warrior.attack!
    else
      @warrior.walk!
    end
  end
end
