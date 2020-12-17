export class Shop {
  constructor(items = []) {
    this.items = items;
  }

  updateQuality() {
    this.items.forEach(this.updateItem);
    return this.items;
  }

  updateItem(item) {
    switch (item.name) {
      case "Aged Brie":
        item.sellIn--;
        item.quality += item.sellIn < 0 ? 2 : 1;
        if (item.quality > 50) item.quality = 50;
        break;
      case "Backstage passes to a TAFKAL80ETC concert":
        item.sellIn--;
        if (item.sellIn >= 10) {
          item.quality += 1;
        } else if (item.sellIn >= 5) {
          item.quality += 2;
        } else if (item.sellIn >= 0) {
          item.quality += 3;
        } else {
          item.quality = 0;
        }
        if (item.quality > 50) item.quality = 50;
        break;
      case "Sulfuras, Hand of Ragnaros":
        break;
      default:
        item.sellIn--;
        item.quality -= item.sellIn < 0 ? 2 : 1;
        if (item.quality < 0) item.quality = 0;
    }
  }
}
