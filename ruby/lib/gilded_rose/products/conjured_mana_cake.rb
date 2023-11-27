# frozen_string_literal: true

require_relative "normal"

module GildedRose
  module Products
    class ConjuredManaCake < Normal
      def update_quality
        decrease_sell_in
        decrement_quality
        decrement_quality
      end
    end
  end
end
