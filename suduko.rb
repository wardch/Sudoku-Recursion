class Cell

  attr_reader :row, :col, :box
  attr_accessor :num, :possibles

  def initialize(row, col, num)
    @row = row + 1
    @col = col + 1
    @box = [[1,2,3],[4,5,6],[7,8,9]][row/3][col/3]
    @num = num
    @possibles = []
  end
end

class Sudoku

  attr_reader :board

  def initialize(sudoku_string)
    @sudoku_board = sudoku_string.split('').map(&:to_i).each_slice(9).to_a
    @board = []
  end

  def cell_board
    @sudoku_board.each_with_index do |sub_array, row_index|
      sub_array.each_with_index do |element, col_index|
       @board << Cell.new(row_index, col_index, element)
      end
    end
  end

  def set_possibilities
    @board.each do |cell_obj|
      if cell_obj.num == 0
        row_col_box(cell_obj)
      else
        cell_obj.possibles = []
      end
    end
  end

  def row_col_box(cell_obj)
    all_nums = (1..9).to_a
    impossibles = []
    impossibles += get_row(cell_obj)
    impossibles += get_col(cell_obj)
    impossibles += get_box(cell_obj)
    cell_obj.possibles = all_nums - impossibles.uniq
  end

  def get_row(cell_obj)
    array = []
    @board.each do |cell_obj_2|
      if cell_obj_2.row == cell_obj.row
        array << cell_obj_2.num
      end
    end
    array
  end

  def get_col(cell_obj)
    array = []
    @board.each do |cell_obj_2|
      if cell_obj_2.col == cell_obj.col
        array << cell_obj_2.num
      end
    end
    array
  end

  def get_box(cell_obj)
    array = []
    @board.each do |cell_obj_2|
      if cell_obj_2.box == cell_obj.box
        array << cell_obj_2.num
      end
    end
    array
  end

  def to_s
    string = <<-BOARD
          SUDOKU BOARD!
      +-------+-------+-------+
      | X X X | X X X | X X X |
      | X X X | X X X | X X X |
      | X X X | X X X | X X X |
      +-------+-------+-------+
      | X X X | X X X | X X X |
      | X X X | X X X | X X X |
      | X X X | X X X | X X X |
      +-------+-------+-------+
      | X X X | X X X | X X X |
      | X X X | X X X | X X X |
      | X X X | X X X | X X X |
      +-------+-------+-------+
    BOARD

    @board.each do |cell_obj|
      string.sub!("X", cell_obj.num.to_s)
    end
    print "\e[2J"
    print "\e[H"
    puts string
  end

  def fill_once
    @board.each do |cell_obj|
      if cell_obj.possibles.size == 1
        cell_obj.num = cell_obj.possibles.first
      end
    end
  end

  def solve
    return false unless valid_board?
    return self.to_s if solved?
    until solved?
      fill_once
      set_possibilities
    end

    # talk about how you need to get the last part of the recursion down.

    #   @board.each do |cell_obj|
    #     (1..9).each do |guess|
    #       if cell_obj.num == 0
    #         cell_obj.num = guess
    #         sudoku_string = "a"
    #         @board.each do |cell_obj|
    #           sudoku_string << cell_obj.num
    #         end
    #         sudoku_string.slice!(0)
    #         solved_board = Sudoku.new(sudoku_string)
    #         solved_board.cell_board
    #         solved_board.solve
    #         return solved_board if solved_board
    #       end
    #     end
    # end
  end

  def solved?
    @board.each do |cell_obj|
      return false if cell_obj.num == 0
    end
  end

  def valid_board?
    @board.each do |cell_obj|
      return false unless valid_row(cell_obj) && valid_col(cell_obj) && valid_box(cell_obj)
    end
    return true
  end

  def valid_row(cell_obj)
    pre_uniqed_array = []
    pre_uniqed_array += get_row(cell_obj)
    pre_uniqed_array.delete(0)
    return false unless pre_uniqed_array.uniq == pre_uniqed_array
    return true
  end

  def valid_col(cell_obj)
    pre_uniqed_array = []
    pre_uniqed_array += get_col(cell_obj)
    pre_uniqed_array.delete(0)
    return false unless pre_uniqed_array.uniq == pre_uniqed_array
    return true
  end

  def valid_box(cell_obj)
    pre_uniqed_array = []
    pre_uniqed_array += get_box(cell_obj)
    pre_uniqed_array.delete(0)
    return false unless pre_uniqed_array.uniq == pre_uniqed_array
    return true
  end

  # def valid_row_box_col?(cell_obj)
  #   pre_uniqed_array = []
  #   pre_uniqed_array += get_box(cell_obj)
  #   pre_uniqed_array += get_col(cell_obj)
  #   pre_uniqed_array += get_row(cell_obj)
  #   pre_uniqed_array.delete(0)
  #   p pre_uniqed_array
  #   p cell_obj
  #   puts
  #   p pre_uniqed_array.uniq
  #   return false unless pre_uniqed_array == pre_uniqed_array.uniq
  #   return true
  # end

  def any_left_through_iteration?
    @board.each do |cell_obj|
      return false unless cell_obj.possibles.length == 1
    end
  end

end


# game1 = Sudoku.new("2---8-3---6--7--84-3-5--2-9---1-54-8---------4-27-6---3-1--7-4-72--4--6---4-1---3")
game1 = Sudoku.new("--3-2-6--9--3-5--1--18-64----81-29--7-------8--67-82----26-95--8--2-3--9--5-1-3--")

game1.cell_board
game1.to_s

game1.solve
game1.to_s


