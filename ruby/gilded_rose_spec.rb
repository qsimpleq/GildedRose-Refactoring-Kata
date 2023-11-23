# frozen_string_literal: true

require_relative "gilded_rose"
require "rspec"

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
      let(:item) { Item.new(name, 10, GildedRose::MIN_QUALITY) }

      it "decreases quality and sell_in as it gets older" do
        gilded_rose = rose_prepare([Item.new(name, 10, 20)])

        expect(gilded_rose.first_child.quality).to eq(19)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end

      it "does not decrease quality beyond the minimum" do
        gilded_rose = rose_prepare([Item.new(name, 10, GildedRose::MIN_QUALITY)])

        expect(gilded_rose.first_child.quality).to eq(0)
        expect(gilded_rose.first_child.sell_in).to eq(9)
      end
    end

    context 'with sulfuras' do
      let(:name) { GildedRose::GOODS[:sulfuras] }

      it 'does not change the quality or sell_in' do
        gilded_rose = rose_prepare([Item.new(name, 0, 80)])

        expect(gilded_rose.first_child.quality).to eq(80)
        expect(gilded_rose.first_child.sell_in).to eq(0)
      end
    end
  end
end
