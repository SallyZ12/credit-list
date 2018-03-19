class Credits < ActiveRecord::Migration[5.1]
  def change
    create_table :credits do |t|
    t.string :credit_name
    t.string :sector
    t.integer :user_id
  end
end
end
