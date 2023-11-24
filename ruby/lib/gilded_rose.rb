# frozen_string_literal: true

require_relative "gilded_rose/builder"

module GildedRose
  def self.build(*) = Builder.new(*)
end
