class Card
  SUITS = [:clubs, :diamonds, :hearts, :spades].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A, :JOCKER].freeze

  VALUES_INDEXES = VALUES.each_with_index.reduce({}) do |res, (value, index)|
    res.merge!(value => index)
  end.freeze

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{suit_symbol} #{value}"
  end

  def suit_symbol
    case suit
    when :clubs then '♧'
    when :diamonds then '♢'
    when :hearts then '♡'
    when :spades then '♤'
    else raise ArgumentError, "unknown suit #{suit}"
    end
  end

  class << self
    def each_suit(&block)
      SUITS.each do |suit|
        block.call(suit)
      end
    end

    def each_value(from = 2, to = :JOCKER, &block)
      range = VALUES_INDEXES[from]..VALUES_INDEXES[to]
      VALUES[range].each do |value|
        block.call(value)
      end
    end

    def each_suit_and_value(from = 2, to = :JOCKER, &block)
      each_suit do |suit|
        each_value(from, to) do |value|
          block.call(suit, value)
        end
      end
    end
  end
end

class CardSet
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def shuffle
    @cards.shuffle!
    self
  end
end

class Deck < CardSet
  class << self
    def build36
      cards = []

      Card.each_suit_and_value(6, :A) do |suit, value|
        cards << Card.new(suit, value)
      end

      Deck.new(cards).shuffle
    end

    def build52
      cards = []

      Card.each_suit_and_value(2, :A) do |suit, value|
        cards << Card.new(suit, value)
      end

      Deck.new(cards).shuffle
    end
  end
end

class Hand < CardSet
end

class BlackJackGame
  def buildDeck()
    Deck.build52
  end

  def score_hand(hand)
    hand.cards.reduce(0) do |res, card|
      res + score_card(card, res)
    end
  end

  def score_card(card, total)
    case card.value
    when :J, :Q, :K
      10
    when :A
      total >= 21 ? 1 : 11
    when :JOCKER
      raise ArgumentError, "unexpected card #{card.value}"
    else
      card.value
    end
  end
end

RSpec.describe 'BlackJack' do
  describe 'Deck.build' do
    it do
      expect(Deck.build36.cards.size).to eq 36
      expect(Deck.build52.cards.size).to eq 52
    end
  end

  describe 'score_hand' do
    subject { game.score_hand(hand) }

    let(:game) { BlackJackGame.new }

    context '< 21' do
      let(:hand) do
        Hand.new(
          [
            Card.new(:hearts, 2),
            Card.new(:diamonds, :A),
          ]
        )
      end

      it { is_expected.to eq 13 }
    end

    context '= 21' do
      let(:hand) do
        Hand.new(
          [
            Card.new(:hearts, :Q),
            Card.new(:diamonds, :A),
          ]
        )
      end

      it { is_expected.to eq 21 }
    end

    context '>= 21' do
      let(:hand) do
        Hand.new(
          [
            Card.new(:hearts, 5),
            Card.new(:spades, 5),
            Card.new(:clubs, :A),
            Card.new(:diamonds, :A),
          ]
        )
      end

      it { is_expected.to eq 22 }
    end
  end
end
