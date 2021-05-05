class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&:update)
  end
end

class Item < Struct.new(:name, :sell_in, :quality)
  def to_s
    [name, sell_in, quality].join(", ")
  end

  def update
    case name
    when "Aged Brie"
      aged_brie
    when "Backstage passes to a TAFKAL80ETC concert"
      backstage_passes
    when "Sulfuras, Hand of Ragnaros"
      sulfuras
    else
      normal_item
    end
  end

  private

  def aged_brie
    self.sell_in -= 1
    self.quality += sell_in < 0 ? 2 : 1
    self.quality = quality.clamp(0, 50)
  end

  def backstage_passes
    self.sell_in -= 1
    self.quality += backstage_passes_quality_delta
    self.quality = quality.clamp(0, 50)
  end

  def backstage_passes_quality_delta
    case sell_in
    when (10..) then 1
    when (5..) then 2
    when (0..) then 3
    else -quality
    end
  end

  def sulfuras
    # no-op
  end

  def normal_item
    self.sell_in -= 1
    self.quality -= sell_in < 0 ? 2 : 1
    self.quality = quality.clamp(0, 50)
  end
end
