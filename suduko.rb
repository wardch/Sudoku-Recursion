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
      row_col_box(cell_obj)
    end
  end

  def row_col_box(cell_obj)
    all_nums = (1..9).to_a
    impossibles = []
    impossibles << get_row(cell_obj)
    p impossibles
    # impossibles << cell_obj.get_col
    # impossibles << cell_obj.get_box
    cell_obj.possibles = all_nums - impossibles
  end

  def get_row(cell_obj)
    array = []
    @board.each do |cell_obj_2|
      if cell_obj_2.row == cell_obj.row
        array << cell_obj.num
      end
    end
    return array
  end


end

game1 = Sudoku.new('--3-2-6--9--3-5--1--18-64----81-29--7-------8--67-82----26-95--8--2-3--9--5-1-3--')

game1.cell_board
game1.set_possibilities
game1.board



p `im a little lepracon'