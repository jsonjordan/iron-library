class Review < ActiveRecord::Base

  validates_presence_of :book_id,
                        :content

  belongs_to :book
  belongs_to :user

end
