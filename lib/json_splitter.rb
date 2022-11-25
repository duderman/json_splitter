# frozen_string_literal: true

require "thor"
require_relative "json_splitter/version"
require_relative "json_splitter/processor"

module JsonSplitter
  class CLI < Thor
    package_name "JsonSplitter"

    desc "process FILE", "Splits big jsons into smaller ones"
    method_option :output, aliases: "-o", desc: "Folder where to save results"
    method_option :batch_size, aliases: "-b", desc: "Batch size for generated files"
    def process(file)
      JsonSplitter::Processor.process(file, options[:output], options[:batch_size])

      puts "Done"
    end
  end
end
