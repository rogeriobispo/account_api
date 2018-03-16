class AccountRelation < ApplicationRecord
  belongs_to :above_ac, class_name: 'Account'
  belongs_to :below_ac, class_name: 'Account'
  validates :above_ac, :below_ac, presence: true
end
