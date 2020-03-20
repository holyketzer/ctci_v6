module LongestWord
  class TrieNode
    attr_reader :c, :children, :parent
    attr_accessor :word

    def initialize(c = '', parent: nil)
      @c = c
      @parent = parent
      @word = false
      @children = {}
    end

    def start_of_word?(str, index = 0)
      if index == str.size
        true
      else
        if (child = children[str[index]])
          child.start_of_word?(str, index + 1)
        else
          false
        end
      end
    end

    def word?(str, index = 0)
      if index == str.size
        word
      else
        if (child = children[str[index]])
          child.word?(str, index + 1)
        else
          false
        end
      end
    end

    def build_word
      res = [@c]
      node = parent

      while node do
        res << node.c
        node = node.parent
      end

      res.reverse.join
    end

    def nodes_count
      twc = word ? 1 : 0
      tnc = children.size

      children.each do |c, child|
        wc, nc = *child.nodes_count
        twc += wc
        tnc += nc
      end

      [twc, tnc]
    end

    class << self
      def build_from_list(words)
        root = TrieNode.new

        words.each do |word|
          curr = root

          word.each_char do |c|
            child = (curr.children[c] ||= TrieNode.new(c, parent: curr))
            curr = child
          end

          curr.word = true
        end

        root
      end
    end
  end

  # Time=O(n * (k ^ log n)) Mem=O(n), n - words count,
  # k - coeff average complexity of the word (how much another words usually average word contains)
  def solve(words)
    words.sort_by! { |word| -word.size }
    dict = TrieNode.build_from_list(words)

    words.each do |word|
      if is_complex_word?(word, dict)
        return word
      end
    end

    nil
  end

  def is_complex_word?(word, dict, index = 0)
    offset = index

    while offset < word.size do
      part = word[index..offset]

      if dict.word?(part)
        # mistake 1: forgot to check that there is more than 1 word in complex word (index > 0)
        if (offset == word.size - 1 && index > 0) || is_complex_word?(word, dict, offset + 1)
          return true
        else
          offset += 1
        end
      elsif dict.start_of_word?(part)
        offset += 1
      else
        return false
      end
    end

    false
  end

  RSpec.describe 'LongestWord' do
    include LongestWord

    subject { solve(words) }

    context 'book example' do
      let(:words) { %w(cat banana dog nana walk walker dogwalker) }

      it { is_expected.to eq 'dogwalker' }
    end

    context 'my example' do
      let(:words) { %w(cat banana dog nana walk walker dogwalker bananawalk catodoganana) }

      it { is_expected.to eq 'bananawalk' }
    end
  end
end
