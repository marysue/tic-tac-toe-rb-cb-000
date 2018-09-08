require 'pry'

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
def valid_move?(board, index)
  #catching invalid input
  if !index.between?(0,8)
    puts "[valid_move?]: Invalid index:  #{index}"
  end

  if position_taken?(board, index)
    puts "[valid_move?]: Position taken:  #{index}"
  end

  #actually doing the thing
  return (index.between?(0,8) && !position_taken?(board, index))
end
def display_board(board)
  #puts("     #{board[]} | #{board[]} | #{board[]}")
  puts(" #{board[0]} | #{board[1]} | #{board[2]}  ")
  puts("-----------")
  puts(" #{board[3]} | #{board[4]} | #{board[5]}  ")
  puts("-----------")
  puts(" #{board[6]} | #{board[7]} | #{board[8]}  ")
  puts(" ")
  puts(" ")
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
def position_taken?(board, location)
  board[location] != " " && board[location] != "" && board[location] != nil
end
def player_move(board, index, current_player) #, current_player = "X") #used to be called just move
  #assumes position_taken? = no, and valid_move? = yes, and index is valid
  board[index] = current_player
end
def turn(board)
  index = -1
  while index < 0
  #print "Please enter 1-9:  "
  puts "Please enter 1-9:  "
    #input = gets.strip
    input = gets
    #puts ""
    index = input_to_index(input)
    if (index < 0)
      puts "Invalid entry.  #{input}"
      puts ""
    end
  end
  if valid_move?(board, index)
      player_move(board, index, 'X')
  else
    puts "Invalid move.  "
    turn(board)
  end
end
def get_input(token)
  print "Player #{token} select an unused cell:  [1-9]:  "
  input = gets.strip
  puts ""
  return input
end
def get_new_token(token)
  if token != 'X'
    return 'X'
  else
    return 'O'
  end
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
def won? (board)
  #for each row, column and diagnonal combination
  WIN_COMBINATIONS.each do | win_combination |
    #grab the winning combinaation of indices we are looking for
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

  #if we get here the board may be empty
  #if we get here the board may be filled, but no winning combos
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
def draw? (board)
  if !won?(board)              #returns true if no win
    if full?(board)            #but board is full
      return true
    end
  end
  return false
end
def over?(board)
    if won?(board) || draw?(board) || full?(board)
      return true
    else
      return false
    end
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
  count = 0
  board.each do |elt|
    if (elt == "X" || elt == "O")
      count = count + 1
    end
  end
  return count
end
