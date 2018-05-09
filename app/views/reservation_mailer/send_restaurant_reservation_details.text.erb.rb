New reservation has been created

Guest details are as follows:
Name: <%= @guest.name %>
Email: <%= @guest.email %>

Reservation details are as follows:
Table: <%= @reservation.table.name %>
Shift: <%= "#{@reservation.shift.name} (#{@reservation.shift.start_at / 3600} - #{@reservation.shift.end_at / 3600})" %>
Reservation Time: <%= @reservation.reservation_at.to_s(:long) %>
Guest Count: <%= @reservation.guest_count %>