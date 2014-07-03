class Turn
  def initialize(warrior, health)
    @warrior = warrior
    @health = health.update(warrior)
  end

  def go
    if should_charge?
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

class Health
  def initialize(warrior)
    @current = warrior.health
    update(warrior)
  end

  def update(warrior)
    @previous = @current
    @current = warrior.health
    self
  end

  def low?
    @current < 12
  end

  def declining?
    @current < @previous
  end
end

class Player
  def play_turn(warrior)
    Turn.new(warrior, health(warrior)).go
  end

  def health(warrior)
    @health ||= Health.new(warrior)
  end
end
