module ItemTypes
  module AgedBrie
    extend self

    def match?(item)
      item.name =~ /Aged Brie/
    end

    def update_item(item)
      item.sell_in -= 1
      item.quality += item.sell_in < 0 ? 2 : 1
      item.quality = item.quality.clamp(0, 50)
    end
  end
end
