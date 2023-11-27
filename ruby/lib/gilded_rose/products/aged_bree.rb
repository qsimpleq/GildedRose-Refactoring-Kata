# frozen_string_literal: true

require_relative "base"

module GildedRose
  module Products
    class AgedBree < Base
      def update_quality
        decrease_sell_in
        increment_quality
        increment_quality if sell_in.negative?
      end

      private

      def increment_quality
        item.quality += 1 if quality < MAX_QUALITY
      end
    end
  end
end
