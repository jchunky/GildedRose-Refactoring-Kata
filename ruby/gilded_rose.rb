class AgedBrie
  def update_item(item)
    item.sell_in -= 1
    item.quality += (item.sell_in < 0) ? 2 : 1
    item.quality = item.quality.clamp(0, 50)
  end
end

class BackstagePasses
  def update_item(item)
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

class Sulfuras
  def update_item(item)
    # no-op
  end
end

class NormalItem
  def update_item(item)
    item.sell_in -= 1
    item.quality -= (item.sell_in < 0) ? 2 : 1
    item.quality = item.quality.clamp(0, 50)
  end
end

class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  private

  def update_item(item)
    updater(item).update_item(item)
  end

  def updater(item)
    case item.name
    when "Aged Brie" then AgedBrie
    when "Backstage passes to a TAFKAL80ETC concert" then BackstagePasses
    when "Sulfuras, Hand of Ragnaros" then Sulfuras
    else NormalItem
    end.new
  end
end
