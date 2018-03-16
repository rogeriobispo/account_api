class Account < ApplicationRecord
  belongs_to :person
  has_many :account_relation
  has_many :account_transaction
  validates :status, :kind, :amount_holded, :person, presence: true

  def debit(amount)
    self.amount_holded -= amount if debit_permited?(amount)
  end

  def credit(amount)
    self.amount_holded += amount
  end

  def debit_permited?(amount)
    true if amount_holded > amount
  end
end
