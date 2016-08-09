class PurchaseRequest < ActiveRecord::Base

  validates_presence_of :isbn,
                        :user_id,
                        :campus_id,
                        :status

  belongs_to :user
  belongs_to :campus

end
