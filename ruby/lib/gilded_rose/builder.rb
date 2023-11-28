# frozen_string_literal: true

require_relative "products/bree"
require_relative "products/backstage"
require_relative "products/conjured"
require_relative "products/normal"

module GildedRose
  class Builder
    attr_reader :items

    DEFAULT_PRODUCT_CLASS = Products::Normal
    PRODUCT_CLASSES = {
      "Aged Brie" => Products::Bree,
      "Backstage passes to a TAFKAL80ETC concert" => Products::Backstage,
      "Conjured Mana Cake" => Products::Conjured,
      "Sulfuras, Hand of Ragnaros" => Products::Base
    }.freeze

    def initialize(items)
      @items = items
    end

    def update_quality
      @items.each { |item| build_product_of_item(item).update_quality }
    end

    private

    def build_product_of_item(item)
      (PRODUCT_CLASSES[item.name] || DEFAULT_PRODUCT_CLASS).new(item)
    end
  end
end
