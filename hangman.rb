
MAX_NO_OF_STRIKES = 8

def get_valid_letter(used_letters)
  puts "Please enter a letter"
  valid_input = false
  while !valid_input
    user_input = gets.chomp.downcase
    if user_input.size > 1
      puts "Please enter one letter at a time"
      next
    end # checking the size
    if user_input.match(/[^A-Za-z]/)
      puts "#{user_input.chr} is not a letter"
      puts "Please enter a letter"
      next
    end # checking if letter
    letter_used = false
    used_letters.each do |letter|
      if letter.eql?(user_input)
        letter_used = true
      end # check used_letters
    end
    if letter_used == true
      puts "You have used this letter before"
      puts "Please enter another letter"
      next
    end
    # this is a valid letter, return it
    valid_input = true
    return user_input
  end # do loop
end # method

def mark_the_board(board_array, word, letter)
  word_letters = word.split(//)
  (0...word.size).each do |index|
    if word_letters[index].eql?(letter)
      board_array[index] = letter
    end
  end
  return board_array
end# mark_the_board

user_continues_playing = true
while user_continues_playing == true
  random_word = File.read("/usr/share/dict/words").split("\n").sample
  puts random_word

  number_of_strikes = 0
  the_board = Array.new(random_word.size, "_")
  input_letter = ""
  guessed_letters = []

  puts "Guess the word letter by letter"
  while number_of_strikes < (MAX_NO_OF_STRIKES + 1)
    the_board = mark_the_board(the_board, random_word, input_letter)
    puts the_board.join(" ")
    if !guessed_letters.empty?
      puts "Guessed letter #{guessed_letters.join("-")}"
      puts "number of guesses you have left is :"
      puts MAX_NO_OF_STRIKES - number_of_strikes
    end

    if !the_board.include?("_")
      puts "You have guessed the word correctly"
      break
    end

    input_letter = get_valid_letter(guessed_letters)
    guessed_letters << input_letter
    if !random_word.include?(input_letter)
      number_of_strikes += 1
    end
  end # guesses

  if number_of_strikes > MAX_NO_OF_STRIKES
    puts "You cannot have more than #{MAX_NO_OF_STRIKES} strikes"
    puts "The word is --- #{random_word} --- "
  end

  puts "Would you like to continue playing (Y/N)"
  if gets.upcase.chr == "N"
    user_continues_playing = false
    puts "Thanks for playing"
  end
 end #user_continues_playing
