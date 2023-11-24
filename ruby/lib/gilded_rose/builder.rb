# frozen_string_literal: true

require_relative "item"
require_relative "special"

module GildedRose
  class Builder
    attr_reader :items

    include Constants
    include Special

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
end
