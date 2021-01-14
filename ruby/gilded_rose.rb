class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  private

  def update_item(item)
    case item.name
    when "Aged Brie"
      item.sell_in -= 1
      item.quality += item.sell_in < 0 ? 2 : 1
      item.quality = item.quality.clamp(0, 50)
    when "Backstage passes to a TAFKAL80ETC concert"
      item.sell_in -= 1
      case item.sell_in
      when (10..) then item.quality += 1
      when (5..) then item.quality += 2
      when (0..) then item.quality += 3
      else item.quality = 0
      end
      item.quality = item.quality.clamp(0, 50)
    when "Sulfuras, Hand of Ragnaros"
    else
      item.sell_in -= 1
      item.quality -= item.sell_in < 0 ? 2 : 1
      item.quality = item.quality.clamp(0, 50)
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
