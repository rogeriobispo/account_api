class Account < ApplicationRecord
  belongs_to :person
  has_many :account_relations
  has_many :above_ac, class_name: 'AccountRelation', foreign_key: 'below_ac_id'
  has_many :below_ac, class_name: 'AccountRelation', foreign_key: 'above_ac_id'
  has_many :account_transaction
  validates :status, :kind, :amount_holded, :person, presence: true
  enum kind: [:parent_account, :subsidiary_account]
  enum status: [:active, :blocked, :canceled]
  def debit(amount)
    self.amount_holded -= amount if debit_permited?(amount)
  end

  def credit(amount)
    self.amount_holded += amount
  end

  def debit_permited?(amount)
    true if amount_holded > amount
  end

  def next
    Account.where(id: below_ac.all.pluck(:below_ac_id))
  end


  def previous
    Account.where(id: above_ac.all.pluck(:above_ac_id))
  end

  def relation_tree
  end
end
