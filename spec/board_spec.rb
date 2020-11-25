require '../lib/board.rb'

describe Board do

  subject(:board) { described_class.new }
  let(:player) { double(:player) }

  describe '#move(player, location)' do
    
    context "drops player's piece in a empty bottom space" do

    before do
      allow(player).to receive(:piece).and_return('O')
    end 
      
      it 'drops to the most bottom part of the board in poisition 1' do
        position = 1
        player_1 = player.piece
        expect { board.move(player_1, position) }.to change { board.grid[5][0] }.to eq player_1
      end
      
      it 'drops to the most bottom part of the board in position 7' do
        position = 7
        player_1 = player.piece
        expect { board.move(player_1, position) }.to change { board.grid[5][6] }.to eq player_1
      end
    
    end

    context "drops player's piece on top in a existing piece" do
      
    before do
      allow(player).to receive(:piece).and_return('O')
    end 
    
      it 'drops on top of a existing piece' do
        position = 1
        player_1 = player.piece
        board.move(player_1, 1)
        expect { board.move(player_1, position) }.to change { board.grid[4][0] }.to eq player_1
      end

      it 'drops on top of two existing pieces' do
        position = 1
        player_1 = player.piece
        2.times { board.move(player_1, 1)}
        expect { board.move(player_1, position) }.to change { board.grid[3][0] }.to eq player_1
      end
      
    end

    context "if height is full" do
      before do
        allow(player).to receive(:piece).and_return('O')
      end

      it "raises an error if there are 6 existing pieces" do
        position = 1
        player_1 = player.piece
        6.times { board.move(player_1, position) }
        expect { board.move(player_1, position) }.to raise_error("position is full")
      end
    end
  describe '#horizontal?' do
      context '5th layer horizonal pattern' do
        it 'returns true if there is 4 consecutive pieces in a horizontal pattern' do
          player_piece = 'O'
          board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['O', 'O', 'O', 'O', '.', '.', '.']
          ]
          expect(board.horizontal?(player_piece)).to be true
        end
        
        it 'returns false if there is no 4 consecutive horizional pattern' do
          player_piece = 'O'
          board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['O', '.', 'O', 'O', 'X', 'O', 'O']
          ]
          expect(board.horizontal?(player_piece)).to be false 
        end
      end
      
      context '4th layer horizontal pattern' do
        it 'recognizes the 1234 pattern' do
          player_piece = 'X'
          board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['X', 'X', 'X', 'X', '.', '.', '.'],
            ['O', 'O', 'X', 'O', 'X', 'O', 'O']
          ]
          expect(board.horizontal?(player_piece)).to be true
        end
      end

        it 'returns false when there is no 4 consecutive piece with a horizontal pattern' do
          player_piece = 'X'
          board.grid = [
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['.', '.', '.', '.', '.', '.', '.'],
            ['X', 'O', 'X', 'X', '.', '.', '.'],
            ['O', 'O', 'X', 'O', 'X', 'O', 'O']
          ]
          expect(board.horizontal?(player_piece)).to be false
       end
    end
  end

  describe '#vertical?' do
    context 'first row' do
      it 'returns true when there is 4 piece of consecutive vertical pattern' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', '.'],
          ['.', '.', '.', '.', '.', '.', '.'],
          ['O', '.', '.', '.', '.', '.', '.'],
          ['O', '.', '.', '.', '.', '.', '.'],
          ['O', '.', '.', '.', '.', '.', '.'],
          ['O', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.vertical?(player_piece)).to be true
      end
      it 'returns false when there are no vertical pattern visible' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', '.'],
          ['O', '.', '.', '.', '.', '.', '.'],
          ['O', '.', '.', '.', '.', '.', '.'],
          ['X', '.', '.', '.', '.', '.', '.'],
          ['O', '.', '.', '.', '.', '.', '.'],
          ['O', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.vertical?(player_piece)).to be false 
      end
    end
    context '7th row' do
      it 'returns true when there is a vertical pattern visible' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.vertical?(player_piece)).to be true 
      end
      it 'returns false when there is no vertical pattern visible' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.vertical?(player_piece)).to be false 
      end
    end
  end

  describe '#diagonal?' do
    context 'when diagonal is bottom left to upper right' do
      it 'returns true when there is a 4 in a row diagonal' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', '.', '.', 'O', '.', '.', 'O'],
          ['.', '.', 'O', '.', '.', '.', 'O'],
          ['.', 'O', '.', '.', '.', '.', 'X'],
          ['O', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.diagonal_check?(player_piece)).to be true 
      end
      it 'returns false when there is no 4 in a row diagonal' do
        
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', '.', '.', 'O', '.', '.', 'O'],
          ['.', '.', 'x', '.', '.', '.', 'O'],
          ['.', 'O', '.', '.', '.', '.', 'X'],
          ['O', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.diagonal_check?(player_piece)).to be false 
      end
    end
    context 'when horizontal is upper left to bottom right' do
      it 'returns true when there is a 4 in a row diagonal' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', '.', '.', 'O', '.', '.', 'O'],
          ['.', '.', 'X', '.', 'O', '.', 'O'],
          ['.', 'O', '.', '.', '.', 'O', 'X'],
          ['O', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.diagonal_check?(player_piece)).to be true 
      end
      it 'returns false when there is no 4 in a row diagonal' do
        player_piece = 'O'
        board.grid = [
          ['.', '.', '.', '.', '.', '.', 'O'],
          ['.', '.', '.', '.', '.', '.', 'X'],
          ['.', '.', '.', 'O', '.', '.', 'O'],
          ['.', '.', 'X', '.', 'O', '.', 'O'],
          ['.', 'O', 'X', 'O', 'X', 'X', 'X'],
          ['O', 'O', 'X', 'O', 'X', 'O', 'O']
        ]
        expect(board.diagonal_check?(player_piece)).to be false 
      end
    end
  end
end

