class Table < ApplicationRecord
  belongs_to :restaurant

  validates :name, :minimum_capacity, :maximum_capacity, presence: true
  validates :minimum_capacity, :maximum_capacity, numericality: { only_integer: true, greater_than: 0 }
  validate :table_capacity, if: ->(t) { t.maximum_capacity.present? && t.minimum_capacity.present? }

  private

  def table_capacity
    errors.add(:maximum_capacity, 'cannot be less than minimum_capacity') if maximum_capacity < minimum_capacity
  end
end
