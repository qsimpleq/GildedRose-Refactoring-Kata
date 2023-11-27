# frozen_string_literal: true

require_relative "normal"

module GildedRose
  module Products
    class ConjuredManaCake < Normal
      def update_quality
        item.sell_in -= 1

        decrement_quality
        decrement_quality
      end
    end
  end
end
