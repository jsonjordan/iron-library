class Reservation < ActiveRecord::Base

  validates_presence_of :book_id,
                        :user_id

  belongs_to :book
  belongs_to :user

end
