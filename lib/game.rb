require_relative './board.rb'
require_relative './player.rb'

class Game
  attr_accessor :board

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @board = Board.new
  end

  def win?
    case check_winners
    when 'player_1'
      puts "player one wins!"
      true
    when 'player_2'
      puts "player two wins!"
      true
    when 'none'
      false
    end
  end

  def play
    until self.win?
      board.show_board
      puts "player one move"
      player1_move = gets.chop.to_i
      board.move(@player_1.piece, player1_move)
      board.show_board
      self.win?
      puts "player two move"
      player1_move = gets.chop.to_i
      board.move(@player_2.piece, player1_move)
      board.show_board
    end
  end

  private

  def check_winners
    return 'player_1' if board.horizontal_check?(@player_1.piece) || board.vertical_check?(@player_1.piece) || board.diagonal_check?(@player_1.piece)
    return 'player_2' if board.horizontal_check?(@player_2.piece) || board.vertical_check?(@player_2.piece) || board.diagonal_check?(@player_2.piece)
    return 'none' 
  end


end

spike = Player.new('O')
vinz = Player.new('X')

Game.new(spike, vinz).play
