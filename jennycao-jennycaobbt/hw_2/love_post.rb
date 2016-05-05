require "pry"
require "colorize"

def evaluate(name)



  case

  when name.length <= 4
    puts "What kind of name is that short? No way!"
  when name.length > 4 && name.length < 15
    puts "Ohh... right balance of fancy and not too long, looks good!"
  when name.length >= 15
    puts "Ok, that's just freakish now..."
  else
    puts "what could you possibly have entered?"

  end

end


def get_response(love_interest)
  puts "Are you thining of #{love_interest}?"
  puts "Answer 'Yes' or 'No'"
  answer = gets.strip.downcase
  case answer
  when "yes"
    puts "Then go for it!".green
  when "no"
    puts "Then don't go for it...".red
  else
      puts "please enter a yes or no, nothing else! TRY AGAIN!".yellow
      get_response(love_interest)
  end

end


def capture_name
  #satisfied = false
  #until satisfied == true

    puts "What is your love interest's name?"
    answer = gets.strip
    if answer.include? "~"
      puts "What kind of name is #{answer}? TRY AGAIN!"
    else
      puts "Ok, it's #{answer}".yellow
      return answer
      #satisfied = true
    end
  #end
end

athing = "foo"

case
when athing.include? "d"
  puts "d"
when athing.include? "f"
  puts "f"
else
  puts "meh"
end



#get_response(capture_name)
