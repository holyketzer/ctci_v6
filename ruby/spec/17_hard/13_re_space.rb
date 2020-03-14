module ReSpace
  MAX_WORD_SIZE = 20

  class TrieNode
    attr_reader :c, :children, :parent
    attr_accessor :word

    def initialize(c = '', parent: nil)
      @c = c
      @parent = parent
      @word = false
      @children = {}
    end

    def can_be_a_part_of_word?(str, index = 0)
      if index == str.size
        true
      else
        if (child = children[str[index]])
          child.can_be_a_part_of_word?(str, index + 1)
        else
          false
        end
      end
    end

    def word?(str, index = 0)
      if index == str.size
        if str == 'liket'
          puts "!!! #{str} #{word}"
        end
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

  def solve_a(dict, text)
    dict = TrieNode.build_from_list(dict)
    urcc, sentence = *solve_a_iteration(dict, text)
    sentence
  end

  def solve_a_iteration(dict, text, from = 0, words = [], urcc = 0)
    rest = text[from..-1]
    min_urcc = urcc + rest.size
    sentence = words + (rest.size > 0 ? [rest] : [])

    # save words size and last word because it can't be modified during evaluation
    # and we can avoid unnecesarry array duplication just recovering previous words state
    inital_words_count = words.size
    last_word = words.last

    while from < text.size do
      offset = from

      while offset < text.size do
        word = text[from..offset]

        if !dict.can_be_a_part_of_word?(word)
          break
        end

        words << word

        if dict.word?(word)
          new_urcc, new_sentence = *solve_a_iteration(dict, text, offset + 1, words, urcc)
        elsif words.size > 1 && dict.word?(words[-2])
          new_urcc, new_sentence = *solve_a_iteration(dict, text, offset + 1, words, urcc + word.size)
        else
          new_urcc = text.size
          new_sentence = nil
        end

        if new_urcc < min_urcc
          min_urcc = new_urcc
          sentence = new_sentence.dup
        end

        words.delete_at(words.size - 1)

        offset += 1
      end

      if from == 0 || dict.word?(words.last)
        words << text[from, 1]
      else
        words[words.size - 1] += text[from, 1]
      end

      urcc += 1
      from += 1
    end

    # Recorer original words array
    while words.size > inital_words_count do
      words.delete_at(words.size - 1)
    end

    if last_word
      words[-1] = last_word
    end

    [min_urcc, sentence]
  end

  def solve_b(dict, text)
    dict = TrieNode.build_from_list(dict)
    urcc, sentence = *solve_b_iteration(dict, text)
    sentence
  end

  def solve_b_iteration(dict, text, cache = {}, from = 0)
    if cache[from]
      return cache[from]
    end

    best_urcc = text.size - from
    best_sentence = best_urcc == 0 ? [] : [text[from, text.size - 1]]
    part = ''
    offset = from

    while offset < text.size do
      part += text[offset, 1]

      urcc = dict.word?(part) ? 0 : part.size

      if urcc < best_urcc
        rest_urcc, rest_sentence = *solve_b_iteration(dict, text, cache, offset + 1)

        if urcc + rest_urcc < best_urcc
          best_urcc = urcc + rest_urcc

          if rest_sentence.size > 0 && !dict.word?(part) && !dict.word?(rest_sentence[0])
            best_sentence = rest_sentence.dup
            best_sentence[0] = part + best_sentence[0]
          else
            best_sentence = [part] + rest_sentence
          end

          if best_urcc == 0
            break
          end
        end
      end

      offset += 1
    end

    cache[from] = [best_urcc, best_sentence]
  end

  RSpec.describe 'ReSpace' do
    include ReSpace

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", dict, text) }

        let(:dict) do
          %w(
            a
            brother
            cool
            her
            his
            is
            just
            like
            looked
            man
            my
            on
            sister
          )
        end

        context 'book example' do
          let(:text) { 'jesslookedjustliketimherbrother' }

          it { is_expected.to eq %w(jess looked just like tim her brother) }
        end

        context 'my example' do
          let(:text) { 'my brother simon is a very cool man'.gsub(' ', '') }

          it { is_expected.to eq %w(my brother sim on is a very cool man) }
        end
      end
    end
  end
end
