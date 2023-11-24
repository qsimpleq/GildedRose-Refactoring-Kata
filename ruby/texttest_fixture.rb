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
      [GildedRose::Constants::GOODS[:dexterity_vest], 10, 20],
      [GildedRose::Constants::GOODS[:aged_brie], 2, 0],
      [GildedRose::Constants::GOODS[:mongoose_elixir], 5, 7],
      [GildedRose::Constants::GOODS[:sulfuras], 0, 80],
      [GildedRose::Constants::GOODS[:sulfuras], -1, 80],
      [GildedRose::Constants::GOODS[:tafkal80etc_concert_pass], 15, 20],
      [GildedRose::Constants::GOODS[:tafkal80etc_concert_pass], 10, 49],
      [GildedRose::Constants::GOODS[:tafkal80etc_concert_pass], 5, 49],
      # This Conjured item does not work properly yet
      [GildedRose::Constants::GOODS[:conjured_mana_cake], 3, 6] # <-- :O
    ].map { GildedRose::Item.new(*_1) }
  end
end
# rubocop:enable Metrics/MethodLength

TexttestFixture.run
