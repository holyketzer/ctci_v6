class RankTree
  class RankNode
    attr_reader :value, :left_count, :left, :right

    def initialize(value)
      @value = value
      @left_count = 0
    end

    def add(v)
      if v <= value
        if left
          left.add(v)
        else
          @left = RankNode.new(v)
        end

        @left_count += 1
      else
        if right
          right.add(v)
        else
          @right = RankNode.new(v)
        end
      end
    end

    def get_rank(v)
      if v == value
        left_count
      elsif v <= value
        if (res = left&.get_rank(v))
          res
        end
      else
        if (res = right&.get_rank(v))
          res + left_count + 1
        end
      end
    end

    def to_s
      "(#{left.to_s} #{value}[#{left_count}] #{right.to_s})"
    end
  end

  attr_reader :root

  def track(n)
    if root
      root.add(n)
    else
      @root = RankNode.new(n)
    end
  end

  def get_rank_of_number(n)
    root&.get_rank(n)
  end

  def to_s
    root ? root.to_s : '()'
  end
end

RSpec.describe 'RankTree' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      let(:rank_tree) { RankTree.new }
      let(:stream) { [5, 1, 4, 4, 5, 9, 7, 13, 3] }

      before { stream.each { |n| rank_tree.track(n) } }

      it do
        expect(rank_tree.get_rank_of_number(1)).to eq 0
        expect(rank_tree.get_rank_of_number(3)).to eq 1
        expect(rank_tree.get_rank_of_number(4)).to eq 3
        expect(rank_tree.get_rank_of_number(5)).to eq 5
        expect(rank_tree.get_rank_of_number(7)).to eq 6
        expect(rank_tree.get_rank_of_number(9)).to eq 7
        expect(rank_tree.get_rank_of_number(13)).to eq 8
        expect(rank_tree.get_rank_of_number(0)).to eq nil
        expect(rank_tree.get_rank_of_number(2)).to eq nil
        expect(rank_tree.get_rank_of_number(10)).to eq nil
      end
    end
  end
end
