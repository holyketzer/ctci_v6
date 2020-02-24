module Shuffle
  def shuffle(cards)
    cards.size.times do |i|
      j = rand(cards.size - i)

      # Swap chosen and last non-shuffled card
      card = cards[j]
      cards[j] = cards[cards.size - i - 1]
      cards[cards.size - i - 1] = card
    end

    cards
  end

  RSpec.describe 'Shuffle' do
    include Shuffle

    subject { shuffle(cards.dup) }

    let(:cards) do
      %w(♣ ♦ ♥ ♠).flat_map do |suit|
        %w(2 3 4 5 6 7 8 9 10 J Q K A).map do |rank|
          rank + suit
        end
      end
    end

    it do
      expect(cards.size).to eq 52
      expect(subject).to be_an Array
      expect(subject.size).to eq 52

      cards.each do |card|
        expect(subject).to include(card)
      end
    end
  end
end
