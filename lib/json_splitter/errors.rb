# frozen_string_literal: true

module JsonSplitter
  class Error < StandardError; end
  class FileDoesNotExistError < Error; end
  class NotJSONError < Error; end
end
