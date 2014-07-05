class Retreat
  def initialize(health)
    @health = health
    @safe_retreat_impossible = false
  end

  def update(warrior)
    @warrior = warrior
    @back = warrior.feel(:backward)
    @safe_retreat_impossible = cornered_and_under_attack? || under_attack_since_cornered?
    self
  end

  def advisable?
    !@safe_retreat_impossible &&
      @health.low? &&
      @health.declining?
  end

  def do!
    @retreated_last_turn = true
    @started_retreat_since_last_kill = true
    if @warrior.feel(:backward).captive?
      @warrior.rescue!(:backward)
    else
      @warrior.walk!(:backward)
    end
  end

  def attacked_last_turn?
    @attacked_last_turn
  end

private

  def cornered?
    !(@back.empty? || @back.captive?)
  end

  def cornered_and_under_attack?
    cornered? && under_attack?
  end

  def under_attack_since_cornered?
    @safe_retreat_impossible && under_attack?
  end

  def under_attack?
    @health.declining? || @warrior.feel.enemy?
  end
end
