#!/usr/bin/ruby -w
# frozen_string_literal: true

require_relative "lib/gilded_rose"

# rubocop:disable Metrics/MethodLength
class TexttestFixture
  def self.run
    puts "OMGHAI!"

    items = prepare_items
    days = ARGV.size.positive? ? (ARGV[0].to_i + 1) : 2

    gilded_rose = GildedRose.build items
    (0...days).each do |day|
      puts "-------- day #{day} --------"
      puts "name, sellIn, quality"
      items.each do |item|
        puts item
      end
      puts ""
      gilded_rose.update_quality
    end
  end

  def self.prepare_items
    [
      ["+5 Dexterity Vest", 10, 20],
      ["Aged Brie", 2, 0],
      ["Elixir of the Mongoose", 5, 7],
      ["Sulfuras, Hand of Ragnaros", 0, 80],
      ["Sulfuras, Hand of Ragnaros", -1, 80],
      ["Backstage passes to a TAFKAL80ETC concert", 15, 20],
      ["Backstage passes to a TAFKAL80ETC concert", 10, 49],
      ["Backstage passes to a TAFKAL80ETC concert", 5, 49],
      # This Conjured item does not work properly yet
      ["Conjured Mana Cake", 3, 6] # <-- :O
    ].map { GildedRose::Item.new(*_1) }
  end
end
# rubocop:enable Metrics/MethodLength

TexttestFixture.run
