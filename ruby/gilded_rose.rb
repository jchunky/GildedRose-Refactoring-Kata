module Sulfuras
  def self.update_item(_item)
    # no-op
  end
end

module AgedBrie
  def self.update_item(item)
    item.sell_in -= 1
    item.quality += item.sell_in < 0 ? 2 : 1
    item.quality = item.quality.clamp(0, 50)
  end
end

module BackstagePasses
  def self.update_item(item)
    item.sell_in -= 1
    case item.sell_in
    when (10..) then item.quality += 1
    when (5..) then item.quality += 2
    when (0..) then item.quality += 3
    else item.quality = 0
    end
    item.quality = item.quality.clamp(0, 50)
  end
end

module NormalItem
  def self.update_item(item)
    item.sell_in -= 1
    item.quality -= item.sell_in < 0 ? 2 : 1
    item.quality = item.quality.clamp(0, 50)
  end
end

class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  def update_item(item)
    item_updater(item).update_item(item)
  end

  def item_updater(item)
    case item.name
    when /Aged Brie/ then AgedBrie
    when /Backstage passes/ then BackstagePasses
    when /Sulfuras/ then Sulfuras
    else NormalItem
    end
  end
end
