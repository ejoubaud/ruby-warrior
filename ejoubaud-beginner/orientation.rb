class Orientation
  attr_reader :next_step, :away

  def initialize
    @next_step = :forward
    @away = :backward
  end

  def update(warrior)
    switch if warrior.feel(@next_step).wall?
    self
  end

private

  def switch
    @next_step, @away = @away, @next_step
  end
end
