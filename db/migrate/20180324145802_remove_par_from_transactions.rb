class RemoveParFromTransactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :par, :integer
  end
end
