class AccountRelation < ApplicationRecord
  belongs_to :parent_account, class_name: 'Account'
  belongs_to :subsidiary_account, class_name: 'Account'
  validates :parent_account, :subsidiary_account, presence: true
end
