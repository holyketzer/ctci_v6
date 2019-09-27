def birth
  rand < 0.5 ? :boy : :girl
end

def deliver_until_girl
  res = { boy: 0, girl: 0 }

  while (birth != :girl) do
    res[:boy] += 1
  end

  res[:girl] += 1
  res
end

RSpec.describe 'queens policy' do
  it do
    res = { boy: 0, girl: 0 }

    100_000.times do
      sub_res = deliver_until_girl

      res[:boy] += sub_res[:boy]
      res[:girl] += sub_res[:girl]
    end

    gender_ratio = res[:boy] / res[:girl].to_f

    expect(gender_ratio).to be_within(0.01).of(1)
  end
end
