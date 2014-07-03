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
    @current < 13
  end

  def declining?
    @current < @previous
  end
end
