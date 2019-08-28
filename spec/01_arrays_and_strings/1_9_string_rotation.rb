# s1, s2 - probably rotated string

def is_substring?(s1, s2)
  s1.include?(s2)
end

# time = O(M*N), mem = O(M + N)
def rotation_a?(s1, s2)
  is_substring?(s1 + s1, s2)
end

RSpec.describe 'rotation' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("rotation_#{implementation}?", s1, s2) }

      context 'rotated' do
        let(:s1) { 'erbottlewat' }
        let(:s2) { 'waterbottle' }

        it { is_expected.to eq true }
      end

      context 'not rotated' do
        let(:s1) { 'rebottlewat' }
        let(:s2) { 'waterbottle' }

        it { is_expected.to eq false }
      end
    end
  end
end
