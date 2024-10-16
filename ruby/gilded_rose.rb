class GildedRose
  def initialize(items)
    @items = items.map { |item| ItemFactory.create(item) }
  end

  def update_quality
    @items.each(&:update_quality)
  end
end

class ItemFactory
  def self.create(item)
    case item.name
    when /Aged Brie/
      AgedBrie.new(item)
    when /Backstage pass/
      BackstagePass.new(item)
    when /Sulfuras/
      LegendaryItem.new(item)
    else
      NormalItem.new(item)
    end
  end
end

class ItemWrapper
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
    raise NotImplementedError, "Subclasses must implement"
  end

  protected

  def decrease_sell_in
    @item.sell_in -= 1
  end

  def increase_quality
    @item.quality += 1 if @item.quality < 50
  end

  def decrease_quality
    @item.quality -= 1 if @item.quality > 0
  end
end

class NormalItem < ItemWrapper
  def update_quality
    decrease_sell_in
    decrease_quality
    decrease_quality if @item.sell_in < 0
  end
end

class AgedBrie < ItemWrapper
  def update_quality
    decrease_sell_in
    increase_quality
    increase_quality if @item.sell_in < 0
  end
end

class BackstagePass < ItemWrapper
  def update_quality
    decrease_sell_in
    increase_quality
    increase_quality if @item.sell_in < 10
    increase_quality if @item.sell_in < 5
    @item.quality = 0 if @item.sell_in < 0
  end
end

class LegendaryItem < ItemWrapper
  def update_quality
    # Legendary items do not change in quality or sell_in
  end
end
