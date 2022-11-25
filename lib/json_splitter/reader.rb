# frozen_string_literal: true

require "json/streamer"

module JsonSplitter
  class Reader
    def initialize(input)
      @input = input
    end

    def each_object(&block)
      streamer.get(nesting_level: 1, yield_values: false, &block)
    rescue JSON::Stream::ParserError
      raise JsonSplitter::NotJSONError, "file '#{@input}' isn't a valid JSON file"
    end

    private

    def streamer
      @streamer ||= ::Json::Streamer.parser(file_io: file_stream)
    end

    def file_stream
      @file_stream ||= File.open(@input, "r")
    rescue Errno::ENOENT
      raise JsonSplitter::FileDoesNotExistError, "file '#{@input}' does not exist"
    end
  end
end
