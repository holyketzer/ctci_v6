class Book
  def initialize(text)
    @text = text
  end

  def dictionary
    @dictionary ||= begin
      dict = Hash.new { |hash, key| hash[key] = 0 }
      @text.split(/(\.|\,|\s|\')/).map(&:strip).map(&:downcase).reject(&:empty?).reduce(dict) do |res, word|
        res[word] += 1
        res
      end
    end
  end

  def frequency(word)
    dictionary[word.downcase]
  end
end

RSpec.describe 'Book' do
  let(:book) { Book.new(text) }

  let(:text) do
    <<~TEXT.gsub("\n", ' ')
      Rich Hickey developed Clojure because he wanted a modern Lisp for functional programming,
      symbiotic with the established Java platform, and designed for concurrency.[23][24][36][15]

      Clojure's approach to state is characterized by the concept of identities,[22] which are
      represented as a series of immutable states over time. Since states are immutable values,
      any number of workers can operate on them in parallel, and concurrency becomes a question
      of managing changes from one state to another. For this purpose, Clojure provides several
      mutable reference types, each having well-defined semantics for the transition between
      states.[22]
    TEXT
  end

  describe '#frequency' do
    it do
      expect(book.frequency('with')).to eq 1
      expect(book.frequency('a')).to eq 3
      expect(book.frequency('Clojure')).to eq 3
    end
  end
end
