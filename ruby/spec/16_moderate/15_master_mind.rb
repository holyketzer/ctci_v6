module MasterMind
  def score(guess, solution)
    hits = 0
    guess_used = [false] * guess.size
    # solution_used = [false] * solution.size
    missed = Hash.new { |hash, key| hash[key] = 0 }

    guess.size.times do |i|
      if guess[i] == solution[i]
        hits += 1
        guess_used[i] = true
        # solution_used[i] = true
      else
        missed[solution[i]] += 1
      end
    end

    pseudo_hits = 0

    guess.size.times do |i|
      c = guess[i]

      if !guess_used[i] && missed[c] > 0
        pseudo_hits += 1
        missed[c] -= 1
      end
    end

    {
      hits: hits,
      pseudo_hits: pseudo_hits
    }
  end

  RSpec.describe 'score' do
    include MasterMind

    subject { score(guess, solution) }

    context '4 hits' do
      let(:solution) { 'RGBY' }
      let(:guess) { 'RGBY' }

      it { is_expected.to eq(hits: 4, pseudo_hits: 0) }
    end

    context '2 hits + 2 pseudo-hits' do
      let(:solution) { 'RGBY' }
      let(:guess) { 'RYBG' }

      it { is_expected.to eq(hits: 2, pseudo_hits: 2) }
    end

    context '1 hits + 2 pseudo-hits' do
      let(:solution) { 'RGBY' }
      let(:guess) { 'RBGB' }

      it { is_expected.to eq(hits: 1, pseudo_hits: 2) }
    end

    context '0 hits + 4 pseudo-hits' do
      let(:solution) { 'RGBY' }
      let(:guess) { 'YBGR' }

      it { is_expected.to eq(hits: 0, pseudo_hits: 4) }
    end

    context '0 hits + 0 pseudo-hits' do
      let(:solution) { 'RGRG' }
      let(:guess) { 'BYBY' }

      it { is_expected.to eq(hits: 0, pseudo_hits: 0) }
    end

    context '6 chars string: 1 hits + 3 pseudo-hits' do
      let(:solution) { 'RGRGRG' }
      let(:guess)    { 'GRBYRR' }

      it { is_expected.to eq(hits: 1, pseudo_hits: 3) }
    end
  end
end
