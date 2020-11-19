require '../lib/board.rb'

=begin
  TODO:
  1. Board#win?
  2. Board#move
=end

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
      context '4 consecutive horizonal pattern' do
        xit 'returns true if the board has a present horizonal pattern' do
          # . . . . . . .
          # . . . . . . .
          # . . . . . . .
          # . . . . . . .
          # . . . . . . .
          # O O O O . . .
          board.move('O', 1)
          board.move('O', 2)
          board.move('O', 3)
          board.move('O', 4)
          expect(board.horizontal?).to be true
        end
      end
    end
  end
end



