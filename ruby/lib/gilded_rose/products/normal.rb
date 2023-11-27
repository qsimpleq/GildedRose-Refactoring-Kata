# frozen_string_literal: true

require_relative "base"

module GildedRose
  module Products
    class Normal < Base
      def update_quality
        decrease_sell_in
        decrement_quality
        decrement_quality if sell_in.negative?
      end

      private

      def decrement_quality
        item.quality -= 1 if quality > MIN_QUALITY
      end
    end
  end
end
