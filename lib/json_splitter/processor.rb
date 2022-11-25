# frozen_string_literal: true

require_relative "config"

module JsonSplitter
  class Processor
    def initialize(input, output)
      Config.input = input
      Config.output = output
    end
  end
end
