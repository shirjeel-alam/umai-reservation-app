json.extract! reservation, :id, :guest_count, :reservation_at, :created_at, :updated_at

json.restaurant do
  json.extract! reservation.restaurant, :id, :name, :email, :phone
end

json.table do
  json.extract! reservation.table, :id, :name, :minimum_capacity, :maximum_capacity
end

json.shift do
  json.extract! reservation.shift, :id, :name
  json.start_time Time.at(reservation.shift.start_at).utc.strftime('%I:%M%p')
  json.end_time Time.at(reservation.shift.end_at).utc.strftime('%I:%M%p')
end

json.guest do
  json.extract! reservation.guest, :id, :name, :email
end