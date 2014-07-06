class Retreat
  def initialize(health, orientation)
    @health, @orientation = health, orientation
    @safe_retreat_impossible = false
    @retreated_last_turn = false
    @started_retreat_since_last_kill = false
    @ended_retreat_since_last_kill = false
  end

  def update(warrior)
    @warrior = warrior
    @away = @orientation.away
    @safe_retreat_impossible = cornered_and_under_attack? || under_attack_since_cornered?
    if just_killed?
      @started_retreat_since_last_kill = false
      @ended_retreat_since_last_kill = false
    else
      @ended_retreat_since_last_kill = @started_retreat_since_last_kill && !@retreated_last_turn
    end
    @attacked_last_turn = false
    @retreated_last_turn = false
    self
  end

  def advisable?
    !@safe_retreat_impossible &&
      @health.low? &&
      @health.declining? &&
      !@ended_retreat_since_last_kill
  end

  def do!
    @retreated_last_turn = true
    @started_retreat_since_last_kill = true
    @ended_retreat_since_last_kill = false
    if @warrior.feel(@away).captive?
      @warrior.rescue!(@away)
    else
      @warrior.walk!(@away)
    end
  end

  def report_attack
    @attacked_last_turn = true
  end

  def attacked_last_turn?
    @attacked_last_turn
  end

private

  def cornered?
    !(@warrior.feel(@away).empty? || @warrior.feel(@away).captive?)
  end

  def cornered_and_under_attack?
    cornered? && under_attack?
  end

  def under_attack_since_cornered?
    @safe_retreat_impossible && under_attack?
  end

  def under_attack?
    @health.declining? || @warrior.feel(@orientation.next_step).enemy?
  end

  def just_killed?
    @attacked_last_turn && @warrior.feel(@orientation.next_step).empty?
  end
end
