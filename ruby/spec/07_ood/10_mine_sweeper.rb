class MineCell
  attr_reader :mine
  attr_accessor :opened, :count, :checked

  def initialize(mine:)
    @mine = mine
    @opened = false
    @checked = false
    @count = 0
  end

  def to_s
    opened ? (mine ? '*' : (count > 0 ? count.to_s : ' ')) : '?'
  end
end


class MineField
  def initialize(n, b)
    @n = n
    @b = b
    @arr = Array.new(n)
    n.times { |i| @arr[i] = Array.new(n) }
    fill_with_random_mines
  end

  def fill_with_random_mines
    mines = Set.new

    while mines.size < @b do
      mines << rand(@n * @n)
    end

    each_cell do |cell, row, col|
      @arr[row][col] = MineCell.new(mine: mines.include?(row * @n + col))
    end
  end

  def open(row, col)
    cell = @arr[row][col]

    if cell.checked == false
      cell.opened = true
      cell.checked = true
      cell.count = 0

      each_neighboor(row, col) do |c, row, col|
        if c.mine == true
          cell.count += 1
        end
      end

      if cell.count == 0
        each_snwe_neighboor(row, col) do |c, row, col|
          open(row, col)
        end
      end
    end
  end

  def check_game_finished
    mines_opened = 0
    cells_opened = 0

    each_cell do |cell, _, _|
      if cell.opened
        cells_opened += 1

        if cell.mine
          mines_opened += 1
        end
      end
    end

    if mines_opened > 0
      :lose
    elsif @n * @n - @b == cells_opened
      :win
    end
  end

  def each_cell(&block)
    @n.times do |row|
      @n.times do |col|
        block.call(@arr[row][col], row, col)
      end
    end
  end

  def each_neighboor(row, col, &block)
    each_snwe_neighboor(row, col, &block)
    each_diagonal_neighboor(row, col, &block)
  end

  def each_snwe_neighboor(row, col, &block)
    # n
    if (r = row - 1) >= 0
      block.call(@arr[r][col], r, col)
    end

    # s
    if (r = row + 1) < @n
      block.call(@arr[r][col], r, col)
    end

    # w
    if (c = col - 1) >= 0
      block.call(@arr[row][c], row, c)
    end

    # e
    if (c = col + 1) < @n
      block.call(@arr[row][c], row, c)
    end
  end

  def each_diagonal_neighboor(row, col, &block)
    # nw
    if (r = row - 1) >= 0 && (c = col - 1) >= 0
      block.call(@arr[r][c], r, c)
    end

    # ne
    if (r = row - 1) >= 0 && (c = col + 1) < @n
      block.call(@arr[r][c], r, c)
    end

    # sw
    if (r = row + 1) < @n && (c = col - 1) >= 0
      block.call(@arr[r][c], r, c)
    end

    # se
    if (r = row + 1) < @n && (c = col + 1) < @n
      block.call(@arr[r][c], r, c)
    end
  end

  def to_s
    res = ['  ' + @n.times.map(&:to_s).join(' ')]

    @n.times do |row|
      res << "#{row} " + @arr[row].map(&:to_s).join(' ')
    end

    res.join("\n")
  end

  def reset_checked!
    each_cell { |cell, _, _| cell.checked = false }
  end

  def open_mines!
    each_cell do |cell, _, _|
      if cell.mine
        cell.opened = true
      end
    end
  end

  def valid_row_col?(row, col)
    row >= 0 && row < @n && col >= 0 && col < @n
  end

  def start_game!
    while (res = check_game_finished) == nil do
      puts to_s

      puts "You move: row col (with space betwen)"
      row, col = *gets.strip.split(' ').map(&:to_i)
      if valid_row_col?(row, col)
        open(row, col)
        reset_checked!
      else
        puts 'Invalid row or col'
      end
    end

    open_mines!
    puts to_s
    puts "You #{res}!!!"
  end
end

MineField.new(10, 3).start_game!

