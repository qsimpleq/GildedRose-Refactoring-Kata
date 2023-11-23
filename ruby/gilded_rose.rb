# frozen_string_literal: true

require_relative "item"

class GildedRose
  # include GildedRoseHelper

  DEFAULT_MAX_QUALITY = 50
  GOODS = {
    aged_brie: "Aged Brie",
    conjured_mana_cake: "Conjured Mana Cake",
    dexterity_vest: "+5 Dexterity Vest",
    mongoose_elixir: "Elixir of the Mongoose",
    sulfuras: "Sulfuras, Hand of Ragnaros",
    tafkal80etc_concert_pass: "Backstage passes to a TAFKAL80ETC concert"
  }.freeze

  AGED_BRIE = GOODS[:aged_brie]
  BACKSTAGE_PASS = GOODS[:tafkal80etc_concert_pass]
  SULFURAS = GOODS[:sulfuras]
  DEFAULT_QUALITY = 1
  MAX_QUALITY = DEFAULT_MAX_QUALITY
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      handle_quality(item)
      decrement_sell_in(item)
      handle_expired_item(item) if item.sell_in.negative?
    end
  end

  private

  def handle_quality(item)
    if (item.name != GOODS[:aged_brie]) && (item.name != GOODS[:tafkal80etc_concert_pass])
      item.quality = item.quality - 1 if item.quality.positive? && (item.name != GOODS[:sulfuras])
    elsif item.quality < DEFAULT_MAX_QUALITY
      item.quality = item.quality + 1
      if item.name == GOODS[:tafkal80etc_concert_pass]
        item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < DEFAULT_MAX_QUALITY)
        item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < DEFAULT_MAX_QUALITY)
      end
    end
  end

  def decrement_sell_in(item)
    return unless item.name != GOODS[:sulfuras]

    item.sell_in -= 1
  end

  def handle_expired_item(item)
    case item.name
    when AGED_BRIE
      increase_quality(item) if item.quality < DEFAULT_MAX_QUALITY
    when BACKSTAGE_PASS
      item.quality = 0
    else
      decrease_quality(item) if item.quality.positive? && item.name != SULFURAS
    end
  end

  def decrease_quality(item)
    item.quality -= 1
  end

  def increase_quality(item)
    item.quality += 1
  end
end
