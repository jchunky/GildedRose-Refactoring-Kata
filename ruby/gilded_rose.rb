class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  def update_item(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"

    item.sell_in -= 1

    case item.name
    when "Aged Brie"
      item.quality += item.sell_in < 0 ? 2 : 1
    when "Backstage passes to a TAFKAL80ETC concert"
      case item.sell_in
      when (10..) then item.quality += 1
      when (5..) then item.quality += 2
      when (0..) then item.quality += 3
      else item.quality = 0
      end
    else
      item.quality -= item.sell_in < 0 ? 2 : 1
    end

    item.quality = item.quality.clamp(0, 50)
  end
end
