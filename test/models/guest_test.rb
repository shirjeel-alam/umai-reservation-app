require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test 'validate name and email' do
    guest = build(:guest)
    assert guest.valid?
    
    guest.name = nil
    assert_not guest.valid?
    assert_equal "can't be blank", guest.errors[:name].first

    guest.name = 'John Doe'
    assert guest.valid?

    guest.email = nil
    assert_not guest.valid?
    assert_equal "can't be blank", guest.errors[:email].first

    guest.email = 'example@umai.com'
    assert guest.valid?
    assert guest.save
  end

  test 'validate format of email' do
    guest = create(:guest)
    
    guest.email = 'email.example.com'
    assert_not guest.valid?
    assert_equal 'is invalid', guest.errors[:email].first
    
    guest.email = 'email@example.com'
    assert guest.valid?
  end
end
