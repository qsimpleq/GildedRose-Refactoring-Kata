# frozen_string_literal: true

require_relative "base"

module GildedRose
  module Products
    class Normal < Base
      def update_quality
        item.sell_in -= 1

        item.quality -= 1 if quality > MIN_QUALITY
      end
    end
  end
end
