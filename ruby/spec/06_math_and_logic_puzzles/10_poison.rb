class SodaBottle
  def initialize(poisoned)
    @poisoned = poisoned
  end

  def drop_to(test_strip)
    test_strip.drop_from(self, @poisoned)
  end
end

class TestStrip
  attr_reader :positive, :bottles

  def initialize
    @positive = false
    @bottles = []
  end

  def drop_from(bottle, poisoned)
    @positive ||= poisoned
    @bottles << bottle
  end

  def reset_bottles
    @bottles = []
  end
end

def find_poisoned_bottle_a(bottles, test_strips, steps = 1)
  if bottles.size <= test_strips.size + 1
    test_strips.each_with_index do |test_strip, i|
      test_strip.reset_bottles
      bottles[i].drop_to(test_strip)
    end

    bottle = test_strips.find { |s| s.positive == true }&.bottles&.first
    bottle ||= bottles.last # Bottle without test strip

    {
      bottle: bottle,
      steps: steps
    }
  else
    larger_part_size = bottles.size / test_strips.size
    smaller_part_size = ((bottles.size - larger_part_size) / test_strips.size.to_f).round
    larger_part_size = bottles.size - (smaller_part_size * test_strips.size)

    offset = 0

    test_strips.each do |test_strip|
      test_strip.reset_bottles

      smaller_part_size.times do |i|
        bottles[i + offset].drop_to(test_strip)
      end

      offset += smaller_part_size
    end

    if (test_strip = test_strips.find { |s| s.positive == true })
      find_poisoned_bottle_a(test_strip.bottles, test_strips.select { |s| s.positive == false }, steps + 1)
    else
      # Bottles without test strip
      find_poisoned_bottle_a(bottles[offset, larger_part_size], test_strips, steps + 1)
    end
  end
end

RSpec.describe 'find_poisoned_bottle' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("find_poisoned_bottle_#{implementation}", bottles, test_strips) }

      let(:bottles) { 1000.times.map { |i| SodaBottle.new(i == poisoned) } }
      let(:test_strips) { 10.times.map { TestStrip.new } }

      context '990' do
        let(:poisoned) { 990 }

        it do
          expect(subject[:bottle]).to eq bottles[poisoned]
          expect(subject[:steps]).to eq 3
        end
      end

      context '797 with more bottles that stipes at the last step' do
        let(:poisoned) { 797 }

        it do
          expect(subject[:bottle]).to eq bottles[poisoned]
          expect(subject[:steps]).to eq 3
        end
      end

      context '0' do
        let(:poisoned) { 0 }

        it do
          expect(subject[:bottle]).to eq bottles[poisoned]
          expect(subject[:steps]).to eq 3
        end
      end

      context '717' do
        let(:poisoned) { 717 }

        it do
          expect(subject[:bottle]).to eq bottles[poisoned]
          expect(subject[:steps]).to eq 3
        end
      end
    end
  end
end
