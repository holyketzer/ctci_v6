module MultiSearch
  class SubstringSearcher
    def initialize(str)
      @str = str
      @index = Hash.new { |hash, key| hash[key] = [] }

      str.each_char.each_with_index do |c, i|
        @index[c] << i
      end
    end

    # n - str length, s - average substring length, a - alphabet size (const)
    # Time=O(n/a * (1/a) ^ s)=O(n) Mem=O(n)
    def substring_offsets(sub)
      offsets = @index[sub[0]]
      i = 0

      while offsets.size > 0 && i < sub.size do
        offsets = offsets.select { |j| j < @str.size && @str[j] == sub[i] }.map!(&:succ)
        i += 1
        p offsets
      end

      i == sub.size ? offsets.map! { |j| j - sub.size } : []
    end

    # t - subs count, n - str length
    # Time=O(n * t) Mem=O(n + t)
    def substrings_offsets(subs)
      subs.each_with_object({}) { |sub, res| res[sub] = substring_offsets(sub) }
    end
  end

  RSpec.describe 'MultiSearch' do
    include MultiSearch

    let(:searcher) { SubstringSearcher.new(str) }
    let(:str) { 'immunoelectrophoretically' }

    let(:subs) do
      {
        'uno' => [3],
        'electro' => [6],
        'etically' => [17],
        'mun' => [2],
        'i' => [0, 19],
        'tropho' => [10],
        'x' => [],
        'callyie' => [],
        'electronic' => [],
      }
    end

    it do
      expect(searcher.substrings_offsets(subs.keys)).to eq subs
    end
  end
end
