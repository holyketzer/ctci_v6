# time = O(n), mem = O(n)
def palindrome_a?(head)
  half = head
  fast = head
  slow = head
  count = 1

  while fast.next_node do
    fast = fast.next_node
    count += 1

    if fast.next_node
      fast = fast.next_node
      count += 1

      slow = slow.next_node
      half = LLNode.new(slow.value, half)
    end
  end

  rest = count.even? ? slow.next_node : slow

  while rest do
    if rest.value != half.value
      return false
    end

    rest = rest.next_node
    half = half.next_node
  end

  true
end

RSpec.describe 'palindrome' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("palindrome_#{implementation}?", list) }

      let(:list) { ll(str.chars) }

      context 'palindrome even' do
        let(:str) { 'robottobor' }

        it { is_expected.to eq true }
      end

      context 'palindrome odd' do
        let(:str) { 'robotobor' }

        it { is_expected.to eq true }
      end

      context 'not palindrome even' do
        let(:str) { '123456' }

        it { is_expected.to eq false }
      end

      context 'not palindrome odd' do
        let(:str) { '1234567' }

        it { is_expected.to eq false }
      end
    end
  end
end
