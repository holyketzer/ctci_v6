class JugOfWater
  attr_reader :volume, :max_volume

  def initialize(max_volume)
    @max_volume = max_volume
    @volume = 0
  end

  def transfuse_from(another_jug)
    delta = [another_jug.volume - @volume, @max_volume - @volume].min
    @volume += delta
    another_jug.volume -= delta
  end

  def fill
    @volume = @max_volume
  end

  def pour_out
    @volume = 0
  end

  def to_s
    "#{@volume}/#{@max_volume}L"
  end

  protected

  def volume=(amount)
    @volume = amount
  end
end

RSpec.describe JugOfWater do
  let(:jug5) { described_class.new(5) }
  let(:jug3) { described_class.new(3) }

  it do
    jug5.fill
    jug3.transfuse_from(jug5)
    jug3.pour_out()
    jug3.transfuse_from(jug5)
    jug5.fill
    jug3.transfuse_from(jug5)

    expect(jug5.volume).to eq 4
    expect(jug3.volume).to eq 3
  end
end

