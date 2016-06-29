class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :slack_name,
                        :gmail_id,
                        :type,
                        :klass,
                        :campus_id

  validates_uniqueness_of :slack_name, scope: :campus_id

  validates_uniqueness_of :gmail_id

  belongs_to :campus
  has_many :checkouts
  has_many :purchase_requests
end
