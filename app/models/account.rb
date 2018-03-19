class Account < ApplicationRecord
  belongs_to :client
  has_many :account_relations
  has_many :parent_account, class_name: 'AccountRelation',
                            foreign_key: 'subsidiary_account_id'
  has_many :subsidiary_account, class_name: 'AccountRelation',
                                foreign_key: 'parent_account_id'
  has_many :account_transaction
  validates :status, :kind, :amount_holded, :client, presence: true
  enum kind: [:parent_account, :subsidiary_account]
  enum status: [:active, :blocked, :canceled]

  def debit(amount)
    self.amount_holded -= amount if debit_permited?(amount)
  end

  def credit(amount)
    self.amount_holded += amount
  end

  def debit_permited?(amount)
    true if self.amount_holded > amount
  end

  def next
    Account.where(id: subsidiary_account.all.pluck(:subsidiary_account_id))
  end

  def previous
    Account.where(id: parent_account.all.pluck(:parent_account_id))
  end
end
