GildedRose = Struct.new(:items) do
  def update_quality
    items.each(&method(:update_item))
  end

  private

  def update_item(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"

    item.sell_in -= 1
    update_item_quality(item)
    item.quality = item.quality.clamp(0, 50)
  end

  def update_item_quality(item)
    case item.name
    when /Aged Brie/ then aged_brie(item)
    when /Backstage passes/ then backstage_passes(item)
    else standard_item(item)
    end
  end

  def aged_brie(item)
    item.quality += item.sell_in < 0 ? 2 : 1
  end

  def backstage_passes(item)
    case item.sell_in
    when (10..) then item.quality += 1
    when (5..) then item.quality += 2
    when (0..) then item.quality += 3
    else item.quality = 0
    end
  end

  def standard_item(item)
    item.quality -= item.sell_in < 0 ? 2 : 1
  end
end
