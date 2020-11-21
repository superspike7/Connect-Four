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

end
