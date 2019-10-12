class BValue
  def initialize(value)
    @value = value
  end

  def value
    case @value
    when '1' then true
    when '0' then false
    else raise ArgumentError, "unexpexted value #{@value}"
    end
  end

  def to_s
    @value
  end

  def solvable?
    true
  end
end

class BExpr < BValue
  attr_accessor :op, :left, :right

  def initialize(op:, left:, right:)
    @op = op
    @left = left
    @right = right
  end

  def value
    l = left.value
    r = right.value

    case op
    when '|' then l | r
    when '&' then l & r
    when '^' then l ^ r
    else raise ArgumentError, "unexpexted operation #{op}"
    end
  end

  def to_s
    "(#{left.to_s} #{op.to_s} #{right.to_s})"
  end
end

def parse_expr(str)
  str.each_char.reject { |c| c =~ /\s/ }.map { |c| c =~ /\d/ ? BValue.new(c) : c }
end

def count_eval(expr, target, src_size = expr.size)
  res = 0

  each_combination(parse_expr(expr)) do |expr|
    if expr.value == target
      res += 1
    end
  end

  res
end

def each_combination(arr, &block)
  if arr.size == 1
    block.call(arr[0])
  else
    (1..(arr.size - 2)).step(2) do |i|
      left = arr[0..(i - 1)]
      op = arr[i]
      right = arr[(i + 1)..(arr.size - 1)]

      each_combination(left) do |l|
        each_combination(right) do |r|
          block.call(BExpr.new(left: l, op: op, right: r))
        end
      end
    end
  end
end

RSpec.describe 'count_eval' do
  subject { count_eval(expr, target) }

  context 'case 1' do
    let(:expr) { '1^0|0|1' }
    let(:target) { false }

    it { is_expected.to eq 2 }
  end

  context 'case 2' do
    let(:expr) { '0 & 0 & 0 & 1 ^ 1 | 0' }
    let(:target) { true }

    it { is_expected.to eq 10 }
  end
end
