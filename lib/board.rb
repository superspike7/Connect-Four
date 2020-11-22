class Board
  attr_accessor :grid
  def initialize(grid = make_grid)
    @grid = grid 
  end

  def make_grid
    Array.new(6) {Array.new(7) { '.' } }
  end

  def move(piece, position)
    position -= 1
    height = 5
    # to make sure height is clear
    h = validate(height, position)
    grid[h][position] = piece
  end

  def validate(h, pos)
   until grid[h][pos] == '.' do 
    h -= 1
    raise "position is full" if h < 0
   end
   h
  end

  def horizontal?(piece)
    count = 0
   grid.each do |layer|
    layer.each do |i|
     i == piece ? count += 1 : count = 0
      return true if count >= 4
    end
   end
   return false
  end

  def vertical?(piece)
    count = 0
    grid = @grid.transpose
    grid.each do |layer|
      layer.each do |i|
        i == piece ? count += 1 : count = 0
        return true if count >= 4
      end
    end
    return false
  end

  def diagonal_check?(piece)
    true
  end

  def four_in_a_row_by_row(arr)
    arr.each do |row|
      a = row.each_cons(4).find { |a| a.uniq.size == 1 && a.first != '.'}
      return a.first unless a.nil?
    end
    return nil
  end

  def diagonals(grid)
   (0..grid.size-4).map do |i|
    (0..grid.size-1-i).map { |j| grid[i+j][j] }
    end.concat((1..grid.first.size-4).map do |j|
      (0..grid.size-j-1).map { |i| grid[i][j+i] }
    end)
  end

  def rotate90(grid=@grid)
  ncols = grid.first.size
  grid.each_index.with_object([]) do |i,a|
    a << ncols.times.map { |j| grid[j][ncols-1-i] }
  end
end


end

board = Board.new
board.grid = [
          ['1', '4', '5', '6', 'x', '.', 'O'],
          ['2', '1', '4', '5', '6', '3', 'X'],
          ['3', '2', '1', '4', '5', '6', 'O'],
          ['3', '3', '2', '1', '4', '5', '6'],
          ['.', 'O', '3', '2', '1', '4', '5'],
          ['O', 'O', 'X', '3', '2', '1', '4']
        ]
# p board.four_in_a_row_by_row

# row = ['O', 'O', 'X', 'O', 'X', 'O', 'O']
# enum0 = row.each_cons(4)
# enum1 = enum0.find
# p enum1.to_a
# p a = enum1.next
# p u = a.uniq
# p u = u.size == 1
p board.diagonals(board.grid) 
p board.rotate90
p board.diagonals(board.gird)