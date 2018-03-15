class Account < ApplicationRecord
  belongs_to :person
  validates :status, :kind, :person, :amount_holded, presence: true
end
