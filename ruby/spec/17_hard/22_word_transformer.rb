module WordTransformer
  class TrieNode
    attr_reader :c, :children, :parent
    attr_accessor :word

    def initialize(c = '', parent: nil)
      @c = c
      @parent = parent
      @word = false
      @children = {}
    end

    def find(pattern, index = 0, res = [])
      if index == pattern.size && word
        res << self
      else
        char = pattern[index]

        if char == '*'
          children.values.each do |child_node|
            child_node.find(pattern, index + 1, res)
          end
        else
          children[char]&.find(pattern, index + 1, res)
        end
      end

      res
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

  def solve(dict, original, target)
    if original.size != target.size
      raise ArgumentError, "original and target word have different sizes"
    end

    trie = TrieNode.build_from_list(dict)

    original_node = trie.find(original)[0]
    target_node = trie.find(target)[0]

    bfs(trie, original_node, target_node, original.size)
  end


  # Finds shorter path
  def bfs(trie, original, target, word_size)
    path = {}
    sources = [original]

    while sources.size > 0 do
      new_sources = []

      sources.each do |source|
        word = source.build_word
        wild_cards = word_size.times.map { |i| word.dup.tap { |w| w[i] = '*' } }
        nodes = wild_cards.flat_map { |wild_card| trie.find(wild_card) }

        nodes.each do |node|
          if !path.include?(node) && node != original
            path[node] = source
            new_sources << node
          end

          if node == target
            return build_chain(path, target)
          end
        end
      end

      sources = new_sources
    end

    nil
  end

  def build_chain(path, target)
    res = []

    while target != nil do
      res << target
      target = path[target]
    end

    res.reverse.map!(&:build_word)
  end

  RSpec.describe 'WordTransformer' do
    include WordTransformer

    subject { solve(dict, original, target) }

    let(:trie) { TrieNode.build_from_list(dict) }

    let(:dict) do
      (%w(damp lamp limp lime like) + File.readlines('fixtures/top_3k_words.txt'))
        .map(&:strip)
        .map(&:downcase)
        .reject(&:empty?)
    end

    context 'book sample' do
      let(:original) { 'damp' }
      let(:target) { 'like' }

      it { is_expected.to eq %w(damp lamp limp lime like) }
    end

    context 'not existing path' do
      let(:original) { 'damp' }
      let(:target) { 'able' }

      it { is_expected.to eq nil }
    end

    context 'fall -> busy path' do
      let(:original) { 'fall' }
      let(:target) { 'busy' }

      it { is_expected.to eq %w(fall mall male make cake care core corn born burn bury busy) }
    end

    context 'boat -> dark' do
      let(:original) { 'boat' }
      let(:target) { 'dark' }

      it { is_expected.to eq %w(boat coat cost post past part park dark) }
    end
  end
end
