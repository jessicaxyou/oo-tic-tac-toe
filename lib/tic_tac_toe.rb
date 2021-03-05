require 'pry'

class TicTacToe

    #assigns an instance variable @board to an array with 9 blank spaces " "
    def initialize(board=nil)
        @board = Array.new(9, " ") #do not need to assign board as argument in initialize
    end

    #defines a constant WIN_COMBINATIONS with arrays for each win combination
    #there are 8 positions with 9 spaces created on board
    #tictactoe requires 3 in a row to win so come up with all the numbers that will win the tictactoe
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6],
    ]  #inside of a nested array

    #prints arbitrary arrangements of the board
    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    # accepts the user's input (a string) as an argument
    # converts the user's input (a string) into an integer
    # converts the user's input from the user-friendly format (on a 1-9 scale) to the array-friendly format (where the first index starts at 0)
    def input_to_index(string_choice)
        string_choice.to_i - 1 #change string to integer
        #user number choices start at 1 but index starts at 0 so need to -1 to change to index start point
    end

    #allows "X" player in the top left and "O" in the middle
    #needs "X" and "O" as output values
    def move(index, player_letter = "X") #pull the input_to_index  from prior into board
        @board[index] = player_letter #this is the token to put index onto board
    end

    #returns true/false based on whether the position on the board is already occupied 
    def position_taken?(index) #taking the position that is being taken
        @board[index]== "X" || @board[index]== "O" #need to indicate both X and O separately
    end

    #returns true/false based on whether the position is already occupied
    #checks that the attempted move is within the bounds of the game board
    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index) #if position from prior is not taken
    end

    #counts occupied positions
    def turn_count
        @board.count{|letter| letter == "X" || letter == "O"}
    end

    # returns the correct player, X, for the third move
    # returns the correct player, O, for the fourth move
    def current_player #even vs odd number defined by turn_count method prior
        turn_count % 2 == 0 ? "X" : "O"
    end

    # receives user input via the gets method
    # calls #input_to_index, #valid_move?, and #current_player 
    # makes valid moves and displays the board
    # asks for input again after a failed validation 
    def turn
        puts "Please make your choice from 1-9."
        user_input = gets.strip
        #temp variable position stores user's choice
        position = input_to_index(user_input) #gets the position of the choice from player
        if valid_move?(position)
            move(position, current_player) #if position open, we call on the move method from prior
            display_board
        else
            turn
        end
    end

    # returns false for a draw (FAILED - 2)
    # returns the winning combo for a win (FAILED - 3)
    def won?
        WIN_COMBINATIONS.detect do |combo|
            @board[combo[0]] == @board[combo[1]] &&
            @board[combo[1]] == @board[combo[2]] &&
            position_taken?(combo[0])
        end
    end

    # returns true for a draw (FAILED - 2)
    # returns false for an in-progress game (FAILED - 3)
    def full?
        @board.all?{|token| token == "X" || token == "O"}
    end

    def draw?
    #     returns true for a draw (FAILED - 2)
    #     returns false for a won game (FAILED - 3)
    #     returns false for an in-progress game (FAILED - 4)
        !won? && full?
    end


    def over?
    #     returns true for a draw (FAILED - 5)
    #     returns true for a won game (FAILED - 6)
    #     returns false for an in-progress game (FAILED - 7)
        won? || draw?
    end

    def winner
    #     return X when X won (FAILED - 8)
    #     returns O when O won (FAILED - 9)
    #     returns nil when no winner (FAILED - 10)
        if winning_combo = won?
            @board[winning_combo.first]
        end
    end

    # asks for players input on a turn of the game (FAILED - 2)
    # checks if the game is over after every turn (FAILED - 3)
    # plays the first turn of the game (FAILED - 4)
    # plays the first few turns of the game (FAILED - 5)
    # checks if the game is won after every turn (FAILED - 6)
    # checks if the game is draw after every turn (FAILED - 7)
    # stops playing if someone has won (FAILED - 8)
    # congratulates the winner X (FAILED - 9)
    # congratulates the winner O (FAILED - 10)
    # stops playing in a draw (FAILED - 11)
    # prints "Cat's Game!" on a draw (FAILED - 12)
    # plays through an entire game (FAILED - 13)
    def play
        while !over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end