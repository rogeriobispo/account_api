class AccountRelation < ApplicationRecord
  belongs_to :parent_account, class_name: 'Account',
                              foreign_key: 'parent_account_id'
  belongs_to :subsidiary_account, class_name: 'Account',
                                  foreign_key: 'subsidiary_account_id'
  validates :parent_account_id, :subsidiary_account_id, presence: true
end
