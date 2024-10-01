class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  def update_item(item)
    case item.name
    when /Aged Brie/
      update_aged_brie(item)
    when /Backstage passes/
      update_backstage_passes(item)
    when /Sulfuras, Hand of Ragnaros/
      # no-op
    else
      update_normal_item(item)
    end
  end

  private

  def update_aged_brie(item)
    item.sell_in -= 1
    item.quality += item.sell_in < 0 ? 2 : 1
    item.quality = item.quality.clamp(0, 50)
  end

  def update_backstage_passes(item)
    item.sell_in -= 1

    item.quality +=
      case item.sell_in
      when (10..) then 1
      when (5..) then 2
      when (0..) then 3
      else -item.quality
      end

    item.quality = item.quality.clamp(0, 50)
  end

  def update_normal_item(item)
    item.sell_in -= 1
    item.quality -= item.sell_in < 0 ? 2 : 1
    item.quality = item.quality.clamp(0, 50)
  end
end
