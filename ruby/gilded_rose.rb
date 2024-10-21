class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    items.each { update_item(_1) }
  end

  def update_item(item)
    case item.name
    when /Aged Brie/
      item.sell_in -= 1
      item.quality += item.sell_in < 0 ? 2 : 1
      item.quality  = item.quality.clamp(0, 50)
    when /Backstage pass/
      item.sell_in -= 1
      item.quality += case item.sell_in
                      when 10.. then 1
                      when 5..  then 2
                      when 0..  then 3
                      else           -item.quality
                      end
      item.quality  = item.quality.clamp(0, 50)
    when /Sulfuras/
      # no-op
    else
      item.sell_in -= 1
      item.quality += item.sell_in < 0 ? -2 : -1
      item.quality  = item.quality.clamp(0, 50)
    end
  end
end
