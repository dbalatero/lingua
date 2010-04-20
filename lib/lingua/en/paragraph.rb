module Lingua
  module EN
    module Paragraph
      # Splits text into an array of paragraphs.
      def self.paragraphs(text)
        text.strip.split(/(?:\n[\r\t ]*)+/).collect { |p| p.strip }
      end
    end
  end
end
