# frozen_string_literal: true

require_relative "item"

class GildedRose
  # include GildedRoseHelper

  DEFAULT_MAX_QUALITY = 50
  GOODS = {
    aged_brie: {
      name: "Aged Brie",
      max_quality: DEFAULT_MAX_QUALITY
    },
    conjured_mana_cake: {
      name: "Conjured Mana Cake",
      max_quality: DEFAULT_MAX_QUALITY
    },
    dexterity_vest: {
      name: "+5 Dexterity Vest",
      max_quality: DEFAULT_MAX_QUALITY
    },
    mongoose_elixir: {
      name: "Elixir of the Mongoose",
      max_quality: DEFAULT_MAX_QUALITY
    },
    sulfuras: {
      name: "Sulfuras, Hand of Ragnaros",
      max_quality: 80
    },
    tafkal80etc_concert_pass: {
      name: "Backstage passes to a TAFKAL80ETC concert",
      max_quality: DEFAULT_MAX_QUALITY
    }
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if (item.name != GOODS[:aged_brie][:name]) && (item.name != GOODS[:tafkal80etc_concert_pass][:name])
        item.quality = item.quality - 1 if item.quality.positive? && (item.name != GOODS[:sulfuras][:name])
      elsif item.quality < DEFAULT_MAX_QUALITY
        item.quality = item.quality + 1
        if item.name == GOODS[:tafkal80etc_concert_pass][:name]
          item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < DEFAULT_MAX_QUALITY)
          item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < DEFAULT_MAX_QUALITY)
        end
      end

      decrement_sell_in(item)

      if item.sell_in.negative?
        if item.name != GOODS[:aged_brie][:name]
          if item.name != GOODS[:tafkal80etc_concert_pass][:name]
            item.quality = item.quality - 1 if item.quality.positive? && (item.name != GOODS[:sulfuras][:name])
          else
            item.quality = 0
          end
        elsif item.quality < DEFAULT_MAX_QUALITY
          item.quality = item.quality + 1
        end
      end
    end
  end

  private

  def decrement_sell_in(item)
    return unless item.name != GOODS[:sulfuras][:name]

    item.sell_in = item.sell_in - 1
  end
end
