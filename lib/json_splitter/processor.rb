# frozen_string_literal: true

require_relative "reader"
require_relative "writer"
require_relative "data_sanitizer"
require_relative "errors"

module JsonSplitter
  class Processor
    class << self
      def process(*args)
        new(*args).process
      end
    end

    def initialize(input, output, batch_size)
      @input = input
      @output = output
      @batch_size = batch_size
    end

    def process
      reader.each_object do |object|
        object
          .tap(&DataSanitizer.method(:sanitize!))
          .tap(&writer.method(:write))
      end

      writer.finish

      :ok
    end

    private

    def reader
      @reader ||= Reader.new(@input)
    end

    def writer
      @writer ||= Writer.new(@output, @batch_size)
    end
  end
end
