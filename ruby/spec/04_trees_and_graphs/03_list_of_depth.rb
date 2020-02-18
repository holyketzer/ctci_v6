require_relative '02_minimal_tree'

# n - size of array
# Time = O(n) Mem = O(n)
def lists_of_depth_a(tree)
  res = []
  q = [tree.root, 0]

  while !q.empty? do
    curr = q.shift
    level = q.shift

    res[level] ||= LinkedList.new
    res[level].push(curr)

    if curr.left
      q << curr.left
      q << level + 1
    end

    if curr.right
      q << curr.right
      q << level + 1
    end
  end

  res
end

RSpec.describe 'lists_of_depth' do
  include MinimalTree

  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("lists_of_depth_#{implementation}", tree).map(&:to_array).map { |arr| arr.map(&:value) } }

      context 'perfect tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7]) }

        it do
          expect(subject[0]).to eq [4]
          expect(subject[1]).to eq [2, 6]
          expect(subject[2]).to eq [1, 3, 5, 7]
        end
      end

      context 'not perfect tree' do
        let(:tree) { array_to_bst_a([1, 2, 3, 4, 5, 6, 7, 8]) }

        it do
          expect(subject[0]).to eq [5]
          expect(subject[1]).to eq [3, 7]
          expect(subject[2]).to eq [2, 4, 6, 8]
          expect(subject[3]).to eq [1]
        end
      end
    end
  end
end
