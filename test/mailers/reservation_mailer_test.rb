require 'test_helper'

class ReservationMailerTest < ActionMailer::TestCase
  setup do
    @restaurant = create(:restaurant)
    @table = create(:table, restaurant: @restaurant)
    @shift = create(:shift, restaurant: @restaurant)
    @guest = create(:guest)
    @reservation = create(:reservation, restaurant: @restaurant, table: @table, shift: @shift, guest: @guest, guest_count: 2, reservation_at: DateTime.parse('2018-05-02T10:00:00Z'))
  end

  test 'send_guest_reservation_details' do
    email = ReservationMailer.send_guest_reservation_details(@guest, @reservation)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal ['reservations@umai.com'], email.from
    assert_equal [@guest.email], email.to
    assert_equal "Reservation Details for #{@restaurant.name}", email.subject
  end

  test 'send_restaurant_reservation_details' do
    email = ReservationMailer.send_restaurant_reservation_details(@guest, @reservation)
    assert_emails 1 do
      email.deliver_now
    end
    assert_equal ['reservations@umai.com'], email.from
    assert_equal [@restaurant.email], email.to
    assert_equal "Reservation Details for #{@guest.name}", email.subject
  end
end