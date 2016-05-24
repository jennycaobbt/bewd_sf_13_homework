require 'pry'
require 'pry-byebug'

#create an apartment class using OOP principles

#camel case.
class Apartment
  attr_accessor :name, :price, :neighborhood, :url, :date

  def initialize (price, neighborhood, name, url, date)
    @price = price
    @neighborhood = neighborhood
    @name = name
    @url = url
    @date = date
  end

  def recommend
    if neighborhood.include?("SOMA")
      return "YES"
    elsif neighborhood.include?("tenderloin")
      return "NO"
    else
      return "N/A"
    end
  end

  def self.average_price(array)
    price_total = 0
    array.each do |apartment|
      string_price = apartment.price
      price_total += string_price[1..-1].to_i
      #binding.pry
    end

    return price_total/array.length
  end
end
