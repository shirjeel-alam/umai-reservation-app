Dear <%= @guest.name %>,

Your reservation details are as follows:
- Restaurant: <%= @reservation.restaurant.name %>
- Reservation Time: <%= @reservation.reservation_at.to_s(:long) %>
- Table: <%= @reservation.table.name %>
  
Best Regards,
<%= @reservation.restaurant.name %>