# frozen_string_literal: true

require_relative "base"

module GildedRose
  module Products
    class Backstage < Base
      INCREMENT_BY_TWO_FROM_TEN = 10
      INCREMENT_BY_THREE_FROM_FIVE = 5

      def update_quality
        decrease_sell_in

        return item.quality = 0 if sell_in.negative?

        increment_quality
        increment_quality if sell_in < INCREMENT_BY_TWO_FROM_TEN
        increment_quality if sell_in < INCREMENT_BY_THREE_FROM_FIVE
      end

      private

      def increment_quality
        item.quality += 1 if quality < MAX_QUALITY
      end
    end
  end
end
