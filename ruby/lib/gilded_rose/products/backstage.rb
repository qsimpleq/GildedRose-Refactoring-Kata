# frozen_string_literal: true

require_relative "base"

module GildedRose
  module Products
    class Backstage < Base
      def update_quality
        item.sell_in -= 1

        return item.quality = 0 if sell_in.negative?

        increment_quality
        increment_quality if sell_in < 11
        increment_quality if sell_in < 6
      end

      private

      def increment_quality
        item.quality += 1 if quality < MAX_QUALITY
      end
    end
  end
end
