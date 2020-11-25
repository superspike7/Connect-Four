require_relative './board.rb'
require_relative './player.rb'

class Game
  attr_accessor :board

  def initialize(player_1, player_2)
    @player_1 = player_1
    @player_2 = player_2
    @board = Board.new
  end

  def check_board
    case check_winners
    when 'player_1'
      puts "#{@player_1.name} wins!"
      true
    when 'player_2'
      puts "#{@player_2.name} wins!"
      true
    when 'none'
      false
    end
  end

  def play
    until check_board
      board.show_board
      player_prompt(@player_1)
      return "#{@player_1.name} wins!" if check_board
      board.show_board
      player_prompt(@player_2)
    end
  end

  def player_prompt(player) 
    puts "#{player.name} move"
    begin
      player_move = gets.chomp.to_i
      board.move(player.piece, player_move)
    rescue => exception
      puts "please try another column"
    retry
    end
  end

  private

  def check_winners
    return 'player_1' if board.horizontal_check?(@player_1.piece) || board.vertical_check?(@player_1.piece) || board.diagonal_check?(@player_1.piece)
    return 'player_2' if board.horizontal_check?(@player_2.piece) || board.vertical_check?(@player_2.piece) || board.diagonal_check?(@player_2.piece)
    return 'none' 
  end


end

spike = Player.new('spike', 'O')
vinz = Player.new('vinz', 'X')

Game.new(spike, vinz).play
