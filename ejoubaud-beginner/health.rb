class Health
  def update(warrior)
    @previous = @current || warrior.health
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
