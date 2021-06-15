module ItemTypes
  extend self

  ITEM_TYPES = [AgedBrie, BackstagePasses, Sulfuras, NormalItem]

  def find(item)
    ITEM_TYPES.find { |type| type.match?(item) }
  end
end
