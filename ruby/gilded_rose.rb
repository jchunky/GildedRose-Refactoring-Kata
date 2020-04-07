module AgedBrie
  extend self

  def match?(item)
    item.name == 'Aged Brie'
  end

  def update_quality(item)
    item.quality += item.sell_in < 0 ? 2 : 1
  end
end

module BackstagePasses
  extend self

  def match?(item)
    item.name.start_with?('Backstage passes')
  end

  def update_quality(item)
    case item.sell_in
    when (10..) then item.quality += 1
    when (5..) then item.quality += 2
    when (0..) then item.quality += 3
    else item.quality = 0
    end
  end
end

module NormalItem
  extend self

  def match?(_item)
    true
  end

  def update_quality(item)
    item.quality -= item.sell_in < 0 ? 2 : 1
  end
end

module ConjuredItem
  extend self

  def match?(item)
    item.name.start_with?('Conjured')
  end

  def update_quality(item)
    item.quality -= item.sell_in < 0 ? 4 : 2
  end
end

class GildedRose < Struct.new(:items)
  ITEM_TYPES = [
    AgedBrie,
    BackstagePasses,
    # ConjuredItem,
    NormalItem
  ]

  def update_quality
    items.each(&method(:update_item))
  end

  def update_item(item)
    return if item.name == 'Sulfuras, Hand of Ragnaros'

    item.sell_in -= 1
    update_item_quality(item)
    item.quality = [item.quality, 50].min
    item.quality = [item.quality, 0].max
  end

  def update_item_quality(item)
    item_type = ITEM_TYPES.find { |type| type.match?(item) }
    item_type.update_quality(item)
  end
end
