# Only when all ants go in same direction there is no collision
# it's possible when they go clockwise or counterclockwise so it's 2 cases
# Total count of cases is 2^n
def collision_probability(n)
  count = 2 ** n

  (count - 2)/count.to_f
end

RSpec.describe 'collision_probability' do
  subject { collision_probability(n) }

  context 'triangle' do
    let(:n) { 3 }

    it { is_expected.to eq 0.75 }
  end

  context 'octagon' do
    let(:n) { 8 }

    it { is_expected.to eq 127/128.0 }
  end
end
