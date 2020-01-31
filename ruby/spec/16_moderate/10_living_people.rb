class Person
  attr_reader :birth, :death

  def initialize(birth, death)
    @birth = birth
    @death = death
  end

  # 1900-1980
  def live_in?(year)
    year >= @birth && year <= @death
  end

  def to_range
    @birth..@death
  end
end

# Time=O(n * (Time.current.year - 1900)) Mem=O(1)
def max_living_people_year_a(people)
  max_count = 0
  max_year = nil

  from = people.min_by(&:birth).birth
  to = people.max_by(&:birth).birth

  (from..to).each do |year|
    count = people.reduce(0) { |res, person| person.live_in?(year) ? res + 1 : res }

    if count > max_count
      max_count = count # 1st mistake: forgot to update max_count
      max_year = year
    end
  end

  max_year
end

# Time=O(2 * (n + n * log n)) Mem=O(2 * n)
def max_living_people_year_b(people)
  births = people.map(&:birth).sort!
  deaths = people.map(&:death).sort!

  max_count = 0
  max_year = nil

  count = 0
  bi = 0
  di = 0

  while bi < births.size && di < deaths.size do
    if births[bi] <= deaths[di]
      count += 1

      if count > max_count
        max_count = count # 2nd mistake: forgot to update max_count
        max_year = births[bi]
      end

      bi += 1
    else
      count -= 1
      di += 1
    end
  end

  max_year
end

RSpec.describe 'max_living_people_year' do
  %i(a b).each do |implementation|
    describe implementation do
      subject { send("max_living_people_year_#{implementation}", people) }

      let(:people) do
        [
          Person.new(1900, 1959),
          Person.new(1910, 1955),
          Person.new(1915, 1916),
          Person.new(1960, 2000),
        ]
      end

      it { is_expected.to eq 1915 }
    end
  end
end
