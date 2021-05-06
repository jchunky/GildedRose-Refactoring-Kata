class NormalItem < SimpleDelegator
  def self.match(_name)
    true
  end

  def update
    self.sell_in -= 1
    self.quality -= sell_in < 0 ? 2 : 1
    self.quality = quality.clamp(0, 50)
  end
end
