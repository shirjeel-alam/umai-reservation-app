class Restaurant < ApplicationRecord
  validates :name, :email, :phone, presence: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, if: :email_changed?
  validates_format_of :phone, with: /(\+?6?01)[0-46-9]-*[0-9]{7,8}/, if: :phone_changed?

  has_many :shifts, dependent: :delete_all
  has_many :tables, dependent: :delete_all
  has_many :reservations, dependent: :delete_all
end
