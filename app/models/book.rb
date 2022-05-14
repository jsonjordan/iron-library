class Book < ActiveRecord::Base
  include PgSearch::Model

  multisearchable :against => [:title, :isbn, :author],
                                  :using => [#:tsearch => {:prefix => true, :any_word => true},
                                              #:trigram #,
                                              :dmetaphone
                                            ]

  validates_presence_of :isbn

  belongs_to :campus
  has_many :checkouts
  has_many :reviews
  has_many :reservations


end
