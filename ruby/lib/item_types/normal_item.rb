module ItemTypes
  module NormalItem
    extend self

    def match?(_item)
      true
    end

    def update_item(item)
      item.sell_in -= 1
      item.quality -= item.sell_in < 0 ? 2 : 1
      item.quality = item.quality.clamp(0, 50)
    end
  end
end
