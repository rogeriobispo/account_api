class Transaction < ApplicationRecord
  belongs_to :account, foreign_key: 'origin_account_id'
  belongs_to :account, foreign_key: 'destiny_account_id'
  validates :origin_account_id, :destiny_account_id, :amount, presence: true
end
