module CircusTowerSo
  class Person
    include Comparable

    attr_reader :height, :weight

    def initialize(height, weight)
      @height = height
      @weight = weight
    end

    def <=>(other)
      res = height <=> other.height

      if res == 0
        weight <=> other.weight
      else
        res
      end
    end

    def smaller?(other)
      height < other.height && weight < other.weight
    end

    def to_s
      "(#{height}, #{weight})"
    end

    def inspect
      to_s
    end
  end

  # Time=O(n * n) Mem=O(n * n)
  def solve_b(people)
    sorted = people.sort

    find_lis_by_weight(sorted).size
  end

  def find_lis_by_weight(people)
    longest_by_index_cache = people.each_with_index.map { |person, i| [i, [person]] }.to_h
    longest = []

    people.each_with_index do |person, index|
      res = longest_for_index(longest_by_index_cache, index, person)

      if res.size > longest.size
        longest = res
      end

      longest_by_index_cache[index] = res
    end

    longest
  end

  def longest_for_index(longest_by_index_cache, index, person)
    longest_prev_seq = []

    index.times do |i|
      prev_seq = longest_by_index_cache[i]

      if prev_seq.last.smaller?(person) && prev_seq.size > longest_prev_seq.size
        longest_prev_seq = prev_seq
      end
    end

    longest_prev_seq + [person]
  end


  RSpec.describe 'CircusTower' do
    include CircusTower

    subject { solve_b(people) }

    context 'book example' do
      let(:people) do
        [
          Person.new(65, 100),
          Person.new(70, 150),
          Person.new(56, 90),
          Person.new(75, 190),
          Person.new(60, 95),
          Person.new(68, 110),
        ]
      end

      it { is_expected.to eq 6 }
    end

    context 'tricky example' do
      let(:people) do
        [
          Person.new(1, 1),
          Person.new(1, 7),
          Person.new(1, 9),
          Person.new(2, 2),
          Person.new(2, 6),
          Person.new(3, 3),
          Person.new(3, 5),
          Person.new(4, 4),
        ]
      end

      it { is_expected.to eq 4 }
    end

    context 'more tricky example' do
      let(:people) do
        [
          Person.new(1, 1),
          Person.new(2, 2),
          Person.new(3, 3),
          Person.new(4, 1),
        ]
      end

      it { is_expected.to eq 3 }
    end
  end
end
