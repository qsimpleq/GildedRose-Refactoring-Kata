# frozen_string_literal: true

require_relative "constants"

module GildedRose
  module Products
    class Base
      attr_reader :item

      include Constants

      def initialize(item)
        @item = item
      end

      def update_quality; end

      def quality
        item.quality
      end

      def sell_in
        item.sell_in
      end

      def decrease_sell_in
        item.sell_in -= 1
      end
    end
  end
end
