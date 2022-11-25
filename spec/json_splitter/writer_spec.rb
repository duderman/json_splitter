# frozen_string_literal: true

require "fileutils"

RSpec.describe JsonSplitter::Writer do
  let(:instance) { described_class.new(output, batch_size) }
  let(:output) { File.expand_path("../tmp", __dir__) }
  let(:batch_size) { 2 }

  after do
    FileUtils.rm_rf("#{output}/.", secure: true) if output && Dir.exist?(output)
  end

  describe "#write" do
    it "writes objects to output in batches" do
      instance.write({ a: 1 })
      instance.write({ a: 2 })
      instance.write({ b: 2 })
      instance.finish
      expect(Dir["#{output}/*"]).to eq(["#{output}/results_0.json", "#{output}/results_1.json"])
      expect(File.read("#{output}/results_0.json")).to eq('[{"a":1},{"a":2}]')
      expect(File.read("#{output}/results_1.json")).to eq('[{"b":2}]')
    end

    context "when batch_size isn't provided" do
      let(:batch_size) { nil }

      it "defaults to 100" do
        101.times { instance.write({ a: 1 }) }
        instance.finish
        expect(Dir["#{output}/*"]).to eq(["#{output}/results_0.json", "#{output}/results_1.json"])
      end
    end

    context "when output is not provided" do
      let(:output) { nil }
      let(:expected_file_path) { "#{Dir.pwd}/results_0.json" }

      after { FileUtils.rm_f(expected_file_path) }

      it "writes to a current directory" do
        instance.write({ a: 1 })
        instance.finish
        puts Dir["#{Dir.pwd}/*.json"]
        expect(Dir["#{Dir.pwd}/*.json"]).to eq([expected_file_path])
      end
    end

    context "when dir doesn't exist" do
      let(:output) { "asd" }

      it "raises an error" do
        expect do
          instance.write({})
        end.to raise_error(JsonSplitter::PathDoesNotExistError, "directory 'asd' doesn't exist")
      end
    end
  end
end
