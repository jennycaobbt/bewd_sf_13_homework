require 'pry'
require 'pry-byebug'

#Add binding.pry anywhere to stop and examine code

def my_reverse(word)
  clean = word.strip.downcase
#  puts clean
  new_word = ""
  1.upto(clean.length) do |thing|
      new_word = new_word << clean[0-thing]
#      puts 0-thing
#      puts new_word
    end
    return new_word
end

def is_palend (word)
  if word.strip.downcase == my_reverse(word)
    puts "Yes, this is a Palendrome! You happy now?"
  else
    puts "Sorry... this is NOT a Palendrome"
  end
end

puts "Give me a word"
word = gets

is_palend(word)
