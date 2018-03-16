class AddStatusToAccountTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :account_transactions, :status, :int, default: 0
  end
end
