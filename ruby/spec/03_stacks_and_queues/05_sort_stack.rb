# n - size of stack
# time = O(n^2) mem = O(n)
def sort_stack_a(s)
  res = Stack.new

  from = s
  to = Stack.new

  while !from.empty? do
    max = from.peek

    while !from.empty? do
      if (value = from.pop) > max
        max = value
      end

      to.push(value)
    end

    while !to.empty? do
      value = to.pop

      if value == max
        res.push(value)
      else
        from.push(value)
      end
    end
  end

  res
end

# time = O(n*log(n)) mem = O(n)
def sort_stack_b(s)
  if s.empty?
    s
  else
    min = max = s.peek
    tmp = Stack.new

    while (value = s.pop) do
      if value < min
        min = value
      end

      if value > max
        max = value
      end

      tmp.push(value)
    end

    median_sort(tmp, min, max)
  end
end

def median_sort(s, min, max)
  value = s.pop

  if s.empty?
    s.push(value)
  else
    middle = (max + min) / 2
    low, high = *split_stack(s.push(value), middle)
    merge_sorted(median_sort(low, min, middle), median_sort(high, middle + 1, max))
  end
end

def split_stack(s, middle)
  low = Stack.new
  high = Stack.new

  while (value = s.pop) do
    if value <= middle
      low.push(value)
    else
      high.push(value)
    end
  end

  [low, high]
end

def merge_sorted(low, high)
  reversed = Stack.new

  while (value = low.pop) do
    reversed.push(value)
  end

  while (value = high.pop) do
    reversed.push(value)
  end

  res = Stack.new

  while (value = reversed.pop) do
    res.push(value)
  end

  res
end

RSpec.describe 'sort_stack' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("sort_stack_#{implementation}", stack).to_a }

      let(:stack) { Stack.new([7, 3, 5, 0, 4, 1, 6, 2]) }

      it { is_expected.to eq [7, 6, 5, 4, 3, 2, 1, 0] }
    end
  end
end
