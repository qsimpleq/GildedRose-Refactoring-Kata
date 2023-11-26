# frozen_string_literal: true

require "rspec"
require_relative "../lib/gilded_rose"

describe GildedRose do
  describe "#update_quality" do
    def rose_prepare(items)
      gilded_rose = GildedRose.build(items)
      gilded_rose.update_quality

      def gilded_rose.first_child
        items[0]
      end

      gilded_rose
    end

    def test_item(sell_in, sell_in_expected, quality, quality_expected)
      gilded_rose = rose_prepare([GildedRose::Item.new(name, sell_in, quality)])

      expect(gilded_rose.first_child.sell_in).to eq(sell_in_expected)
      expect(gilded_rose.first_child.quality).to eq(quality_expected)
    end

    context "with dexterity_vest as normal item" do
      let(:name) { GildedRose::Constants::GOODS[:dexterity_vest] }

      it "decreases quality and sell_in as it gets older" do
        test_item(10, 9, 20, 19)
      end

      it "does not decrease quality below the minimum" do
        test_item(0, -1, GildedRose::Constants::MIN_QUALITY, GildedRose::Constants::MIN_QUALITY)
      end
    end

    context "with aged_brie" do
      let(:name) { GildedRose::Constants::GOODS[:aged_brie] }

      it "increases quality" do
        test_item(10, 9, 20, 21)
      end

      it "does not increase quality after the maximum" do
        test_item(10, 9, GildedRose::Constants::MAX_QUALITY, GildedRose::Constants::MAX_QUALITY)
      end
    end

    context "with tafkal80etc_concert_pass" do
      let(:name) { GildedRose::Constants::GOODS[:tafkal80etc_concert_pass] }

      it "increases quality" do
        test_item(20, 19, 20, 21)
      end

      it "increases quality by 2 on sell_in < 11" do
        test_item(10, 9, 20, 22)
      end

      it "increases quality by 3 on sell_in < 6" do
        test_item(5, 4, 20, 23)
      end
    end

    context "with conjured_mana_cake" do
      let(:name) { GildedRose::Constants::GOODS[:conjured_mana_cake] }

      it "decreases in quality twice as fast as normal items" do
        test_item(10, 9, 20, 18)
      end
    end

    context "with sulfuras" do
      let(:name) { GildedRose::Constants::GOODS[:sulfuras] }

      it "does not change the quality or sell_in" do
        test_item(0, 0, 80, 80)
      end
    end
  end
end
