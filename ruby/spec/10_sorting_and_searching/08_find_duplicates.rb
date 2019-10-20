def find_duplicates_a(arr, max: 32_000)
  int_byte_size = 0.size
  total_flag_bytes = (max / 8.0).ceil
  bucket_size = int_byte_size * 8
  buckets_count = (total_flag_bytes / int_byte_size.to_f).ceil

  counter = Array.new(buckets_count, 0)
  res = []

  arr.each do |v|
    bit = 1 << (v % bucket_size)
    offset =  v / bucket_size
    if counter[offset] & bit > 0
      res << v
    else
      counter[offset] |= bit
    end
  end

  res
end

RSpec.describe 'find_duplicates' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("find_duplicates_#{implementation}", arr).sort }

      let(:arr) { [13, 1, 2, 4, 6, 7, 8, 5, 12, 4, 3, 2, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] }

      it { is_expected.to eq [1, 2, 2, 3, 4, 4, 5, 6, 7, 8] }
    end
  end
end
