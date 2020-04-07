class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  def update_item(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
    update_item_quality(item)
    item.quality = [item.quality, 50].min
    item.quality = [item.quality, 0].max
  end

  def update_item_quality(item)
    case item.name
    when /Aged Brie/
      item.quality += item.sell_in < 0 ? 2 : 1
    when /Backstage passes/
      case item.sell_in
      when (10..) then item.quality += 1
      when (5..) then item.quality += 2
      when (0..) then item.quality += 3
      else item.quality = 0
      end
    else
      item.quality -= item.sell_in < 0 ? 2 : 1
    end
  end
end
