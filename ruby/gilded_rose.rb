require "active_support/all"
ActiveSupport::Dependencies.autoload_paths += %w[lib]

class GildedRose < Struct.new(:items)
  def update_quality
    items.each do |item|
      ItemTypes.find(item).update_item(item)
    end
  end
end

