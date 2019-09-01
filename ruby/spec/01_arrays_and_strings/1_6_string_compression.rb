# n - str length

# A: time = O(n), mem = O(n)
def compress_a(str)
  res = ''

  prev = str[0]
  i = 1
  count = 1

  while i < str.size do
    if prev == str[i]
      count += 1
    else
      res << prev
      res << count.to_s
      prev = str[i]
      count = 1
    end

    i += 1
  end

  res << prev
  res << count.to_s

  if res.size < str.size
    res
  else
    str
  end
end

RSpec.describe 'compress' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("compress_#{implementation}", str) }

      context 'compressable' do
        let(:str) { 'aabcccccaaa' }

        it { is_expected.to eq 'a2b1c5a3' }
      end

      context 'still compressable' do
        let(:str) { 'abcdeffffffff' }

        it { is_expected.to eq 'a1b1c1d1e1f8' }
      end

      context 'not compressable' do
        let(:str) { 'abacccccaa' }

        it { is_expected.to eq 'abacccccaa' }
      end
    end
  end
end
