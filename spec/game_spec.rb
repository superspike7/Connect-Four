require '../lib/board.rb'
require '../lib/game.rb'

describe Game do
  
  subject(:game) { described_class.new(player_one, player_two) }
  let(:player_one) { double("Player", :piece => 'O') }
  let(:player_two) { double("Player", :piece => 'X') }
  let(:board) { game.instance_variable_get(:@board) }
  describe '#win?' do
      it 'returns true player_one wins' do
        board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['O', 'O', 'O', 'O', 'X', 'X', 'X']
        ]
        expect(game.win?).to be true 
      end
      it 'returns true player_two wins' do
        board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['O', 'O', 'O', 'X', 'X', 'X', 'X']
        ]
        expect(game.win?).to be true 
      end
      it 'returns false no one wins' do
        board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['O', 'O', 'O', '.', 'X', 'X', 'X']
        ]
        expect(game.win?).to be false 
      end
  end
end