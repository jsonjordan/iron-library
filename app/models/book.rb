class Book < ActiveRecord::Base

  belongs_to :campus
  has_many :checkouts
  has_many :reviews
  

end
