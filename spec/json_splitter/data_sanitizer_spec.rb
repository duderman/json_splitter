# frozen_string_literal: true

RSpec.describe JsonSplitter::DataSanitizer do
  describe ".sanitize!" do
    it "removes _id field" do
      item = { "_id" => 1, "id" => 2 }
      described_class.sanitize!(item)
      expect(item).to eq({ "id" => 2 })
    end

    it "removes empty arrays" do
      item = { "empty" => [], "not_empty" => [1] }
      described_class.sanitize!(item)
      expect(item).to eq({ "not_empty" => [1] })
    end

    it "removes non alpha-numerics from bio" do
      item = { "bio" => "yo   😀 1 😀" }
      described_class.sanitize!(item)
      expect(item).to eq({ "bio" => "yo 1" })
    end
  end
end
