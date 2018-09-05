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

  def rent_out_boats(boat)
    @boats_rented << boat
  end

  def rent(boat, renter)
    boat.hours_rented
  end

  def log_hour
    boats_rented.each do |boat|
      boat.add_hour
    end
  end
end
