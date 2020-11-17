class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(6, Array.new(7, '.'))
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

# TODO: 
# horizontal pattern check
# fix this shit

  def horizontal
    player_piece = 'O'
  
    6.times do |i|

    end
  end
  
end

# p Board.new.grid