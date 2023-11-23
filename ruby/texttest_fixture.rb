#!/usr/bin/ruby -w
# frozen_string_literal: true

require_relative "gilded_rose"

# rubocop:disable Metrics/MethodLength
class TexttestFixture
  def self.run
    puts "OMGHAI!"

    items = prepare_items
    days = ARGV.size.positive? ? (ARGV[0].to_i + 1) : 2

    gilded_rose = GildedRose.new items
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
      [GildedRose::GOODS[:dexterity_vest], 10, 20],
      [GildedRose::GOODS[:aged_brie], 2, 0],
      [GildedRose::GOODS[:mongoose_elixir], 5, 7],
      [GildedRose::GOODS[:sulfuras], 0, 80],
      [GildedRose::GOODS[:sulfuras], -1, 80],
      [GildedRose::GOODS[:tafkal80etc_concert_pass], 15, 20],
      [GildedRose::GOODS[:tafkal80etc_concert_pass], 10, 49],
      [GildedRose::GOODS[:tafkal80etc_concert_pass], 5, 49],
      # This Conjured item does not work properly yet
      [GildedRose::GOODS[:conjured_mana_cake], 3, 6] # <-- :O
    ].map { Item.new(*_1) }
  end
end
# rubocop:enable Metrics/MethodLength

TexttestFixture.run
