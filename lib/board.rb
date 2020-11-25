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
    raise "position is already occupied" if h < 0
   end
   h
  end

  def horizontal_check?(piece)
    count = 0
   grid.each do |layer|
    layer.each do |i|
     i == piece ? count += 1 : count = 0
      return true if count >= 4
    end
   end
   return false
  end

  def vertical_check?(piece)
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
   arr = diagonals_list 
   four_in_a_row = arr.select { |row| row.count(piece) > 3 }
   p four_in_a_row
   return true unless four_in_a_row.empty?
   false
  end

 def diagonals_list
# constant diagonals 
g = @grid
  [
    [g[5][0],g[4][1],g[3][2],g[2][3],g[1][4],g[0][5]],
    [g[5][1],g[4][2],g[3][3],g[2][4],g[1][5],g[0][6]],
    [g[5][2],g[4][3],g[3][4],g[2][5],g[1][6]],
    [g[5][3],g[4][4],g[3][5],g[2][6]],
    [g[4][0],g[3][1],g[2][2],g[1][3],g[0][4]],
    [g[3][0],g[2][1],g[1][2],g[0][3]],
    [g[0][0],g[1][1],g[2][2],g[3][3],g[4][4],g[5][5]],
    [g[0][1],g[1][2],g[2][3],g[3][4],g[4][5],g[5][6]],
    [g[0][2],g[1][3],g[2][4],g[3][5],g[4][6]],
    [g[0][3],g[1][4],g[2][5],g[3][6]],
    [g[1][0],g[2][1],g[3][2],g[4][3],g[5][4]],
    [g[2][0],g[3][1],g[4][2],g[5][3]]
  ]
 end

end

