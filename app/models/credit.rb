class Credit < ActiveRecord::Base

  belongs_to :user
  has_many :transactions

  validates :credit_name, :sector, :rating, presence: true

end
