module RabinKarpSubstringSearch
  BASE = 128

  # Time=O(n + m) Mem=O(1) where n - size of str, m - size of substr
  def solve(str, sub_str)
    if sub_str.size > str.size
      return false
    end

    sub_str_hash = calc_hash(sub_str)
    curr_hash = calc_hash(str, 0, sub_str.size - 1)

    (0..(str.size - sub_str.size)).each do |offset|
      if curr_hash == sub_str_hash && is_substring?(str, sub_str, offset)
        return true
      elsif offset + sub_str.size < str.size
        curr_hash -= str[offset].ord * (BASE ** (sub_str.size - 1))
        curr_hash *= BASE
        curr_hash += str[offset + sub_str.size].ord
      end
    end

    return false
  end


  def calc_hash(str, from = 0, to = str.size - 1)
    (from..to).each.sum do |i|
      str[to - i].ord * (BASE ** i)
    end
  end

  def is_substring?(str, sub_str, offset)
    sub_str.size.times do |i|
      if sub_str[i] != str[offset + i]
        return false
      end
    end

    return true
  end

  RSpec.describe 'RabinKarpSubstringSearch' do
    include RabinKarpSubstringSearch

    subject { solve(str, sub_str) }

    let(:str) { 'A binary heap is a heap data structure that takes the form of a binary tree' }

    context 'substring from beginning' do
      let(:sub_str) { 'A binary heap' }

      it { is_expected.to eq true }
    end

    context 'substring from end' do
      let(:sub_str) { 'binary tree' }

      it { is_expected.to eq true }
    end

    context 'substring from middle' do
      let(:sub_str) { 'data structure' }

      it { is_expected.to eq true }
    end

    context 'not a substring' do
      let(:sub_str) { 'data tree' }

      it { is_expected.to eq false }
    end
  end
end
