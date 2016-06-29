class Campus < ActiveRecord::Base

  has_many :users
  has_many :books
  has_many :purchase_requests

end
