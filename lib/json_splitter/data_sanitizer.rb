# frozen_string_literal: true

require "emoji_regex"

module JsonSplitter
  class DataSanitizer
    class << self
      def sanitize!(item)
        new(item).sanitize!
      end
    end

    def initialize(item)
      @item = item
    end

    def sanitize!
      remove_id
      remove_empty_arrays
      clean_bio

      @item
    end

    private

    def remove_id
      @item.delete("_id")
    end

    def remove_empty_arrays
      @item.reject! { _2.is_a?(Array) && _2.empty? }
    end

    def clean_bio
      @item
        .fetch("bio", "".dup)
        .tap { _1.gsub!(EmojiRegex::Regex, "") }
        .tap { _1.gsub!(/(?![[:alnum:]])/, "") }
        .tap { _1.gsub!(/\s{2,}/, " ") }
        .strip!
    end
  end
end
