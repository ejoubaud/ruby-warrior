class Player
  attr_reader :warrior

  def play_turn(warrior)
    @warrior = warrior

    if should_charge?
      charge!
    elsif low_health?
      warrior.rest!
    else
      warrior.walk!
    end

    remember_health
  end

  def low_health?
    warrior.health < 12
  end

  def under_attack?
    warrior.health < previous_health
  end

  def should_charge?
    warrior.feel.enemy? || under_attack?
  end

  def charge!
    if warrior.feel.enemy?
      warrior.attack!
    else
      warrior.walk!
    end
  end

  def remember_health
    @previous_health = warrior.health
  end

  def previous_health
    @previous_health || 0
  end
end

