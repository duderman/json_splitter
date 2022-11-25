# frozen_string_literal: true

RSpec.describe JsonSplitter::Reader do
  let(:instance) { described_class.new(input) }
  let(:input) { File.expand_path("../fixtures/sample_data.json", __dir__) }

  describe "#each_object" do
    it "streams objects into block" do
      expect { |b| instance.each_object(&b) }.to yield_control.twice
    end

    context "when file doesnt exist" do
      let(:input) { "asds" }

      it "raises an error" do
        expect do
          instance.each_object { :ok }
        end.to raise_error(JsonSplitter::FileDoesNotExistError, "file 'asds' does not exist")
      end
    end

    context "when file isn't a JSON file" do
      let(:input) { File.expand_path("../fixtures/not_json.txt", __dir__) }

      it "raises an error" do
        expect do
          instance.each_object { :ok }
        end.to raise_error(JsonSplitter::NotJSONError, "file '#{input}' isn't a valid JSON file")
      end
    end
  end
end
