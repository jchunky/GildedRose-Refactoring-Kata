class Item
  ITEM_TYPES = [AgedBrie, BackstagePasses, Sulfuras, NormalItem]

  attr_reader :name, :sell_in, :quality

  def self.build(name, sell_in, quality)
    ITEM_TYPES.find { |item| item.match(name) }.new(name, sell_in, quality)
  end

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    [name, sell_in, quality].join(", ")
  end
end
