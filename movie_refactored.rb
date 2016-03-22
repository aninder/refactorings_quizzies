class Movie
  attr_reader :title
  attr_accessor :movie_type

  def initialize(title, movie_type)
    @title, @movie_type = title, movie_type
  end

  def charge
    movie_type.charge
  end

  def frequent_renter_points(days_rented)
    movie_type.frequent_renter_points
  end
end

#object cannot change its class , movie can change its type , use state pattern!!
class RegularMoviePrice
  def charge(days_rented)
    result = 0
    result += 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
  end

  def frequent_renter_points(days_rented)
    1
  end
end

class NewReleaseMoviePrice
  def charge(days_rented)
    result = 0
    result += days_rented * 3
  end

  def frequent_renter_points(days_rented)
   days_rented > 1 ? 2 : 1
  end
end

class ChildrenMoviePrice
  def charge
    result = 0
    result += 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end

  def frequent_renter_points(days_rented)
    1
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def calculate_rent
    movie.charge(days_rented)
  end

  def frequent_renter_points
    movie.frequent_renter_points(days_rented)
  end
end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end
end

class Statement
  def self.prepare_statement(customer, output_format)
    total_amount = 0
    frequent_renter_points = 0
    customer.rentals.each do |element|
      frequent_renter_points += element.frequent_renter_points
      total_amount += element.calculate_rent
    end
    output_format.format(customer, total_amount, frequent_renter_points)
  end
end

class PlainTextResult
  def format customer, total_amount, frequent_renter_points
    @result = "Rental Record for #{customer.name}\n"
    @result += "Amount owed is #{total_amount}\n"
    @result += "You earned #{frequent_renter_points} frequent renter points"
  end

  def output
    @result
  end
end

class HtmlResult
  def format customer, total_amount, frequent_renter_points
    @result = "<b>Rental Record for #{customer.name}</b><br/>"
    @result += "<h1>Amount owed is #{total_amount}</h1></b>"
    @result += "<h3>You earned #{frequent_renter_points} frequent renter points</h3>"
  end

  def output
    @result
  end
end