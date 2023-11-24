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
    GOODS[:aged_brie] => lambda do |item, obj|
      obj.instance_exec { increase_quality(item) }
    end,
    GOODS[:tafkal80etc_concert_pass] => lambda do |item, obj|
      obj.instance_exec do
        increase_quality(item)
        increase_quality(item) if item.sell_in < 11
        increase_quality(item) if item.sell_in < 6
      end
    end,
    GOODS[:conjured_mana_cake] => lambda do |item, obj|
      obj.instance_exec do
        decrease_quality(item)
        decrease_quality(item)
      end
    end
  }.freeze

  SPECIAL_EXPIRED = {
    GOODS[:aged_brie] => lambda do |item, obj|
      obj.instance_exec { increase_quality(item) }
    end,
    GOODS[:tafkal80etc_concert_pass] => lambda do |item, _|
      item.quality = 0
    end
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
    return SPECIAL_QUALITY[item.name].call(item, self) if SPECIAL_QUALITY.key?(item.name)

    decrease_quality(item)
  end

  def decrement_sell_in(item)
    return unless item.name != GOODS[:sulfuras]

    item.sell_in -= 1
  end

  def calc_quality_of_expired_item(item)
    return unless item.sell_in.negative?

    return SPECIAL_EXPIRED[item.name].call(item, self) if SPECIAL_EXPIRED.key?(item.name)

    decrease_quality(item)
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > MIN_QUALITY && item.name != GOODS[:sulfuras]
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < MAX_QUALITY && item.name != GOODS[:sulfuras]
  end
end
