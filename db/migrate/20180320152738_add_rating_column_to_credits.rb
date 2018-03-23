class AddRatingColumnToCredits < ActiveRecord::Migration[5.1]
  def change
    add_column :credits, :rating, :string
  end
end
