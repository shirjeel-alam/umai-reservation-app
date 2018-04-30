require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  setup do
    @restaurant = create(:restaurant)
    @tables = create_list(:table, 2, restaurant: @restaurant)
  end

  test 'validate name and shift timing' do
    shift = build(:shift, restaurant: @restaurant)

    shift.name = nil
    assert_not shift.valid?
    assert_equal "can't be blank", shift.errors[:name].first

    shift.name = 'Lunch'
    assert shift.valid?

    shift.end_at = 0
    assert_not shift.valid?
    assert_equal 'end time cannot be less than start time', shift.errors[:base].first

    shift.end_at = 54000
    assert shift.valid?
    assert shift.save
  end

  test 'convert time to seconds since midnight' do
    shift = Shift.new(name: 'Morning', start_time: '2018-01-01T09:00:00Z', end_time: '2018-01-01T013:00:00Z', restaurant: @restaurant)
    assert shift.valid?
    assert_equal 32400, shift.start_at
    assert_equal 46800, shift.end_at
  end
end
