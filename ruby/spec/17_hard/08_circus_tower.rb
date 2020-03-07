module CircusTower
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

  # Time=O(2^n) Mem=O(n)
  def solve_a(people, in_tower = Array.new(people.size) { false }, size = 0, prev_height = 999, prev_weight = 999)
    new_size = size

    people.each_with_index do |person, i|
      if in_tower[i] == false
        if person.height < prev_height && person.weight < prev_weight
          in_tower[i] = true

          res = solve_a(people, in_tower, size + 1, person.height, person.weight)
          if res > new_size
            new_size = res
          end

          in_tower[i] = false
        end
      end
    end

    new_size
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

  # Time=O(n * log n) Mem=O(n)
  def wrong_solution(people)
    sorted = people.sort.reverse

    res = []

    sorted.each do |person|
      if res.size == 0
        res << person
      else
        if res.last.height > person.height && res.last.weight > person.weight
          res << person
        end
      end
    end

    res.size
  end

  RSpec.describe 'CircusTower' do
    include CircusTower

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", people) }

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
              Person.new(1,1),
              Person.new(1,7),
              Person.new(1,9),
              Person.new(2,2),
              Person.new(2,6),
              Person.new(3,3),
              Person.new(3,5),
              Person.new(4,4),
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
  end
end
