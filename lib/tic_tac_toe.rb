require 'pry'
# Define your WIN_COMBINATIONS constant
 WIN_COMBINATIONS = [[0,1,2],
                     [3,4,5],
                     [6,7,8],
                     [0,3,6],
                     [1,4,7],
                     [2,5,8],
                     [0,4,8],
                     [6,4,2] ]
# Helper Method
def position_taken?(board, index)
  if (board[index] == 'X' || board[index] == 'O')
    return true
  else
    return false
  end
end
def won? (board)
  #won? : returns winning combination or false if no winning comb
  #for each row, column and diagnonal combination
  WIN_COMBINATIONS.each do | win_combination |
    #grab the winning combination of indices we are looking for
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    #extract the value of these winning indices from the board
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    #check if either team has won
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
       (position_1 == "O" && position_2 == "O" && position_3 == "O")
       #we break out of here if we have a winning row, col, or diagnonal
       return win_combination
      end #end if
  end #end for each

  #if we get here there were no winning combinations
  return false
end
def full? (board)

  #check for empty elements
  board.each do | entry |
    if (entry == " " || entry == nil)
      return false
    end
  end
  #if we make it here, no elements on the board are empty
  return true
end
def draw?(board)
  if full?(board)
      if !won?(board)
        return true
      end
  else #board is not full
    return false
  end  #board is not full and not won
end
def over?(board)
    if won?(board) || draw?(board) || full?(board)
      return true
    else
      return false
    end
end
def valid_move?(board, index)
  puts "valid_move?  board:  #{board}"
  puts "valid_move?  index:  #{index}"
  if !index.between?(0,8)
    puts "[valid_move]: Invalid index:  #{index}"
  end

  if position_taken?(board, index)
    puts "[valid_move]: Position taken:  #{index}"
  end

  return (index.between?(0,8) && !position_taken?(board, index))
end
def winner(board)
  win_array = won?(board)

  if !win_array
    return nil
  elsif board[win_array[0]] == "X"
    return "X"
  elsif board[win_array[0]] == "O"
    return "O"
  end
end
def turn_count(board)
  #board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"]
  #turn_count = 3
  i = 0
  board.each do | entry |
    puts "board[#{i}] = #{entry}"
    i += 1
  end
  puts "count = #{i}"

  count = 0
  board.each do| entry |
    if entry == "X" || entry == "O"
      puts "board = #{entry}"
      count += 1
    else
      puts "board = empty #{entry}"
   end
 end
 puts "counted:  #{count}"
 return count
end
def current_player(board)
  # board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
  #  returns current player = 'X' for first move
  #  returns current player = 'Y' for second move

  count = turn_count(board)
  if count % 2 == 0
    puts "count = #{count}, player = 'X'"
    player = 'X'
  else
    puts "count = #{count}, player = 'O'"
    player = 'O'
  end
  return player
end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts(" ")
  puts(" ")
end
def player_move(board, index, current_player) #current_player = "X"
  #assumes position_taken? = no, and valid_move? = yes, and index is valid
  board[index] = current_player
end
def get_input(token)
  print "Player #{token} select an unused cell:  [1-9]:  "
  input = gets.strip
  puts ""
  return input
end
def get_new_token(token)
  if token == 'X'
    return 'O'
  else
    return 'X'
  end
end
def turn (board)
  token = 'X'
  #input = get_input(token)
  print "Enter cell [1-9]:  "
  input = gets
  puts " "

  index = input_to_index(input) #just subtracts 1 from any value
  while !index.between(0,8)
    print "Invalid entry.  Enter [1-9]:  "
    input = gets
    puts " "
    index = input_to_index(input)
  end
  if (valid_move?(board, index))
    player_move(board, index, token)
    #token = get_new_token(token)
    success = true
  else
    success = false
  end
  return success

  #NOT SURE WHICH VERSION WILL WORK BEST
  #  index = -1
  #while index < 0
  #  puts "Please enter 1-9:"
  #  input = gets.strip
  #  index = input_to_index(input)
  #  if (index < 0)
  #    puts "Invalid entry.  #{input}"
  #    puts ""
  #  end
  #end
  #if valid_move?(board, index)
  #    move(board, index, 'X')
   #   display_board(board)
   #   puts "END ..."
   #   puts ""
  #else
  #  puts "Invalid move.  "
  #  turn(board)
  #end

end
def play(board)
  iter = 1
  while iter <= 9
    success = turn(board)
    display_board(board)
    if success
      iter += 1
    end
  end
end
def input_to_index(input)
  #returns 0 if not a float or int
  index = input.to_i
  if index.between?(1,9)
    return (index - 1)
  else
    return -1
  end
end
