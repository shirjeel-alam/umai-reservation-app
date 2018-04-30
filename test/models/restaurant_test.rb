require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test 'validate name and email' do
    restaurant = build(:restaurant)
    assert restaurant.valid?
    
    restaurant.name = nil
    assert_not restaurant.valid?
    assert_equal "can't be blank", restaurant.errors[:name].first

    restaurant.name = 'John Doe'
    assert restaurant.valid?

    restaurant.email = nil
    assert_not restaurant.valid?
    assert_equal "can't be blank", restaurant.errors[:email].first

    restaurant.email = 'example@umai.com'
    assert restaurant.valid?
    assert restaurant.save
  end

  test 'validate format of email' do
    restaurant = create(:restaurant)
    
    restaurant.email = 'email.example.com'
    assert_not restaurant.valid?
    assert_equal 'is invalid', restaurant.errors[:email].first
    
    restaurant.email = 'email@example.com'
    assert restaurant.valid?
  end

  test 'validate format of phone' do
    restaurant = create(:restaurant)
    
    restaurant.phone = 'foo'
    assert_not restaurant.valid?
    assert_equal 'is invalid', restaurant.errors[:phone].first
    
    restaurant.phone = '0191234567'
    assert restaurant.valid?
  end
end
