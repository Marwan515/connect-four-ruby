class Board
    attr_accessor :grid
    def empty_circle
        "\u25cb"
    end

    def initialize()
        @grid = Array.new(6) {Array.new(7) {empty_circle}}
    end

    def display_board
        @grid.each do |row|
            puts row.join(' ')
        end
        puts (1..7).to_a.join(' ')
    end

    def update_board(row, column, symbol)
        @grid[row][column] = symbol
    end

    def full_column?(input)
        @grid[0][input] != empty_circle
      end
    
    def available_row(column)
        row = 0
        loop do
            return row if row == 5 || @grid[row + 1][column] != empty_circle
    
            row += 1
        end
    end

    def check_cols(row, column, symbol)
        return if row > 2
    
        @grid[row][column] == symbol && @grid[row + 1][column] == symbol && @grid[row + 2][column] == symbol && @grid[row + 3][column] == symbol
    end

    def check_rowso(row, column, symbol)
        return if column > 3

        @grid[row][column] == symbol && @grid[row][column + 1] == symbol && @grid[row][column + 2] == symbol && @grid[row][column + 3] == symbol
    end

    def check_diagonal_right(row, column, symbol)
        return if column < 3

        @grid[row][column] == symbol && @grid[row + 1][column - 1] == symbol && @grid[row + 2][column - 2] == symbol && @grid[row + 3][column - 3] == symbol
    end

    def diagonal_left_to_right(row, column, symbol)
        return if column < 3

        @grid[-row][column] == symbol && @grid[-row - 1][column + 1] == symbol && @grid[-row - 2][column + 2] == symbol && @grid[-row - 3][column + 3] == symbol
    end

    def check_diagonal_left(row, column, symbol)
        return if column < 3

        @grid[row][column] == symbol && @grid[row + 1][column + 1] == symbol && @grid[row + 2][column + 2] == symbol && @grid[row + 3][column + 3] == symbol
    end

    def check_diagonals(row, column, symbol)
        return unless row < 3
    
        check_diagonal_right(row, column, symbol) || check_diagonal_left(row, column, symbol) || diagonal_left_to_right(row, column, symbol)
    end
    
    def check_row(row, column, symbol)
        check_rowso(row, column, symbol) || check_cols(row, column, symbol) || check_diagonals(row, column, symbol)
    end

end