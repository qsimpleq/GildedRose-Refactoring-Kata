# frozen_string_literal: true

require_relative "base"

module GildedRose
  module Products
    class AgedBree < Base
      def update_quality
        item.quality += 1 if item.quality < MAX_QUALITY
        item.sell_in -= 1
        item.quality += 1 if item.quality < MAX_QUALITY && item.sell_in.negative?
      end
    end
  end
end
