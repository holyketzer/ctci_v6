class Box
  attr_reader :w, :d, :h

  def initialize(w:, d:, h:)
    @w = w
    @d = d
    @h = h
  end

  def sizes
    [w, d, h]
  end

  def can_be_on?(top)
    w < top.w && d < top.d && h < top.h
  end
end

def tallest_stack(boxes, available = boxes.map { true }, stack = [])
  too_big = []
  top = stack.last

  boxes.each_with_index do |box, i|
    if top && available[i] && !box.can_be_on?(top)
      too_big << i
      available[i] = false
    end
  end

  res =
    if available.none?
      stack.sum(&:h)
    else
      boxes.each_with_index.map do |box, i|
        if available[i]
          stack << box
          available[i] = false
          height = tallest_stack(boxes, available, stack)
          available[i] = true
          stack.pop
          height
        else
          0
        end
      end.max
    end

  too_big.each { |i| available[i] = true }
  res
end

RSpec.describe 'tallest_stack' do
  subject { tallest_stack(boxes) }

  let(:boxes) do
    [
      Box.new(w: 1.0, d: 1.0, h: 1.0),
      Box.new(w: 1.0, d: 1.0, h: 1.0),
      Box.new(w: 1.0, d: 1.0, h: 1.9),
      Box.new(w: 1.5, d: 1.5, h: 1.5),
      Box.new(w: 2.0, d: 2.0, h: 2.0),
    ]
  end

  it { is_expected.to eq 2.0 + 1.5 + 1.0 }
end
