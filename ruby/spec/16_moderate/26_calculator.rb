module Calculator
  class Number
    attr_reader :value

    def initialize(value)
      @value = value.to_f
    end

    def reduce
      self
    end

    def to_s
      value.to_s
    end
  end

  class Operator
    attr_reader :value

    def initialize(value)
      @value = value.to_sym
    end

    def priority
      if value == :* or value == :/
        1
      else
        0
      end
    end

    def reduce(operand1, operand2)
      if value == :*
        Number.new(operand1.value * operand2.value)
      elsif value == :/
        Number.new(operand1.value / operand2.value)
      elsif value == :+
        Number.new(operand1.value + operand2.value)
      elsif value == :-
        Number.new(operand1.value - operand2.value)
      else
        raise ArgumentError, "unknown operator #{value}"
      end
    end

    def to_s
      value.to_s
    end
  end

  class Expression
    attr_reader :operand1, :operator, :operand2

    def initialize(operand1, operator, operand2)
      @operand1 = operand1
      @operand2 = operand2
      @operator = operator
    end

    class << self
      def from_list_of_terms(terms)
        if terms.size == 1
          Expression.new(terms[0], nil, nil)
        elsif terms.size == 3
          Expression.new(*terms)
        elsif terms.size > 3
          if terms[1].priority >= terms[3].priority
            Expression.from_list_of_terms(
              [
                Expression.new(
                  terms[0],
                  terms[1],
                  terms[2],
                )
              ] + terms[3..]
            )
          else
            Expression.new(
              terms[0],
              terms[1],
              Expression.from_list_of_terms(terms[2..])
            )
          end
        else
          raise ArgumentError, "invalid expression"
        end
      end
    end

    def reduce
      if operator
        operator.reduce(operand1.reduce, operand2.reduce)
      else
        operand1
      end
    end

    def to_s
      if operator
        "(#{operand1} #{operator} #{operand2})"
      else
        operand1.to_s
      end
    end
  end

  DIGITS = %w(1 2 3 4 5 6 7 8 9 0).freeze
  OPS = %w(* / + -).freeze

  def parse_terms(str)
    buf = ''
    res = []

    str.each_char do |c|
      if DIGITS.include?(c)
        buf << c
      elsif OPS.include?(c)
        if buf.size > 0
          res << Number.new(buf.to_i) << Operator.new(c)
          buf = ''
        else
          raise ArgumentError, "invalid expression"
        end
      else
        raise ArgumentError, "unknown char #{c}"
      end
    end

    # Mistake 1: forgot to convert rest of buffer to number
    if buf.size > 0
      res << Number.new(buf.to_i)
    else
      raise ArgumentError, "invalid expression"
    end

    res
  end

  # Time=O(n) Mem=O(n)
  def calculate_a(str)
    terms = parse_terms(str)
    Expression.from_list_of_terms(terms).reduce.value
  end

  # Time=O(n) Mem=O(n)
  def calculate_b(str)
    terms = parse_terms(str)

    num_stack = []
    op_stack = []

    terms.each do |term|
      if term.is_a?(Number)
        num_stack << term
      else
        if op_stack.empty?
          op_stack << term
        else
          if term.priority <= op_stack.last.priority
            do_op(op_stack, num_stack)
          end

          op_stack << term
        end
      end
    end

    while op_stack.size > 0 do
      do_op(op_stack, num_stack)
    end

    num_stack.first.value
  end

  def do_op(op_stack, num_stack)
    b, a = num_stack.pop, num_stack.pop
    num_stack << op_stack.pop.reduce(a, b)
  end

  RSpec.describe 'Calculator' do
    include Calculator

    %i(a b).each do |implementation|
      context "implementation #{implementation}" do
        subject { send("calculate_#{implementation}", str) }

        context 'book sample' do
          let(:str) { '2*3+5/6*3+15' }

          it { is_expected.to eq 23.5 }
        end

        context 'another sample' do
          let(:str) { '22*33+55/100*30+15' }

          it { is_expected.to eq 757.5 }
        end

        context 'invalid operation' do
          let(:str) { '2**3' }

          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'invalid expression' do
          let(:str) { '2*3+' }

          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'blank string' do
          let(:str) { '' }

          it { expect { subject }.to raise_error(ArgumentError) }
        end
      end
    end
  end
end
