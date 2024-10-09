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
      item.quality = item.quality.clamp(..50)
    when "Backstage passes to a TAFKAL80ETC concert"
      item.sell_in -= 1

      item.quality += 1
      if item.sell_in < 10
        item.quality += 1
      end
      if item.sell_in < 5
        item.quality += 1
      end
      if item.sell_in < 0
        item.quality += -item.quality
      end

      item.quality = item.quality.clamp(..50)
    when "Sulfuras, Hand of Ragnaros"
      # no-op
    else
      item.sell_in -= 1
      item.quality -= item.sell_in < 0 ? 2 : 1
      item.quality = item.quality.clamp(0..)
    end
  end
end
