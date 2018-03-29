class Transaction < ActiveRecord::Base

  belongs_to :credit

    validates :name, :series, presence: true

end
