# Game 1 win = p
# Game 2

# q = 1 - p

# case | -> shots  | probability | game 2 win |
#      | 1 | 2 | 3 |             |            |
# -----|---|---|---|-------------|------------|
#  1   |   |   |   | q * q * q   |     no     |
#  2   | x |   |   | p * q * q   |     no     |
#  3   |   | x |   | p * q * q   |     no     |
#  4   |   |   | x | p * q * q   |     no     |
#  5   | x | x |   | p * p * q   |    yes     |
#  6   |   | x | x | p * p * q   |    yes     |
#  7   | x |   | x | p * p * q   |    yes     |
#  8   | x | x | x | p * p * p   |    yes     |

# Game 2 win = 3 * p * p * q + p * p * p = p^2 (3 * q + p)
# => 3*p^2 - 2*p^3

# To find cross points equal equations
# 3*p^2 - 2*p^3 = p
# => p*(3p - 2p^2 - 1) = 0
# p - can't be zero because there is no win in games
# => (3p - 2p^2 - 1) = 0
# roots (when chanes to win in both games are equal):
# p = 0.5
# p = 1.0

# Game 1 preferable if p = 0..0.5,
# Game 2 preferable if p > 0.5
# p = 0.5 or p = 1.0 both games are ok

def game1_win(p)
  p
end

def game2_win(p)
  (3 * p * p) - (2 * p * p * p)
end

RSpec.describe 'find_heaviest_jar' do
  it do
    (0..1).step(0.05).each do |p|
      g1 = game1_win(p)
      g2 = game2_win(p)

      prefer = g1 > g2 ? 'prefer game 1' : (g2 > g1 ? 'prefer game 2' : 'both games ok')

      if ARGV[0] && __FILE__.include?(ARGV[0])
        puts "  p = #{'%.2f' % p} Game1 = #{'%.2f' % g1} Game2 = #{'%.2f' % g2}  #{prefer}"
      end
    end
  end
end
