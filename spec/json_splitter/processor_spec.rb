# frozen_string_literal: true

RSpec.describe JsonSplitter::Processor do
  describe ".process" do
    let(:input) { File.expand_path("../fixtures/sample_data.json", __dir__) }
    let(:output) { File.expand_path("../tmp", __dir__) }

    after do
      FileUtils.rm_rf("#{output}/.", secure: true) if Dir.exist?(output)
    end

    it "processes input" do
      described_class.process(input, output, nil)
      expect(File.read("#{output}/results_0.json")).not_to be_empty
    end
  end
end
