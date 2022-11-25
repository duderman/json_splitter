# frozen_string_literal: true

RSpec.describe JsonSplitter::Processor do
  describe "#initialize" do
    it "saves input and output to config" do
      described_class.new(1, 2)
      expect(JsonSplitter::Config.input).to be(1)
      expect(JsonSplitter::Config.output).to be(2)
    end
  end
end
