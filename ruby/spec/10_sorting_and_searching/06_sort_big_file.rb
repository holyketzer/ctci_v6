def sort_big_file_a(path, chunk_size: nil)
  chunk_size ||= 512 * (10 ** 6)
  chunk_names = split_to_sorted_chunks(path, chunk_size)

  if (merged_chunk_name = merge_all_sorted_chunks(chunk_names, path))
    sorted_name = "#{path}.sorted"
    File.rename(merged_chunk_name, sorted_name)
    sorted_name
  else
    path
  end
end

def merge_all_sorted_chunks(chunk_names, path)
  step = 0

  while chunk_names.size > 1 do
    merged_chunk_names = (0..(chunk_names.size - 2)).step(2).map do |i|
      file1 = chunk_names[i]
      file2 = chunk_names[i + 1]
      merge_two_sorted_chunks(file1, file2, "#{path}.chunk.#{step}-#{i}")
    end

    if chunk_names.size % 2 > 0
      merged_chunk_names << chunk_names.last
    end

    step += 1
    chunk_names = merged_chunk_names
  end

  chunk_names[0]
end

def split_to_sorted_chunks(path, chunk_size)
  chunk_names = []
  chunk = []
  length = 0

  File.open(path) do |source_file|
    source_file.each_line do |line|
      chunk << line
      length += line.bytesize

      if length >= chunk_size || source_file.eof?
        chunk.sort!
        chunk_names << "#{path}.chunk.#{chunk_names.size}"

        File.open(chunk_names.last, 'w') do |chunk_file|
          chunk.each do |sorted_line|
            chunk_file.write(sorted_line)
          end
        end

        chunk = []
        length = 0
      end
    end
  end

  chunk_names
end

def merge_two_sorted_chunks(path1, path2, res_path)
  File.open(path1) do |f1|
    File.open(path2) do |f2|
      File.open(res_path, 'w') do |res|
        line1 = line2 = nil

        while !f1.eof? || !f2.eof? || line1 || line2 do
          if line1 == nil && !f1.eof?
            line1 = f1.readline
          end

          if line2 == nil && !f2.eof?
            line2 = f2.readline
          end

          if (line1 && line2 && line1 < line2) || (line1 && line2 == nil)
            res.write(line1)
            line1 = nil
          else
            res.write(line2)
            line2 = nil
          end
        end

        res.flush
      end
    end
  end

  File.delete(path1)
  File.delete(path2)
  res_path
end

RSpec.describe 'sort_big_file' do
  %i(a).each do |implementation|
    describe "#{implementation} case" do
      subject { send("sort_big_file_#{implementation}", path, chunk_size: chunk_size) }

      shared_examples 'sorts file' do
        it do
          actual = File.readlines(subject)
          expected = File.readlines(path).sort
          expect(actual.size).to eq expected.size

          actual.zip(expected) do |actual_line, expected_line|
            expect(actual_line).to eq expected_line
          end
        end
      end

      context 'file with content' do
        let(:path) { 'fixtures/big-file.txt' }

        context 'in one chunk' do
          let(:chunk_size) { 10 ** 6 }

          include_examples 'sorts file'
        end

        context 'in several chunks' do
          let(:chunk_size) { 100 }

          include_examples 'sorts file'
        end
      end

      context 'blank file' do
        let(:path) { 'fixtures/empty-file.txt' }

        context 'in one chunk' do
          let(:chunk_size) { 10 ** 6 }

          include_examples 'sorts file'
        end
      end
    end
  end
end
