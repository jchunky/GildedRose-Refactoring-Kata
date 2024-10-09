class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  private

  def update_item(item)
    return if legendary?(item)

    update_sell_in_of(item)
    update_quality_of(item)
  end

  private

  def legendary?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_sell_in_of(item)
    item.sell_in -= 1
  end

  def update_quality_of(item)
    delta = quality_delta(item)
    item.quality = (item.quality + delta).clamp(0..50)
  end

  def quality_delta(item)
    case item.name
    when /Aged Brie/
      item.sell_in < 0 ? 2 : 1
    when /Backstage pass/
      case item.sell_in
      when (10..) then 1
      when (5..) then 2
      when (0..) then 3
      else -item.quality
      end
    else
      item.sell_in < 0 ? -2 : -1
    end
  end
end
