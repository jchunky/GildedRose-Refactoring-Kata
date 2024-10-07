class GildedRose < Struct.new(:items)
  MIN_QUALITY = 0
  MAX_QUALITY = 50

  def update_quality
    items.each(&method(:process_item))
  end

  private

  def process_item(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"

    update_sell_in_of(item)
    update_quality_of(item)
  end

  def update_sell_in_of(item)
    item.sell_in -= 1
  end

  def update_quality_of(item)
    quality_change = calculate_quality_change(item)
    item.quality = (item.quality + quality_change).clamp(MIN_QUALITY, MAX_QUALITY)
  end

  def calculate_quality_change(item)
    case item.name
    when "Aged Brie"
      calculate_increment(item, 1)
    when "Backstage passes to a TAFKAL80ETC concert"
      calculate_backstage_pass_increment(item)
    else
      calculate_increment(item, -1)
    end
  end

  def calculate_increment(item, base_increment)
    increment = base_increment
    increment *= 2 if item.sell_in < 0
    increment
  end

  def calculate_backstage_pass_increment(item)
    case item.sell_in
    when (10..) then 1
    when (5..) then 2
    when (0..) then 3
    else -item.quality
    end
  end
end
