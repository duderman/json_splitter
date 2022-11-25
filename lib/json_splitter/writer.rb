# frozen_string_literal: true

require "json"

module JsonSplitter
  class Writer
    DEFAULT_BATCH_SIZE = 100

    def initialize(output_dir, batch_size)
      @output_dir = output_dir
      @batch_size = batch_size
      @objects_written = 0
      @current_file_id = 0
    end

    def write(object)
      next_file_or_comma
      current_file << object.to_json
      @objects_written += 1
    end

    def finish
      next_file
    end

    private

    def next_file_or_comma
      return next_file if next_file?
      return if new_file?

      current_file << ","
    end

    def next_file?
      @objects_written >= batch_size
    end

    def new_file?
      @objects_written.zero?
    end

    def next_file
      current_file << "]"
      current_file.flush
      current_file.close
      @current_file = nil
      @current_file_id += 1
      @objects_written = 0
    end

    def batch_size
      @batch_size || DEFAULT_BATCH_SIZE
    end

    def current_file
      @current_file ||= File.new(current_file_path, "w").tap { _1 << "[" }
    rescue Errno::ENOENT
      raise JsonSplitter::PathDoesNotExistError, "directory '#{output_dir}' doesn't exist"
    end

    def current_file_path
      File.expand_path("results_#{@current_file_id}.json", output_dir)
    end

    def output_dir
      @output_dir || Dir.pwd
    end
  end
end
