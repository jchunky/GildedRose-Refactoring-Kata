export class Shop {
  constructor(items = []) {
    this.items = items;
  }

  updateQuality() {
    this.items.forEach(this.updateItem);
    return this.items;
  }

  updateItem(item) {
    if (item.name === "Aged Brie") {
      item.sellIn--;
      item.quality++;
      if (item.sellIn < 0) {
        item.quality++;
      }
      if (item.quality > 50) {
        item.quality = 50;
      }
    } else if (item.name === "Backstage passes to a TAFKAL80ETC concert") {
      item.sellIn--;
      item.quality++;
      if (item.sellIn < 10) {
        item.quality++;
      }
      if (item.sellIn < 5) {
        item.quality++;
      }
      if (item.sellIn < 0) {
        item.quality = item.quality - item.quality;
      }
      if (item.quality > 50) {
        item.quality = 50;
      }
    } else if (item.name === "Sulfuras, Hand of Ragnaros") {
    } else {
      item.sellIn--;
      item.quality--;
      if (item.sellIn < 0) {
        item.quality--;
      }
      if (item.quality < 0) {
        item.quality = 0;
      }
    }
  }
}
