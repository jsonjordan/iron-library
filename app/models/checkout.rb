class Checkout < ActiveRecord::Base

  validates_presence_of :due_date,
                        :book_id,
                        :user_id

  belongs_to :book
  belongs_to :user

end
