# frozen_string_literal: true

require_relative "gilded_rose/builder"

module GildedRose
  def self.build(*) = Builder.new(*)

  class Item
    attr_accessor :name, :sell_in, :quality

    def initialize(name, sell_in, quality)
      @name = name
      @sell_in = sell_in
      @quality = quality
    end

    def to_s
      "#{@name}, #{@sell_in}, #{@quality}"
    end
  end
end
