class GildedRose < Struct.new(:items)
  def update_quality
    items.each { update_item(_1) }
  end

  private

  def update_item(item)
    return if legendary?(item)

    adjust_sell_in(item)
    adjust_quality(item)
  end

  def legendary?(item)
    item.name =~ /Sulfuras/
  end

  def adjust_sell_in(item)
    item.sell_in -= 1
  end

  def adjust_quality(item)
    delta = quality_delta(item)
    item.quality = (item.quality + delta).clamp(0, 50)
  end

  def quality_delta(item)
    case item.name
    when /Aged Brie/
      item.sell_in < 0 ? 2 : 1
    when /Backstage pass/
      case item.sell_in
      when (10..) then 1
      when (5..)  then 2
      when (0..)  then 3
      else -item.quality
      end
    else
      item.sell_in < 0 ? -2 : -1
    end
  end
end
