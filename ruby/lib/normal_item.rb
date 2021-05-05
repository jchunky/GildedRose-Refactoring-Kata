class NormalItem < Item
  def self.match(_name)
    true
  end

  def update
    @sell_in -= 1
    @quality -= sell_in < 0 ? 2 : 1
    @quality = quality.clamp(0, 50)
  end
end
