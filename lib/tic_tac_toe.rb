class TicTacToe
    attr_accessor :board

    def initialize
        @board = [" "] * 9
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, player)
        @board[index] = player
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        (0..9).include?(index) && !position_taken?(index)
    end

    def turn_count
        @board.count { |pos| ["X", "O"].include?(pos) }
    end

    def current_player
        self.turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        input = gets.chomp
        ind = self.input_to_index(input)
        self.valid_move?(ind) ? self.move(ind, self.current_player) : self.turn 
        self.display_board
    end

    def won?
        WIN_COMBINATIONS.find do |combo|
            x_win = combo.all? do |ind|
                @board[ind] == "X"
            end
            o_win = combo.all? do |ind|
                @board[ind] == "O"
            end
            x_win || o_win
        end
    end

    def full?
        @board.none?(" ")
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.draw? || self.won?
    end

    def winner
        @board[self.won?[0]] if self.won?
    end

    def play
        until self.over?
            self.turn
        end
        puts "Congratulations #{self.winner}!" if self.won?
        puts "Cat's Game!" if self.draw?
    end


end