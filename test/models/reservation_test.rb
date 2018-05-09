require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  setup do
    @restaurant = create(:restaurant)
    @tables = create_list(:table, 2, restaurant: @restaurant)
    @shift = create(:shift, restaurant: @restaurant)
    @guests = create_list(:guest, 3)
  end

  test 'validations' do
    reservation = build(:reservation, restaurant: @restaurant, table: @tables[0], shift: @shift, guest: @guests[0], guest_count: 2, reservation_at: DateTime.parse('2018-05-02T10:00:00Z'))
    assert reservation.valid?

    reservation.guest_count = 99
    assert_not reservation.valid?
    assert_equal 'must be less than or equal to 10', reservation.errors[:guest_count].first

    reservation.guest_count = 2
    reservation.reservation_at = DateTime.parse('2018-05-02T16:00:00Z')
    assert_not reservation.valid?
    assert_equal 'does not lie within selected shift timings', reservation.errors[:reservation_at].first

    table = create(:table)
    reservation.reservation_at = DateTime.parse('2018-05-02T10:00:00Z')
    reservation.table = table
    assert_not reservation.valid?
    assert_equal 'table and shift must belong to same restaurant', reservation.errors[:base].first

    reservation.table = @tables[0]
    assert reservation.valid?
    assert reservation.save
  end

  test 'send emails after creation' do
    ActionMailer::Base.deliveries = []
    reservation = create(:reservation, restaurant: @restaurant, table: @tables[0], shift: @shift, guest: @guests[0], guest_count: 2, reservation_at: DateTime.parse('2018-05-02T10:00:00Z'))
    emails = ActionMailer::Base.deliveries
    assert_equal 2, emails.length
    assert_same_elements ['reservations@umai.com', 'reservations@umai.com'], emails.map(&:from).flatten
    assert_same_elements [@guests[0].email, @restaurant.email], emails.map(&:to).flatten
    assert_same_elements ["Reservation Details for #{@restaurant.name}", "Reservation Details for #{@guests[0].name}"], emails.map(&:subject).flatten
  end
end
