# frozen_string_literal: true

require_relative "constants"

module GildedRose
  module Special
    include Constants

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
  end
end
