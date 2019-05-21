import { Item, ShopOld } from "./gilded_rose_old";
import { Shop } from "./gilded_rose";

describe("gilded_rose", () => {
  it("behaves exactly like old implementation", () => {
    const gildedRoseOld = new ShopOld(buildItems());
    const gildedRose = new Shop(buildItems());

    var days = 50;

    for (var i = 0; i < days; i++) {
      for (var j = 0; j < gildedRose.items.length; j++) {
        var itemOld = gildedRoseOld.items[j];
        var item = gildedRose.items[j];

        expect(item.name).toEqual(itemOld.name);
        expect(item.sellIn).toEqual(itemOld.sellIn);
        expect(item.quality).toEqual(itemOld.quality);
      }

      gildedRoseOld.updateQuality();
      gildedRose.updateQuality();
    }

    function buildItems() {
      return [
        new Item('+5 Dexterity Vest', 10, 20),
        new Item('Aged Brie', 2, 0),
        new Item('Elixir of the Mongoose', 5, 7),
        new Item('Sulfuras, Hand of Ragnaros', 0, 80),
        new Item('Sulfuras, Hand of Ragnaros', -1, 80),
        new Item('Backstage passes to a TAFKAL80ETC concert', 15, 20),
        new Item('Backstage passes to a TAFKAL80ETC concert', 10, 49),
        new Item('Backstage passes to a TAFKAL80ETC concert', 5, 49),
        // this conjured item does not work properly yet
        new Item('Conjured Mana Cake', 3, 6)
      ];
    }
  });
});
