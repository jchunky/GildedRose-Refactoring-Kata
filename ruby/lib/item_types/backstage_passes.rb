module ItemTypes
  module BackstagePasses
    extend self

    def match?(item)
      item.name =~ /Backstage passes/
    end

    def update_item(item)
      item.sell_in -= 1
      item.quality = next_quality(item)
      item.quality = item.quality.clamp(0, 50)
    end

    private

    def next_quality(item)
      case item.sell_in
      when (10..) then item.quality + 1
      when (5..) then item.quality + 2
      when (0..) then item.quality + 3
      else 0
      end
    end
  end
end
