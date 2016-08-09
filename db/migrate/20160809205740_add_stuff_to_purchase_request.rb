class AddStuffToPurchaseRequest < ActiveRecord::Migration
  def change
    add_column :purchase_requests, :title, :string
    add_column :purchase_requests, :author, :string
  end
end
