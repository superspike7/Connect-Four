class Player
  attr_accessor :piece, :name
  def initialize(name, piece)
    @name = name
    @piece = piece
  end
end