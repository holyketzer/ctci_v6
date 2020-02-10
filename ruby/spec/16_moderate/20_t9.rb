module T9
  KEY_TO_CHAR = {
    '2' => %w(a b c),
    '3' => %w(d e f),
    '4' => %w(g h i),
    '5' => %w(j k l),
    '6' => %w(m n o),
    '7' => %w(p q r s),
    '8' => %w(t u v),
    '9' => %w(w x y z),
  }.freeze

  # n=input.size Time=O(n^3.25) Mem=O(n^3.25)
  # tree - is prefix tree with dictionary
  def solve(tree, input)
    nodes = [tree]

    input.each_char do |key|
      next_nodes = [] # Mistake 1: defined inside KEY_TO_CHAR loop

      if KEY_TO_CHAR[key] == nil
        raise ArgumentError, "unexpected key #{key}"
      end

      KEY_TO_CHAR[key].each do |c|
        if c
          nodes.each do |node|
            if (child = node.children[c])
              next_nodes << child
            end
          end
        end
      end

      nodes = next_nodes
    end

    nodes.select(&:word?).map(&:build_word)
  end

  class Node
    attr_reader :c, :children, :parent
    attr_accessor :word

    def initialize(c = '', parent: nil)
      @c = c
      @parent = parent
      @word = false
      @children = {}
    end

    def word?
      @word
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
        root = Node.new

        words.each do |word|
          curr = root

          word.each_char do |c|
            child = (curr.children[c] ||= Node.new(c, parent: curr))
            curr = child
          end

          curr.word = true
        end

        root
      end
    end
  end

  RSpec.describe 'solve' do
    include T9

    subject { solve(tree, input).sort }

    let(:tree) do
      Node.build_from_list(
        File.readlines('fixtures/top_3k_words.txt').map(&:strip).map(&:downcase).reject(&:empty?)
      )
    end

    context '8733' do
      let(:input) { '8733' }

      it { is_expected.to eq %w(tree used) }
    end

    context '9268' do
      let(:input) { '9268' }

      it { is_expected.to eq %w(want) }
    end

    context '33835676368' do
      let(:input) { '33835676368' }

      it { is_expected.to eq %w(development) }
    end

    context '123' do
      let(:input) { '123' }

      it { expect { subject }.to raise_error(ArgumentError, /unexpected key 1/) }
    end
  end
end
