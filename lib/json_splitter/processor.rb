# frozen_string_literal: true

require_relative "config"
require_relative "reader"
require_relative "writer"
require_relative "errors"

module JsonSplitter
  class Processor
    def initialize(input, output)
      Config.input = input
      Config.output = output
    end
  end
end
