require 'colorize'
require_relative 'board'


class ConnectFour

    def initialize
        @playing_board = Board.new
        @playerone = yellow_circle
        @playertwo = red_circle
        @player_one_name = nil
        @player_two_name = nil
        @player = nil
        @round = 0
        @j = false
    end

    def play
        if @j == false
            intro
            @j = true
        end
        loop do 
            turn
            puts "#{@player_one_name} VS #{@player_two_name}"
            @playing_board.display_board
            column = playin
            @playing_board.update_board(@playing_board.available_row(column), column, player = @player)
            break if game_over? || draw?
        end
        @playing_board.display_board
        @playing_board = Board.new
        puts "   Enter:[1] To Play Again?\n   Enter:[2] To Exit"
        p = gets.chomp
        if p == "1"
            play
        elsif p == "2"
            return puts "   SEE YOU SOON! CHAMP 🏆"
        end
    end

    def yellow_circle
        a = "\u23fa".colorize(:yellow)
        a
    end

    def red_circle
        b = "\u23fa".colorize(:light_red)
        b
    end

    def draw?
        if @round == 42
            puts "   DRAW!   "
            true
        end
    end

    def playin(currentp = @player)
        a = gets.chomp.to_i - 1
        if verify_input(a)
            @round += 1
            return a
        else
            puts "   Number IS More Than The Columns Or Column is Full!"
            playin(currentp = @player)
        end
    end

    def turn(fplayer = @playerone, splayer = @playertwo)
        if @player.nil?
            @player = fplayer
        else
            if @player == fplayer
                @player = splayer
            elsif @player == splayer
                @player = fplayer
            end
        end
    end

    def intro
        puts "   CONNECT 4OUR   \n   You Have! To Connect Four Dots To Win!   \n   Vertical Horizontal OR Diagonal"
        puts "   Enter First Player NAME: "
        b = gets.chomp.upcase
        @player_one_name = b
        puts "   Enter Second Player's NAME: "
        c = gets.chomp.upcase
        @player_two_name = c
        puts "#{@player_one_name} VS #{@player_two_name} \n To Play You'll Just Have To Enter The Column Number"
    end

    def verify_input(input)
        input.between?(0, 6) && !@playing_board.full_column?(input)
    end


    def game_over?(player = @player)
        6.times do |row|
            7.times do |column|
                if @playing_board.check_row(row, column, player)
                    if player == @playerone
                        puts "    #{@player_one_name} WON!🏆 "
                        return true
                    else
                        puts "    #{@player_two_name} WON!🏆 "
                        return true
                    end
                end
            end
        end
        false
    end

end

start_game = ConnectFour.new()
start_game.play