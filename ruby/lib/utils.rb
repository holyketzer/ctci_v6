require 'pathname'

# TODO: should be time = O(n*log(n)), mem = O(1)
def sort!(str)
  str.chars.sort!.join
end

def swap(arr, i, j)
  arr[i], arr[j] = arr[j], arr[i]
end

# Heap's permutation algorithm
def heaps_permute(arr)
  Enumerator.new do |enum|
    heaps_permute_iternal(arr.size, arr, enum)
  end
end

def heaps_permute_iternal(k, arr, enumerator)
  if k == 1
    enumerator.yield(arr.dup)
  else
    # Generate permutations with kth unaltered
    # Initially k == length(A)
    heaps_permute_iternal(k - 1, arr, enumerator)

    # Generate permutations for kth swapped with each k-1 initial
    (k - 1).times do |i|
      # Swap choice dependent on parity of k (even or odd)
      if k % 2 == 0
        swap(arr, i, k - 1) # zero-indexed, the kth is at k - 1
        # puts "i swap #{arr} i=#{i} k=#{k}"
      else
        swap(arr, 0, k - 1)
        # puts "0 swap #{arr} i=#{i} k=#{k}"
      end

      heaps_permute_iternal(k - 1, arr, enumerator)
    end
  end
end

def my_permute(arr)
  if arr.size < 2
    [arr]
  else
    res = []

    arr.each_with_index do |v, i|
      rest = arr[0, i] + arr[i + 1, arr.size - i]

      my_permute(rest).each do |sub_permut|
        res << (sub_permut << v)
      end
    end

    res
  end
end

def only_this_file_run?(file)
  if run_path = ARGV[0]
    if !Pathname.new(run_path).absolute?
      run_path = File.join(Dir.pwd, run_path)
    end

    run_path.include?(file)
  end
end
