class Aport < ApplicationRecord
  belongs_to :account_transaction
  validates :code, :account_transaction, presence: true
end
