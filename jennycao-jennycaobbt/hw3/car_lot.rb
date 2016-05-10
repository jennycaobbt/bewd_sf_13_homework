require 'pry'
require 'pry-byebug'
#require 'colorize'

#---------------------------Supporting Methods-----------------------------
#Supporting methods are methods that are or has the potential to be used multiple times, and can be seperated logically from what it's being used for.


#YES OR NO METHOD
#This method simplify asking yes/no questions.
#It will take the question you want to ask as an argument, and ask this question until a valid answer is given.
#It will then return true if the answer was yes, and false if the answer was no.

def yes_no (question)
  puts question
  answer = gets.strip.downcase
  if answer == "yes"
    return true
  elsif answer == "no"
    return false
  else
    puts "Sorry, that's an invalid answer. Please enter 'yes' or 'no'"
    yes_no(question)
  end
end

#COLOR INVENOTRY Method
#This method will add all colors on car lot to an array of avaible colors for user to choose from
def color_inventory(car_lot)
  available_colors = []
  car_lot.each do |car|
    available_colors.push(car[:color])
  end
  return available_colors
end


#PRINT LIST method
#This method will take an array of cars (hashes), and print each of the car's information in a easy to read format.

def print_list(list)

list.each do |item|
  puts "ID: #{item[:ID]}"
  puts "Make: #{item[:name]}"
  puts "Model: #{item[:model]}"
  puts "Year: #{item[:year]}"
  puts "Price $#{item[:price]}"
  puts "Color: #{item[:color]}"
  if item[:is_electric] == true
    puts "Fuel: Electric"
  elsif item[:is_electric] == false
    puts "Fuel: Gasoline"
  else
    puts "ERROR!!!!!" #unless our inventory of cars has an error, this should never appear
  end
  puts " " #puts a free line for spacing purposes.
  end
end



#SELECT CAR BY ID
#This takes in an ID (integer) and a list of cars, and returns the car (hash) associated with that ID.
def select_car_by_id(id, cars)
  cars.each do |car|
    if car[:ID] == id
      return car
    end
  end
end

#---------------------------Supporting Methods-----------------------------









#---------------------------Retrive Information-----------------------------
#These are methods that's used to gather criteria information from the user at the beginning.

#GET YEAR
#This makes useres enter a valid year (greater than 0 but less than the 2018 since that's not made yet)
def get_year
  puts "What is the lowest year?"
  lowest_year = gets.strip.to_i

  if lowest_year <= 0 || lowest_year >2018
    puts "very funny, that's not a valid year"
    get_year
  else
    puts "Great! We will only show you cars that are made on or after #{lowest_year}"
    return lowest_year
  end
end



#GET PRICE
#This grabs the price ceiling the user is willing to pay, can't be less or equal to 0

def get_price

  puts "What is your price ceiling?"
  price_ceiling = gets.strip.to_i

  if price_ceiling <= 0
    puts "very funny, that's not a valid price"
    get_price
  else
    puts "Great! We will only show you cars that cost less than $#{price_ceiling}"
    return price_ceiling
  end

end



#IS_ELECTRIC
#This gets the fueling preference from the user, they can choose to only see electric cars, gasoline, or both.

def is_electric

  puts "How do you want your car fueled?"
  puts "electric/gasoline/don't care"

  fuel_option = gets.strip.downcase

  case fuel_option
  when "electric"
    puts "Great! We'll only pick out electric cars for you!"
    return "electric"
  when "gasoline"
    puts "Great! We'll only pick out gasoline based cars for you!"
    return "gasoline"
  when "don't care"
    puts "Not picky I see... noted, we'll show you both kinds of cars then."
    return "both"
  else
    puts "Sorry, I don't understand you, please type in a valid answer"
    is_electric
  end
end

#COLOR CHECKER Method
#This method checks to see if the user cares about color or not when selecting a car

