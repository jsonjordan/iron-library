class Campus < ActiveRecord::Base

  validates_presence_of :street_address,
                        :city,
                        :state,
                        :zip_code,
                        :librarian

  validates_uniqueness_of :city

  has_many :users
  has_many :books
  has_many :purchase_requests
  has_many :checkouts, through: :users

end
