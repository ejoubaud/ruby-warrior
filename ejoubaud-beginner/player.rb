class Player
  attr_reader :warrior

  def play_turn(warrior)
    @warrior = warrior
    if warrior.feel.enemy?
      warrior.attack!
    elsif low_health?
      warrior.rest!
    else
      warrior.walk!
    end
  end

  def low_health?
    warrior.health < 7
  end
end
