require "active_support/all"
ActiveSupport::Dependencies.autoload_paths += %w[lib]

class GildedRose < Struct.new(:items)
  def update_quality
    items.each(&:update)
  end
end