def color_checker(car_lot)
  puts "Do you have a specific color in mind? (Yes/No)"
  specific_color = gets.strip.downcase
  available_colors = color_inventory(car_lot)
  color_choices = []    #users color preferences
    if specific_color == "yes"
      color_chooser(car_lot, available_colors, color_choices)
    elsif specific_color == "no"
      puts "I guess you dont care about color"
      return available_colors #if user doesnt care about colors, return an array of all available colors
    else
      puts "Invalid Response"
      color_checker(car_lot)
    end
end

#COLOR CHOOSER Method
#This method captures the users color choice and stores it in an array.

def color_chooser(car_lot, available_colors, color_choices)
    puts "Please select your color choice from the available options below:"
    puts available_colors
    color_selection = gets.strip.downcase
        if available_colors.include?(color_selection)   #test to see if valid color
            color_choices.push(color_selection)     #add users selection to list of their prefences
            available_colors.delete(color_selection) #remove already selected color from available colors
            additional_colors(car_lot, available_colors, color_choices) #see if they want other colors to choose from
        else
            puts "Sorry we don't have that color in our inventory"
            color_chooser(car_lot, available_colors, color_choices) #if invalid color recall function to ask for what color they want
        end
end

#ADDITIONAL COLORS
#This method asks the user if they want to add more colors to their preferences, if yes it will recall color_chooser

def additional_colors(car_lot, available_colors, color_choices)
    if available_colors == []
        puts  "You have selected all of the available colors from the lot, here are your choices:"
        puts color_choices
        return color_choices
    else
      puts "Are there any other colors you have in mind besides the colors listed below: (Yes/No)"
            color_choices.each do |color|  #list colors they have already selected
              puts color
            end
            more_colors = gets.strip.downcase
            if more_colors == "yes"
              color_chooser(car_lot, available_colors, color_choices)
            elsif more_colors == "no"
              puts "Lets find you your car based on your preferences"
              return color_choices
            else
              puts "Invalid response"
              additional_colors(car_lot, available_colors, color_choices)
            end
    end
end

#---------------------------Retrive Information-----------------------------







#---------------------------------Matching---------------------------------
#These methods are related to the function of matching available cars based on the user's criteria and preferences.


#MATCH
#This method takes a hash of user criteria gathered, as well as the array of all the cars. #It then extrat the information from then and call a bunch of matching methods to obtain arrays of cars that match the criteria that the users put.

def match (user_criteria, car_lot)
  year = user_criteria[:lowest_year]
  price = user_criteria[:price]
  preference = user_criteria[:electric_pref]
  colors = user_criteria[:colors]

  #obtains all cars that satisfy the year/price/elec/color criteria
  all_matches_year =  match_year(year, car_lot)
  all_matches_price = match_price(price, car_lot)
  all_matches_elec = match_electric(preference, car_lot)
  all_matches_color= match_color(colors, car_lot)

  puts "...... searching........"
  sleep(0.5)
  puts "...... searching........"
  sleep(0.5)
  puts "...... searching........"
  sleep(0.5)

  #calls the intersec method to get an array of cars that satify all criteria
  all = intersec(all_matches_year, all_matches_price, all_matches_elec, all_matches_color, all_matches_color, "none")

  #Displays the mached cars to the user
  puts "There are #{all.length} cars that matches your criteria."
  print_list(all)

  #This checks to see if there are any cars at all, if so we will ask the user to buy one, if not it calls the sales department method to try to find some flexibility in the user's preferences.
  if all.length == 0
    sales_department(all_matches_year, all_matches_price, all_matches_elec, all_matches_color, car_lot)
  else
    sale_status = ask_for_sale(all) #ask for sale will return if a sale is made or not

    if sale_status == "sale"
      puts "Thanks for shopping!"
    elsif sale_status == "no sale"
      sales_department(all_matches_year, all_matches_price, all_matches_elec, all_matches_color, car_lot)

    else
      puts "ERROR!!!" #this should never happen, if it does there's a problem in the code
    end
  end

end





