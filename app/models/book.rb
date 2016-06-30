class Book < ActiveRecord::Base

  validates_presence_of :isbn

  validates_uniqueness_of :isbn

  belongs_to :campus
  has_many :checkouts
  has_many :reviews


end
