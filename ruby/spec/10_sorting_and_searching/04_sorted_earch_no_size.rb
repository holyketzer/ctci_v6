class Listy
  def initialize(arr)
    @arr = arr
  end

  def element_at(i)
    if i > @arr.size - 1
      return -1
    else
      @arr[i]
    end
  end
end

# n - size of list
# Time=O(log n) Mem=O(log n), initial r value should be average list size
def no_size_search_a(list, v, l = 0, r = 16, step = r, edge_found = false)
  if list.element_at(r) != -1 && !edge_found
    r += step
    step *= 2
  elsif list.element_at(r) == -1
    edge_found = true
  end

  i = (r + l) / 2
  curr = list.element_at(i)

  if curr == v
    return i
  elsif l == r
    return nil
  elsif curr == -1 || curr > v
    r = i - 1
  else
    l = i + 1
  end

  no_size_search_a(list, v, l, r, step, edge_found)
end

RSpec.describe 'no_size_search' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("no_size_search_#{implementation}", list, v) }

      ARR_FOR_WO_SIZE_SEARCH = [1, 3, 5, 6, 8, 9, 10, 15]

      let(:list) { Listy.new(ARR_FOR_WO_SIZE_SEARCH) }

      ARR_FOR_WO_SIZE_SEARCH.each_with_index do |value, index|
        context "existing #{value}" do
          let(:v) { value }

          it { is_expected.to eq index }
        end
      end

      context 'not existing' do
        let(:v) { 100 }

        it { is_expected.to eq nil }
      end
    end
  end
end
