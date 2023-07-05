require_relative "gilded_rose_old"
require_relative "gilded_rose"
require "test/unit"

class TestGildedRose < Test::Unit::TestCase
  def test_behaves_exactly_like_old_implementation
    items = build_items
    items_old = build_items
    gilded_rose1 = GildedRose.new(items)
    gilded_rose2 = GildedRoseOld.new(items_old)

    50.times do
      gilded_rose1.update_quality
      gilded_rose2.update_quality

      items.size.times do |i|
        assert_equal items_old[i].to_s, items[i].to_s
      end
    end
  end

  def build_items
    [
      Item.new("+5 Dexterity Vest", 10, 20),
      Item.new("Aged Brie", 2, 0),
      Item.new("Elixir of the Mongoose", 5, 7),
      Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
      Item.new("Sulfuras, Hand of Ragnaros", -1, 80),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49),
      Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49),
      # This Conjured item does not work properly yet
      Item.new("Conjured Mana Cake", 3, 6) # <-- :O
    ]
  end
end
