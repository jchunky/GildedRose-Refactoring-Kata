module ItemTypes
  extend self

  def find(item)
    ClassLoader
      .classes("ItemTypes::", "lib/item_types/*.rb")
      .sort_by(&method(:normal_item_last))
      .find { |item_type| item_type.match?(item) }
  end

  private

  def normal_item_last(item_type)
    (item_type == NormalItem).to_s
  end
end
