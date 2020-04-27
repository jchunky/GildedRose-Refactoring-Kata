function updateItem(item) {
  if (item.name === "Sulfuras, Hand of Ragnaros") return;
  item.sellIn -= 1;
  updateItemQuality();
  if (item.quality < 0) item.quality = 0;
  if (item.quality > 50) item.quality = 50;

  function updateItemQuality() {
    switch (item.name) {
      case "Aged Brie":
        agedBrie();
        break;
      case "Backstage passes to a TAFKAL80ETC concert":
        backstagePasses();
        break;
      default:
        normalItem();
        break;
    }
  }

  function agedBrie() {
    item.quality += item.sellIn < 0 ? 2 : 1;
  }

  function backstagePasses() {
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

  function normalItem() {
    item.quality -= item.sellIn < 0 ? 2 : 1;
  }
}

export class Shop {
  constructor(items = []) {
    this.items = items;
  }

  updateQuality() {
    this.items.forEach(updateItem);
    return this.items;
  }
}
