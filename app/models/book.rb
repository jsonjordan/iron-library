class Book < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search_by_all, :against => [:title, :isbn, :author],
                                  :using => [:tsearch, :trigram, :dmetaphone]

  validates_presence_of :isbn

  belongs_to :campus
  has_many :checkouts
  has_many :reviews
  has_many :reservations


end
