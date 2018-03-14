class AccountRelation < ApplicationRecord
  belongs_to :account, foreign_key: 'parent_account_id'
  belongs_to :account, foreign_key: 'subsidiary_account_id'
end
