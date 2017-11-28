require "pry"
class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Left diagonal
    [2,4,6]  # Right diagonal
  ]


  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def over?
      board.full?
  end

  def won?
    WIN_COMBINATIONS.detect do |match_array|
      @board.taken?(match_array[0]) &&
      @board.cells[match_array[0]] == @board.cells[match_array[1]] &&
      @board.cells[match_array[1]] == @board.cells[match_array[2]]
    end
  end

  def draw?
    board.full? && !self.won?
  end

  def winner
    # binding.pry
    if win_combo = won?
      board.cells[win_combo.first]
    end
  end

end
