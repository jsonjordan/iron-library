class PurchaseRequest < ActiveRecord::Base

  belongs_to :user
  belongs_to :campus

end
