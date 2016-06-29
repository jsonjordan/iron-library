class PurchaseRequest < ActiveRecord::Base

  validates_presence_of :isbn,
                        :user_id,
                        :campus_id

  validates_uniqueness_of :isbn

  belongs_to :user
  belongs_to :campus

end
