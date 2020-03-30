module WordRectangle
  class TrieNode
    attr_reader :c, :children, :parent, :words
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
        @words = words
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

  def solve(words)
    words_by_size = Hash.new { |hash, key| hash[key] = [] }

    words.each do |word|
      words_by_size[word.size] << word
    end

    tries_by_size = words_by_size.map { |size, words| [size, TrieNode.build_from_list(words)] }.to_h

    sizes = SortedSet.new(words_by_size.keys)
    sizes_reversed = sizes.to_a.reverse
    max_size = sizes_reversed[0]
    max_area = max_size * max_size

    max_area.downto(1) do |area|
      sizes_reversed.each do |row_size|
        if area % row_size != 0
          next
        end

        col_size = area / row_size

        if !sizes.include?(col_size)
          next
        end

        rows = words_by_size[row_size]
        cols = words_by_size[col_size]

        if rows.count < col_size || cols.count < row_size
          next
        end

        trie = tries_by_size[col_size]
        each_valid_combination(rows, col_size, trie) do |crossword|

          # Check to avoid crosswords from the same words on tge rows and columns
          # valid = row_size == col_size ? no_same_words_crosses?(crossword, trie) : true
          valid = true

          if valid
            return [col_size * row_size, crossword]
          end
        end
      end
    end

    nil
  end

  def each_valid_combination(rows, count, trie, res = [], used = Set.new, &block)
    if res.size == count
      if all_word_starts_valid?(res, trie)
        block.call(res)
      end
    else
      if res.size > 0 && all_word_starts_valid?(res, trie) || res.size == 0
        rows.each_with_index do |row, index|
          if !used.include?(index)
            used << index
            each_valid_combination(rows, count, trie, res + [row], used, &block)
            used.delete(index)
          end
        end
      end
    end
  end

  def all_word_starts_valid?(partial_crossword, trie)
    partial_crossword[0].size.times.all? do |col|
      row = 0
      node = trie

      while row < partial_crossword.size && node
        node = node.children[partial_crossword[row][col]]
        row += 1
      end

      node != nil
    end
  end

  def no_same_words_crosses?(crossword, trie)
    row_nodes = Set.new

    crossword.each do |row|
      node = trie

      row.each_char do |c|
        node = node.children[c]
      end

      row_nodes << node
    end

    col_nodes = Set.new

    crossword.size.times do |col|
      node = trie

      crossword.size.times do |row|
        c = crossword[row][col]
        node = node.children[c]
      end

      col_nodes << node
    end

    col_nodes.intersect?(row_nodes) == false
  end

  RSpec.describe 'WordRectangle' do
    include WordRectangle

    subject { solve(words) }

    let(:words) do
      Set.new(
        File.readlines('fixtures/top_3k_words.txt')
          .map(&:strip)
          .map(&:downcase)
          .reject(&:empty?)
          .reject { |w| w.size > 5 } # Alg is still pretty slow so filter very long words to make specs faster
      )
    end

    # it { is_expected.to eq [16, ['that', 'hire', 'idea', 'near']] }
    it { is_expected.to eq [25, ["grass", "rural", "argue", "sauce", "sleep"]] }
  end
end
