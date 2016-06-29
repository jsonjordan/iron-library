class Book < ActiveRecord::Base

  validates_presence_of :title,
                        :author,
                        :year_of_publication,
                        :status,
                        :campus_id,
                        :isbn

  validates_uniqueness_of :isbn

  belongs_to :campus
  has_many :checkouts
  has_many :reviews


end
