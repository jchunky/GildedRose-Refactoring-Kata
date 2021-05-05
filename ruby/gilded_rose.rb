class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&:update)
  end

  private
end

class Item
  attr_reader :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

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
    @sell_in -= 1
    @quality += sell_in < 0 ? 2 : 1
    @quality = quality.clamp(0, 50)
  end

  def backstage_passes
    @sell_in -= 1
    @quality = new_backstage_pass_quality
    @quality = quality.clamp(0, 50)
  end

  def new_backstage_pass_quality
    case sell_in
    when (10..) then quality + 1
    when (5..) then quality + 2
    when (0..) then quality + 3
    else 0
    end
  end

  def sulfuras
    # no-op
  end

  def normal_item
    @sell_in -= 1
    @quality -= sell_in < 0 ? 2 : 1
    @quality = quality.clamp(0, 50)
  end
end
