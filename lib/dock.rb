require './lib/boat'
require './lib/renter'

class Dock
  attr_reader :name,
              :max_rental_time,
              :boats_rented

  def initialize (name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @boats_rented = []
  end

  def rent(boat, renter)
    @boats_rented << boat
    boat.hours_rented
  end

  def log_hour
    boats_rented.each do |boat|
      boat.add_hour
    end
  end

  def return(boat)
    boats_rented.delete(boat)
  end

  def revenue
    @boats_rented.sum do |boat|
      boat.price_per_hour * boat.hours_rented
    end
  end
end
