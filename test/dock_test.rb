require 'minitest/autorun'
require 'minitest/pride'
require './lib/dock'

class DockTest < Minitest::Test
  def test_it_exists
    dock = Dock.new("The Rowing Dock", 3)
    assert_instance_of Dock, dock
  end

  def test_dock_has_attributes
    dock = Dock.new("The Rowing Dock", 3)

    assert_equal "The Rowing Dock", dock.name
    assert_equal 3, dock.max_rental_time
  end

  def test_dock_starts_with_no_boats_rented
    dock = Dock.new("The Rowing Dock", 3)

    assert_equal [], dock.boats_rented
  end

  def test_dock_can_add_boats_to_boats_rented
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)

    dock.rent_out_boats(kayak_1)
    dock.rent_out_boats(kayak_2)

    assert_equal [kayak_1, kayak_2], dock.boats_rented
  end

  def test_dock_can_track_boat_rental_time
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")

    assert_equal 0, dock.rent(kayak_1, patrick)
  end

  def test_dock_can_log_hours
    dock = Dock.new("The Rowing Dock", 3)
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    canoe = Boat.new(:canoe, 25)

    dock.rent_out_boats(kayak_1)
    dock.rent_out_boats(kayak_2)
    dock.rent(kayak_1, patrick)
    dock.rent(kayak_2, patrick)
    dock.log_hour

    assert_equal 1, kayak_1.hours_rented
    assert_equal 1, kayak_2.hours_rented

    dock.rent_out_boats(canoe)
    dock.rent(canoe, patrick)
    dock.log_hour
    assert_equal 2, kayak_1.hours_rented
    assert_equal 2, kayak_2.hours_rented
    assert_equal 1, canoe.hours_rented
  end
end
