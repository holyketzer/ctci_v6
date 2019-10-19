# n - size of array
# Time = O(log n), Mem = O(log n)
def search_in_rotated_array_a(arr, v, l = nil, r = nil)
  l ||= find_edge_index(arr)
  r ||= l + arr.size - 1

  m = (l + r) / 2
  curr = arr[m % arr.size]

  if curr == v
    return m % arr.size
  elsif l == r
    return nil
  elsif curr > v
    r = m - 1
  else
    l = m + 1
  end

  search_in_rotated_array_a(arr, v, l, r)
end

def find_edge_index(arr, l = 0, r = arr.size - 1)
  m = (l + r) / 2

  if arr[m - 1] > arr[m] && m > 0
    return m
  elsif arr[m] > arr[m + 1] && m + 1 < arr.size
    return m + 1
  elsif r - l <= 1
    return 0
  elsif arr[l] > arr[m]
    r = m
  else
    l = m
  end

  find_edge_index(arr, l, r)
end

# Time = O(2 ^ log n), Mem = O(2 ^ log n)
def search_in_rotated_array_b(arr, v, l = 0, r = arr.size - 1)
  i = (r + l) / 2
  move_left = true

  if arr[i] == v
    return i
  elsif l == r
    return nil
  elsif arr[i] < v
    move_left = false
  end

  if move_left
    search_in_rotated_array_b(arr, v, l, i - 1) || search_in_rotated_array_b(arr, v, i + 1, r)
  else
    search_in_rotated_array_b(arr, v, i + 1, r) || search_in_rotated_array_b(arr, v, l, i - 1)
  end
end

RSpec.describe 'search_in_rotated_array' do
  ARR_FOR_ROTATION = [9, 10, 0, 1, 3, 5, 7]

  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("search_in_rotated_array_#{implementation}", arr, v) }


      ARR_FOR_ROTATION.size.times do |offset|
        context "offset #{offset}" do
          let(:arr) { ARR_FOR_ROTATION.rotate(-offset) }

          ARR_FOR_ROTATION.each_with_index do |value, index|
            context "existing value #{value}" do
              let(:v) { value }

              it { is_expected.to eq (index + offset) % arr.size }
            end
          end

          context 'not existing value' do
            let(:v) { 100 }

            it { is_expected.to eq nil }
          end
        end
      end
    end
  end

  describe '#find_edge_index' do
    subject { find_edge_index(arr) }

    ARR_FOR_ROTATION.size.times do |offset|
      context "offset #{offset}" do
        let(:arr) { ARR_FOR_ROTATION.rotate(-offset) }


        it { is_expected.to eq (2 + offset) % arr.size }
      end
    end
  end
end
