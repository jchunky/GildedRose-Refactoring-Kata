class ItemFactory
  ITEM_TYPES = [AgedBrie, BackstagePasses, Sulfuras, NormalItem]

  def self.build(item)
    find_item_type(item).new(item)
  end

  private

  def self.find_item_type(item)
    ITEM_TYPES.find { |item_type| item_type.match(item.name) }
  end
end
