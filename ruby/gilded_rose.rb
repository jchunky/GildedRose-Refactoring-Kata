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

      item.quality += case item.sell_in
                      when ...0 then 2
                      else           1
                      end

      item.quality  = item.quality.clamp(0, 50)
    when /Backstage pass/
      item.sell_in -= 1

      item.quality += case item.sell_in
                      when ...0  then -item.quality
                      when ...5  then 3
                      when ...10 then 2
                      else            1
                      end

      item.quality  = item.quality.clamp(0, 50)
    when /Sulfuras/
      # no-op
    else
      item.sell_in -= 1

      item.quality += case item.sell_in
                      when ...0 then -2
                      else           -1
                      end

      item.quality = item.quality.clamp(0, 50)
    end
  end
end
