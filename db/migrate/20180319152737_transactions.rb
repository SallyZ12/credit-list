class Transactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :name
      t.string :series
      t.integer :par
      t.integer :credit_id
    end
  end
end
