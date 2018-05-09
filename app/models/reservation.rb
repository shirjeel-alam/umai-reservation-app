class Reservation < ApplicationRecord
  belongs_to :restaurant
  belongs_to :table
  belongs_to :shift
  belongs_to :guest

  validates :guest_count, :reservation_at, presence: true
  validates_numericality_of :guest_count, :greater_than_or_equal_to => :table_minimum, :less_than_or_equal_to => :table_maximum

  validate :reservation_at_lies_in_shift, if: ->(r) { r.reservation_at.present? && r.shift.present? && (r.reservation_at_changed? || r.shift_id_changed?) }
  validate :table_and_shift_belong_to_same_restaurant, if: ->(r) { r.table.present? && r.shift.present? && (r.table_id_changed? || r.shift_id_changed?) }

  after_create_commit :send_emails

  def table_minimum
    table.minimum_capacity
  end

  def table_maximum
    table.maximum_capacity
  end

  private

  def send_emails
    ReservationMailer.send_guest_reservation_details(guest, self).deliver_now
    ReservationMailer.send_restaurant_reservation_details(guest, self).deliver_now
  end

  def reservation_at_lies_in_shift
    seconds_since_midnight = reservation_at.to_i % 86400
    errors.add(:reservation_at, 'does not lie within selected shift timings') if shift.start_at > seconds_since_midnight || shift.end_at < seconds_since_midnight
  end

  def table_and_shift_belong_to_same_restaurant
    errors.add(:base, 'table and shift must belong to same restaurant') unless table.restaurant_id == shift.restaurant_id
  end
end
