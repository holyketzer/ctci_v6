module WordDistance
  class Measurer
    def initialize(text)
      @words = parse_text(text)
    end

    def parse_text(text)
      res = {}

      words = text
        .split(/[\s\.\,\!\?\;\:\"\'\(\)]/)
        .map(&:strip)
        .map(&:downcase)
        .reject(&:empty?)

      words.each_with_index do |word, i|
        res[word] ||= []
        res[word] << i
      end

      res
    end

    def find_distance(w1, w2)
      i1 = @words[w1]
      i2 = @words[w2]

      if i1 == nil || i2 == nil
        return nil
      end

      res = (i1[0] - i2[0]).abs

      # Iterate over the smallest list
      if i1.size > i2.size
        i1, i2 = i2, i1
      end

      i1.each do |i|
        j = find_nearest(i2, i)

        diff = (i - j).abs

        if diff < res
          res = diff

          if res == 1
            break
          end
        end
      end

      res
    end

    def find_nearest(arr, x)
      l = 0
      r = arr.size - 1

      while l < r do
        i = (r + l) / 2

        if arr[i] < x
          l = i + 1
        else
          r = i
        end
      end

      arr[l]
    end
  end

  RSpec.describe 'WordDistance' do
    include WordDistance

    let(:measurer) { Measurer.new(text) }

    let(:text) do
      <<~TEXT
        There are important differences between plain text (created and edited by text editors)
        and rich text (such as that created by word processors or desktop publishing software).

        Plain text exclusively consists of character representation. Each character is represented
        by a fixed-length sequence of one, two, or four bytes, or as a variable-length sequence of
        one to four bytes, in accordance to specific character encoding conventions, such as ASCII,
        ISO/IEC 2022, UTF-8, or Unicode. These conventions define many printable characters, but also
        non-printing characters that control the flow of the text, such space, line break, and page break.
        Plain text contains no other information about the text itself, not even the character encoding
        convention employed. Plain text is stored in text files, although text files do not exclusively
        store plain text. In the early days of computers, plain text was displayed using a monospace
        font, such that horizontal alignment and columnar formatting were sometimes done using whitespace
        characters. For compatibility reasons, this tradition has not changed.

        Rich text, on the other hand, may contain metadata, character formatting data (e.g. typeface,
        size, weight and style), paragraph formatting data (e.g. indentation, alignment, letter and word
        distribution, and space between lines or other paragraphs), and page specification data (e.g. size,
        margin and reading direction). Rich text can be very complex. Rich text can be saved in binary format
        (e.g. DOC), text files adhering to a markup language (e.g. RTF or HTML), or in a hybrid form of both
        (e.g. Office Open XML).
      TEXT
    end

    it do
      expect(measurer.find_distance('rich', 'bunny')).to eq nil
      expect(measurer.find_distance('rich', 'text')).to eq 1
      expect(measurer.find_distance('stored', 'text')).to eq 2
      expect(measurer.find_distance('text', 'stored')).to eq 2
    end
  end
end
