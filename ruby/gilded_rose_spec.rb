# frozen_string_literal: true

require_relative "gilded_rose"
require "rspec"

describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      described_class.new(items).update_quality
      expect(items[0].name).to eq "fixme"
    end
  end
end
