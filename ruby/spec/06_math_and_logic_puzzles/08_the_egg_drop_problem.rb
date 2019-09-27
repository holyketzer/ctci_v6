RSpec.describe 'smallest count of drops' do
  it do
    i = 1
    n = 1

    while i < 100 do
      n += 1
      i += n
      p i
    end

    expect(n).to eq 14
  end
end
