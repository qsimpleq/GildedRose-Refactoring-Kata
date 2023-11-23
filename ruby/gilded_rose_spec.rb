# frozen_string_literal: true

require_relative "gilded_rose"
require "rspec"

# let(:aged_brie) { Item.new(GildedRose::GOODS[:aged_brie], 5, 10) }
# let(:backstage_pass) { Item.new(GildedRose::GOODS[:backstage_pass], 10, 20) }
# let(:conjured_mana_cake) { Item.new(GildedRose::GOODS[:conjured_mana_cake], 5, 10) }
# let(:sulfuras) { Item.new(GildedRose::GOODS[:sulfuras], 0, 80) }

describe GildedRose do
  describe "#update_quality" do
    def rose_prepare(items)
      gilded_rose = described_class.new(items)
      gilded_rose.update_quality

      def gilded_rose.first_child
        items[0]
      end

      gilded_rose
    end

    context "with dexterity_vest as normal item" do
      let(:name) { GildedRose::GOODS[:dexterity_vest] }

      it "decreases quality and sell_in as it gets older" do
        gilded_rose = rose_prepare([Item.new(name, 10, 20)])

        expect(gilded_rose.first_child.quality).to eq(19)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end

      it "does not decrease quality below the minimum" do
        gilded_rose = rose_prepare([Item.new(name, 10, GildedRose::MIN_QUALITY)])

        expect(gilded_rose.first_child.quality).to eq(GildedRose::MIN_QUALITY)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end
    end

    context "with aged_brie" do
      let(:name) { GildedRose::GOODS[:aged_brie] }

      it "increases quality" do
        gilded_rose = rose_prepare([Item.new(name, 10, 20)])

        expect(gilded_rose.first_child.quality).to eq(21)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end

      it "does not increase quality after the maximum" do
        gilded_rose = rose_prepare([Item.new(name, 10, GildedRose::MAX_QUALITY)])

        expect(gilded_rose.first_child.quality).to eq(GildedRose::MAX_QUALITY)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end
    end

    context "with conjured_mana_cake" do
      let(:name) { GildedRose::GOODS[:conjured_mana_cake] }

      it "decreases in quality twice as fast as normal items" do
        gilded_rose = rose_prepare([Item.new(name, 10, 20)])

        expect(gilded_rose.first_child.quality).to eq(18)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end

      it "does not decrease quality below the minimum" do
        gilded_rose = rose_prepare([Item.new(name, 10, GildedRose::MIN_QUALITY)])

        expect(gilded_rose.first_child.quality).to eq(GildedRose::MIN_QUALITY)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end
    end

    context "with sulfuras" do
      let(:name) { GildedRose::GOODS[:sulfuras] }

      it "does not change the quality or sell_in" do
        gilded_rose = rose_prepare([Item.new(name, 0, 80)])

        expect(gilded_rose.first_child.quality).to eq(80)
        expect(gilded_rose.first_child.sell_in).to eq(0)
      end
    end
  end
end
