class Health
  def update(warrior)
    @previous = @current || warrior.health
    @current = warrior.health
    self
  end

  def low?
    @current < 14
  end

  def declining?
    @current < @previous
  end
end
