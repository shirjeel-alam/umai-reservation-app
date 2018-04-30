class Guest < ApplicationRecord
  validates :name, :email, presence: true
  validates_uniqueness_of :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, if: :email_changed?

  has_many :reservations
end
