# n - target str length (after replacing ' ' with '%20')

# B: time = O(n), mem = O(1)
def urlify_b(str, src_n)
  # Left pointer to iterate
  p1 = src_n - 1

  target_n = src_n

  src_n.times do |i|
    if str[i] == ' '
      target_n += 2
    end
  end

  # Right pointer to iterate
  p2 = target_n - 1

  while p2 >= 0 do
    if str[p1] == ' '
      str[p2 - 2] = '%'
      str[p2 - 1] = '2'
      str[p2 - 0] = '0'

      p1 -= 1
      p2 -= 3
    else
      str[p2] = str[p1]
      p1 -= 1
      p2 -= 1
    end
  end

  str
end

RSpec.describe 'urlify' do
  [:b].each do |implementation|
    describe "#{implementation} case" do
      subject { send("urlify_#{implementation}", str, n) }

      context 'urlify' do
        let(:str) { 'Mr John Smith    ' }
        let(:n) { 13 }

        it { is_expected.to eq 'Mr%20John%20Smith' }
      end
    end
  end
end
