class ReservationMailer < ApplicationMailer
  def send_guest_reservation_details(guest, reservation)
    @guest = guest
    @reservation = reservation

    mail(to: @guest.email, subject: "Reservation Details for #{@reservation.restaurant.name}")
  end

  def send_restaurant_reservation_details(guest, reservation)
    @guest = guest
    @reservation = reservation

    mail(to: @reservation.restaurant.email, subject: "Reservation Details for #{@guest.name}")
  end
end
