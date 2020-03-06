module BabyNames
  def solve(frequencies, synonyms)
    name_groups = compact_synonyms(synonyms)
    name_map = synonym_groups_to_map(name_groups)
    count_names(frequencies, name_map)
  end

  def compact_synonyms(synonyms)
    groups = {}
    counter = 0

    synonyms.each do |name1, name2|
      matched_groups = groups.select { |_, g| g.include?(name1) || g.include?(name2) }

      group =
        if matched_groups.any?
          matched_groups.map(&:first).each do |key|
            groups.delete(key)
          end

          matched_groups.map(&:last).reduce { |l, r| l.merge(r) }
        else
          SortedSet.new
        end

      groups[counter += 1] = group
      group << name1 << name2
    end

    groups.values
  end

  def synonym_groups_to_map(name_groups)
    res = {}

    name_groups.each do |group|
      main_name = group.first
      group.delete(main_name)

      group.each do |name|
        res[name] = main_name
      end
    end

    res
  end

  def count_names(frequencies, name_map)
    res = Hash.new { |hash, key| hash[key] = 0 }

    frequencies.each do |name, value|
      name = name_map[name] || name
      res[name] += value
    end

    res
  end

  RSpec.describe 'BabyNames' do
    include BabyNames

    subject { solve(frequencies, synonyms) }

    context 'book example' do
      let(:frequencies) { { 'John' => 15, 'Jon' => 12,  'Chris' => 13, 'Kris' => 4, 'Christopher' => 19 } }
      let(:synonyms) { [['Jon', 'John'], ['John', 'Johnny'], ['Chris', 'Kris'], ['Chris', 'Christopher']] }

      it { is_expected.to eq('John' => 27, 'Chris' => 36) }
    end

    context 'complex example' do
      let(:frequencies) { { 'a' => 1, 'b' => 1, 'c' => 1, 'd' => 1, 'x' => 1, 'y' => 1, 'z' => 1 } }
      let(:synonyms) { [['a', 'b'], ['b', 'c'], ['x', 'y'], ['y', 'z'], ['c', 'x']] }

      it { is_expected.to eq('a' => 6, 'd' => 1) }
    end
  end
end