#FLEX MATCH
#This method is used to determine if the user has any flexibility in their criteria
#It will ask a series of questions about the user's flexibility and then call the intersec method to get an array of matched cars with the new flexibility in mind.
def flex_match(year, price, elec, color, car_lot)
  flex_color = yes_no("Do you have any flexiblity in the color of the car?")
  flex_elec = yes_no("What about the fuel source?")
  flex_year = yes_no("Do you have flexiblity on the year the car was made?")
  flex_price = yes_no("Finally, do you have any flexibility on price?")


  #The intersec method will take a flex parameter, which it will use to modify its output of the cars that fits the user's crteria based on any flexibility.
  #The following if statements are building that flex parameter which is an array of qualities that the user is flexibile with.
  flex = []
  if flex_color == true
    flex.push("color")
  end

  if flex_elec == true
    flex.push("elec")
  end

  if flex_price == true
    flex.push("price")
  end

  if flex_year == true
    flex.push("year")
  end

  #This calls the intersec method while passing in the flex array we just built.
  new_match = intersec(year, price, elec, color, car_lot, flex)
  puts "Here are some new matches based on your flexibility:"
  print_list(new_match)
  return new_match

end



#INTERSEC
#The intersec method takes in a series of arrays (of cars) and find the intersection of them (cars that appear in all arrays) to output an array of cars that fits all of the user's criteria.
#It has a flex feature, where it will take in an array of features the user is flexible with, and will disregard those features while finding the match.


#The way the flex feature works is by replacing a feature, like color, with all, which is a list of all cars in the inventory. This will make it so that the method thinks the user is ok with all colors.
def intersec (year, price, elec, color, all, flex)
  if flex.include? "color"
    color = all #replacing color, a list of cars that satisfy the user's color criteria. with the entire inventory of cars so that this feature is disregarded in the match.
  end

  if flex.include? "elec"
    elec = all
  end

  if flex.include? "price"
    price = all
  end

  if flex.include? "year"
    year = all
  end

  intersec = year & price & elec & color #finding the intersection of all these arrays.

end



#MATCH YEAR
#This method outputs an array of cars that matches the user's year preferences.
def match_year (year, car_lot)
  valid_cars = []
  car_lot.each do |car|
    if car[:year]>=year
      valid_cars.push(car)
    end
  end
  return valid_cars
end

#MATCH PRICE
#This method outputs an array of cars that matches the user's price preferences.
def match_price (price, car_lot)
  valid_cars = []
  car_lot.each do |car|
    if car[:price] <= price
      valid_cars.push(car)
    end
  end
  return valid_cars
end

#MATCH ELECTRIC
#This method outputs an array of cars that matches the user's fuel preferences.
def match_electric (preference, car_lot)
  valid_cars=[]
  case preference
  when "electric"
    car_lot.each do |car|
      if car[:is_electric] == true
        valid_cars.push(car)
      end
    end
    return valid_cars
  when "gasoline"
    car_lot.each do |car|
      if car[:is_electric] == false
        valid_cars.push(car)
      end
    end
    return valid_cars
  when "both"
    return car_lot
  else
    puts "else"
  end

end


#MATCH COLOR
#This method outputs an array of cars that matches the user's color preferences.
def match_color (colors, car_lot)
  valid_cars = []
  car_lot.each do |car|
    if colors.include?(car[:color])
      valid_cars.push(car)
    end
  end
  return valid_cars
end


#---------------------------------Matching---------------------------------





#----------------------------------Sales----------------------------------
#These methods are related to the selling function after the cars are matched.



#ASK FOR SALE
#This method asks if the user would like to buy a car after a list of matched cars for the user is generated. It will return if the sale is made.

def ask_for_sale(cars)

  buy_decision = yes_no("Would you like to buy one of these cars? (yes/no)")

  if buy_decision == true
      return get_id(cars) #does not return sale because there is a final confirmation in the get_id method.

  else
    return "no sale"

  end
end



