function doUpdateQuality(items) {
  items.forEach(updateItem);

  function updateItem(item) {
    if (item.name === "Sulfuras, Hand of Ragnaros") return;
    updateItemQuality(item);
    if (item.quality < 0) item.quality = 0;
    if (item.quality > 50) item.quality = 50;
  }

  function updateItemQuality(item) {
    switch (item.name) {
      case "Aged Brie":
        agedBrie(item);
        break;
      case "Backstage passes to a TAFKAL80ETC concert":
        backstagePasses(item);
        break;
      default:
        normalItem(item);
        break;
    }
  }

  function agedBrie(item) {
    item.sellIn -= 1;
    item.quality += item.sellIn < 0 ? 2 : 1;
  }

  function backstagePasses(item) {
    item.sellIn -= 1;

    if (item.sellIn < 0) {
      item.quality = 0;
    } else if (item.sellIn < 5) {
      item.quality += 3;
    } else if (item.sellIn < 10) {
      item.quality += 2;
    } else {
      item.quality += 1;
    }
  }

  function normalItem(item) {
    item.sellIn -= 1;
    item.quality -= item.sellIn < 0 ? 2 : 1;
  }
}

export class Shop {
  constructor(items = []) {
    this.items = items;
  }

  updateQuality() {
    doUpdateQuality(this.items);
    return this.items;
  }
}
