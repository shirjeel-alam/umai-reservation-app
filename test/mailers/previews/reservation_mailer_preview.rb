# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def send_guest_reservation_details
    setup_reservation
    ReservationMailer.send_guest_reservation_details(@guest, @reservation)
  end

  def send_restaurant_reservation_details
    setup_reservation
    ReservationMailer.send_restaurant_reservation_details(@guest, @reservation)
  end

  private

  def setup_reservation
    restaurant = FactoryBot.create(:restaurant)
    table = FactoryBot.create(:table, restaurant: restaurant)
    shift = FactoryBot.create(:shift, restaurant: restaurant)

    @guest = FactoryBot.create(:guest)
    @reservation = FactoryBot.create(:reservation, restaurant: restaurant, table: table, shift: shift, guest: @guest, guest_count: 2, reservation_at: DateTime.parse('2018-05-02T10:00:00Z'))
  end
end