#GET ID
#This method will ask you for the ID of the car you want to buy and sell it to you. It will return if a sale is made or not by returning "sale" or "no sale"
def get_id(cars)
  car_ids = []
  cars.each do |car|
    car_ids.push(car[:ID])
  end
  puts "Please enter the ID associated with your purchase:"
  id = gets.strip.to_i


  if car_ids.include?(id)

    the_car = select_car_by_id(id, cars)

    if the_car[:is_electric] == true
      fuel = "electric"
    else
      fuel = "gasoline"
    end

    puts "So the #{the_car[:color]} #{the_car[:name]} #{the_car[:model]} using #{fuel} fuel?"
    puts "That will be $#{the_car[:price]} please!"
    final_confirm = yes_no("Are you sure you want to buy this car? (yes/no)")

    if final_confirm == true
      puts "Thanks you for buying the #{the_car[:color]} #{the_car[:name]} #{the_car[:model]} using #{fuel} fuel!"
      puts "I am now $#{the_car[:price]} richer!"
      return "sale"
    else
      puts "oh... ok then... (I was so close!!!! T_T)"
      return "no sale"
    end
  else
    puts "Sorry, that's not a valid ID."
    get_id(cars)
  end
end



#SALES DEPARTMENT
#This will ask the user if they're willing to accept flexibility in their criteria, and will call the appropriate methods if the user agrees.
def sales_department(year, price, elec, color, car_lot)
  puts "Wait! We might have more matches for you if you have a little flexibiilty in your criteria!"
  try_more = yes_no("Do you want to keep looking for cars?")

  if try_more == true
    new_match = flex_match(year, price, elec, color, car_lot)
    if new_match.length > 0
      ask_for_sale(new_match)
    else
      puts "We can't find any new matches for you."
      sales_department(year, price, elec, color, car_lot)
    end
  else
    puts "Alright, thanks anyways.... I guess.... "
  end

end

#----------------------------------Sales----------------------------------




#------------------------------Body of the code------------------------------

#setting up the inventory.
car_lot = []
tesla = {ID: 1001,name: "Tesla", model: "Model X", year: 2017, is_electric: true, price: 45000, color: "black"}
jeep = {ID: 1002,name: "Jeep", model: "Grand Cherokee", year: 2004, is_electric: false, price: 37000, color: "white"}
porsche = {ID: 1003,name: "Porsche", model: "Speedster", year: 1955, is_electric: false, price: 65000, color: "yellow"}
ford = {ID: 1004,name: "Ford", model: "Fusion", year: 2003, is_electric: false, price: 18000, color: "red"}
toyota = {ID: 1005, name: "Toyota", model: "Prius", year: 2010, is_electric: true, price: 24000, color: "silver"}
batmobile = {ID: 1006, name: "Batmobile", model: "BAT9000", year: 2017, is_electric: true, price: 250000, color: "black"}
flintmobile = {ID: 1007, name: "Flintmobile", model: "RockWagon", year: 400, is_electric: false, price: 30, color: "red"}
nimbus = {ID: 1008, name: "Nimbus", model: "Nimbus 2000", year: 1991, is_electric: false, price: 500, color: "orange"}
honda = {ID: 1009, name: "Honda", model: "Civic", year: 2006, is_electric: true, price: 27000, color: "silver"}
generallee = {ID: 1010, name: "General Lee", model: "Charger", year: 1969, is_electric: false, price: 18000, color: "orange"}
bmw = {ID: 1011, name: "BMW", model: "M3", year: 1993, is_electric: false, price: 35000, color: "white"}

#Code technically starts here.
car_lot.push(tesla, jeep, porsche, ford, toyota, batmobile, flintmobile, nimbus, honda, generallee, bmw)

user_criteria = {}

puts "Please enter your criteria"
user_criteria[:lowest_year] = get_year
user_criteria[:price] = get_price
user_criteria[:electric_pref] = is_electric
user_criteria[:colors] = color_checker(car_lot)

match(user_criteria, car_lot)

#-----------------------------Body of the code end----------------------------
