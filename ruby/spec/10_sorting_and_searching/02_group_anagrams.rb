# n - arr size
# Time = O(n) Mem = O(n)
def group_anagrams_a(arr)
  res = Hash.new { |hash, key| hash[key] = [] }
  arr.reduce(res) { |res, s| res[signature(s)] << s; res }.values.reduce(&:+)
end

def signature(s)
  res = Hash.new { |hash, key| hash[key] = 0 }
  s.each_char.reduce(res) { |res, c| res[c] += 1; res }
  res.keys.sort.map { |c| "#{c}#{res[c]}" }.join
end

RSpec.describe 'group_anagrams' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("group_anagrams_#{implementation}", arr) }

      let(:arr) do
        [
          'yyxxx',
          'abb',
          'cad',
          'bab',
          'acd',
          'xyxyx',
        ]
      end

      it do
        is_expected.to eq ['yyxxx', 'xyxyx', 'abb', 'bab', 'cad', 'acd']
      end
    end
  end
end
