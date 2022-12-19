require "delegate"

class AgedBrie < SimpleDelegator
  def update
    self.sell_in -= 1
    self.quality += sell_in < 0 ? 2 : 1
    self.quality = quality.clamp(0, 50)
  end
end

class BackstagePasses < SimpleDelegator
  def update
    self.sell_in -= 1
    case sell_in
    when (10..) then self.quality += 1
    when (5..) then self.quality += 2
    when (0..) then self.quality += 3
    else self.quality = 0
    end
    self.quality = quality.clamp(0, 50)
  end
end

class Sulfuras < SimpleDelegator
  def update
    # no-op
  end
end

class NormalItem < SimpleDelegator
  def update
    self.sell_in -= 1
    self.quality -= sell_in < 0 ? 2 : 1
    self.quality = quality.clamp(0, 50)
  end
end

class GildedRose < Struct.new(:items)
  def update_quality
    items.each { |item| item_type(item).update }
  end

  def item_type(item)
    case item.name
    when "Aged Brie" then AgedBrie
    when "Backstage passes to a TAFKAL80ETC concert" then BackstagePasses
    when "Sulfuras, Hand of Ragnaros" then Sulfuras
    else NormalItem
    end.new(item)
  end
end
