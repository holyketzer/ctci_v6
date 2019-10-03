class CircularArray
  include Enumerable

  def initialize(arr = [])
    @arr = arr
  end

  def push(x)
    @arr << x
  end

  def pop
    @arr.pop
  end

  def size
    @arr.size
  end

  def insert(i, x)
    i = i % @arr.size
    @arr.insert(i, x)
  end

  def each(&block)
    loop do
      @arr.each(&block)
    end
  end
end

RSpec.describe 'CircularArray' do
  let(:arr) { CircularArray.new([1, 2, 3, 4, 5]) }

  it do
    arr.push(6)
    expect(arr.size).to eq 6
    expect(arr.pop).to eq 6

    arr.each_with_index do |item, i|
      case i
      when 0, 5 then expect(item).to eq 1
      when 1, 6 then expect(item).to eq 2
      when 2, 7 then expect(item).to eq 3
      when 3, 8 then expect(item).to eq 4
      when 4, 9 then expect(item).to eq 5
      when 10 then break
      end
    end
  end
end
