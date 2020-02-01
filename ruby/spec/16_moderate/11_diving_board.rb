# Time = O(k), Mem = O(k)
def all_lengths(ss, ls, k)
  l = k * ls
  res = [l]

  if ss == ls
    return res
  end

  k.times do
    l = l - ls + ss
    res << l
  end

  res
end

RSpec.describe 'max_living_people_year' do
  subject { all_lengths(ss, ls, k) }

  let(:ls) { 2 }
  let(:ss) { 1 }

  context 'k = 1' do
    let(:k) { 1 }

    it { is_expected.to eq [2, 1] }
  end

  context 'k = 2' do
    let(:k) { 2 }

    it { is_expected.to eq [4, 3, 2] }
  end

  context 'k = 3' do
    let(:k) { 3 }

    it { is_expected.to eq [6, 5, 4, 3] }
  end
end
