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

  def all_relations
    relations = []
    relations << above_relations
    relations << below_relations
    relations.flatten!
    relations.uniq!
  end

  private

  def below_relations
    accounts_relateds = []
    current = self
    accounts_relateds << current
    current = current.next
    while current.count.positive?
      current.each do |c|
        accounts_relateds << c
      end
      current = current.first.next
    end
    accounts_relateds
  end

  def above_relations
    accounts_relateds = []
    current = self
    accounts_relateds << current
    current = current.previous
    while current.count.positive?
      current.each do |c|
        accounts_relateds << c
      end
      current = current.first.previous
    end
    accounts_relateds
  end
end
