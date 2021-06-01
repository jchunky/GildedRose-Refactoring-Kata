module ItemTypes
  extend self

  def find(item)
    item_types.find { |item_type| item_type.match?(item) }
  end

  private

  def item_types
    Dir["lib/item_types/*.rb"].map(&method(:file_to_class)).sort_by(&method(:normal_item_last))
  end

  def file_to_class(file)
    clazz = file.split("/").last.split(".").first.camelcase
    "ItemTypes::#{clazz}".constantize
  end

  def normal_item_last(item_type)
    (item_type == ItemTypes::NormalItem).to_s
  end
end
