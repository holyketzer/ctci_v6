# n - count of nodes, k - depth of tree
# Time=O(n^2) Mem=O(k)
def paths_with_sum_a(tree, sum)
  count_of_paths_bfs(tree.root, sum)
end

def count_of_paths_bfs(node, sum)
  if node == nil
    return 0
  end

  res = 0
  q = [node]

  while !q.empty?
    curr = q.shift
    res += count_of_paths_from(curr, sum)

    if curr.left
      q << curr.left
    end

    if curr.right
      q << curr.right
    end
  end

  res
end

def count_of_paths_from(node, sum, curr = 0)
  if node == nil
    return 0
  end

  res = 0
  curr += node.value

  if curr == sum
    res += 1
  elsif curr > sum
    return 0
  end

  res += count_of_paths_from(node.left, sum, curr) + count_of_paths_from(node.right, sum, curr)
end

# n - count of nodes, k - depth of tree
# Time=O(n) Mem=O(k)
def paths_with_sum_b(tree, sum)
  count_of_paths_for_b(tree.root, sum, 0, Hash.new { |hash, key| hash[key] = 0 })
end

def count_of_paths_for_b(node, target, curr, curr_counter)
  if node == nil
    return 0
  end

  curr += node.value
  res = 0

  if curr == target
    res += 1
  end

  curr_counter[curr] += 1
  diff = curr - target

  if curr_counter.include?(diff)
    res += curr_counter[diff]
  end

  res += count_of_paths_for_b(node.left, target, curr, curr_counter)
  res += count_of_paths_for_b(node.right, target, curr, curr_counter)

  curr_counter[curr] -= 1
  res
end

RSpec.describe 'paths_with_sum' do
  %i(a b).each do |implementation|
    describe "#{implementation} case" do
      subject { send("paths_with_sum_#{implementation}", tree, sum) }

      let!(:tree) { BinaryTree.new(root) }
      let!(:root) { BinaryTree::Node.new(1) }

      # Level 1
      let!(:l) { root.append_left(2) }
      let!(:r) { root.append_right(2) }

      # Level 2
      let!(:l_l) { l.append_left(3) }
      let!(:l_r) { l.append_right(3) }
      let!(:r_l) { r.append_left(3) }
      let!(:r_r) { r.append_right(3) }

      # Level 3
      let!(:l_l_l) { l_l.append_left(1) }
      let!(:l_l_r) { l_l.append_right(0) }
      let!(:l_r_r) { l_r.append_right(1) }
      let!(:r_l_l) { r_l.append_left(1) }
      let!(:r_r_l) { r_r.append_left(3) }
      let!(:r_r_r) { r_r.append_right(4) }

      #            1
      #         /    \
      #        /      \
      #       /        \
      #      2          2
      #     / \        / \
      #    3   3      3   3
      #   / \   \    /   / \
      #  1   0   1  1   3   4

      let(:sum) { 6 }

      it { is_expected.to eq 9 }
    end
  end
end
