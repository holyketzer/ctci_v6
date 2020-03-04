module LettersAndNumbers
  NUMBERS = Set.new(%w(1 2 3 4 5 6 7 8 9 0)).freeze

  # Time=O(n^2) Mem=O(1)
  def solve_a(arr)
    n = arr.size
    res = 0

    n.times do |i|
      ((i + 1)..(n - 1)).each do |j|
        numbers = 0
        letters = 0

        (i..j).each do |pos|
          if NUMBERS.include?(arr[pos])
            numbers += 1
          else
            letters += 1
          end
        end

        if numbers == letters && numbers > res
          res = numbers
        end
      end
    end

    res * 2
  end

  # Time=O(n) Mem=O(n)
  def solve_b(arr)
    letters = 0
    numbers = 0
    ldiff = { 0 => -1 }
    res = 0

    arr.each_with_index do |c, i|
      if NUMBERS.include?(c)
        numbers += 1
      else
        letters += 1
      end

      diff = letters - numbers
      ldiff[diff] ||= i # do not overwrite left index

      delta = i - ldiff[diff]

      if delta > res
        res = delta
      end
    end

    res
  end

  RSpec.describe 'LettersAndNumbers' do
    include LettersAndNumbers

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("solve_#{implementation}", arr) }

        context 'simple sequential' do
          let(:arr) { %w(1 1 a a a a) }

          it { is_expected.to eq 4 }
        end

        context 'complex sequential' do
          let(:arr) { %w(1 a a a a 1) }

          it { is_expected.to eq 2 }
        end

        context 'complex case' do
          let(:arr) { %w(a 1 1 a 1 1 a 1 a 1 1 1 1 a 1) }

          it { is_expected.to eq 6 }
        end
      end
    end

    describe 'compare fast solution with reference 100% correct implementation' do
      it do
        100.times do
          numbers_count = rand(10) + 5
          letters_count = rand(10) + 5

          arr = (['1'] * numbers_count + ['a'] * letters_count).shuffle

          a_res = solve_a(arr)
          b_res = solve_b(arr)
          expect(b_res).to eq(a_res), "for #{arr} should be #{a_res} not #{b_res}"
        end
      end
    end
  end
end
