# frozen_string_literal: true

require_relative "item"

class GildedRose
  attr_reader :items

  MIN_QUALITY = 0
  MAX_QUALITY = 50
  GOODS = {
    aged_brie: "Aged Brie",
    conjured_mana_cake: "Conjured Mana Cake",
    dexterity_vest: "+5 Dexterity Vest",
    mongoose_elixir: "Elixir of the Mongoose",
    sulfuras: "Sulfuras, Hand of Ragnaros",
    tafkal80etc_concert_pass: "Backstage passes to a TAFKAL80ETC concert"
  }.freeze

  SPECIAL_QUALITY = {
    GOODS[:aged_brie] => 1,
    GOODS[:tafkal80etc_concert_pass] => 1,
    GOODS[:conjured_mana_cake] => 1
  }.freeze
  SPECIAL_EXPIRED = {
    GOODS[:aged_brie] => 1,
    GOODS[:tafkal80etc_concert_pass] => 1
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      calc_quality(item)
      decrement_sell_in(item)
      calc_quality_of_expired_item(item)
    end
  end

  private

  def calc_quality(item)
    if SPECIAL_QUALITY.key?(item.name)
      calc_quality_of_special_item(item)
    else
      decrease_quality(item)
    end
  end

  def decrement_sell_in(item)
    return unless item.name != GOODS[:sulfuras]

    item.sell_in -= 1
  end

  def calc_quality_of_expired_item(item)
    return unless item.sell_in.negative?

    return decrease_quality(item) unless SPECIAL_EXPIRED.key?(item.name)

    calc_quality_of_special_expired_item(item)
  end

  def calc_quality_of_special_expired_item(item)
    case item.name
    when GOODS[:aged_brie]
      increase_quality(item)
    when GOODS[:tafkal80etc_concert_pass]
      item.quality = 0
    end
  end

  def calc_quality_of_special_item(item)
    return if calc_quality_conjured_mana_cake(item)

    increase_quality(item)

    calc_quality_tafkal80etc_concert_pass(item)
  end

  def calc_quality_conjured_mana_cake(item)
    return unless item.name == GOODS[:conjured_mana_cake]

    decrease_quality(item)
    decrease_quality(item)

    item
  end

  def calc_quality_tafkal80etc_concert_pass(item)
    return unless item.name == GOODS[:tafkal80etc_concert_pass]

    increase_quality(item) if item.sell_in < 11
    increase_quality(item) if item.sell_in < 6

    item
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > MIN_QUALITY && item.name != GOODS[:sulfuras]
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < MAX_QUALITY && item.name != GOODS[:sulfuras]
  end
end
