class Jar
  attr_writer :pill_weight

  def initialize(pill_weight)
    @pill_weight = pill_weight
  end

  def get_pills(n)
    n * @pill_weight
  end
end

def find_heaviest_jar(jars, standard_pill_weight, anomaly_pill_weight)
  count = 0

  set_of_pills_weight = jars.each_with_index.reduce(0) do |res, (jar, index)|
    count += index + 1
    res + jar.get_pills(index + 1)
  end

  ((count * standard_pill_weight - set_of_pills_weight) / (standard_pill_weight - anomaly_pill_weight)).abs.round
end

RSpec.describe 'find_heaviest_jar' do
  subject { find_heaviest_jar(jars, standard_pill_weight, anomaly_pill_weight) }

  let(:standard_pill_weight) { 1 }
  let(:anomaly_pill_weight) { 1.1 }
  let(:jars) { 20.times.map { Jar.new(standard_pill_weight) } }

  context 'first jar' do
    before { jars[0].pill_weight = anomaly_pill_weight }

    it { is_expected.to eq 1 }
  end

  context 'fifth jar' do
    before { jars[4].pill_weight = anomaly_pill_weight }

    it { is_expected.to eq 5 }
  end

  context 'last jar' do
    before { jars[19].pill_weight = anomaly_pill_weight }

    it { is_expected.to eq 20 }
  end
end
