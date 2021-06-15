require "active_support/all"
ActiveSupport::Dependencies.autoload_paths += %w[lib]

class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&method(:update_item))
  end

  private

  def update_item(item)
    ItemTypes.find(item).update_item(item)
  end
end
