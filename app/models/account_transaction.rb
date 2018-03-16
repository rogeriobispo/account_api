class AccountTransaction < ApplicationRecord
  belongs_to :origin_account, class_name: 'Account',
                              foreign_key: 'origin_account_id'
  belongs_to :destiny_account, class_name: 'Account',
                               foreign_key: 'destiny_account_id'
  validates :origin_account_id, :destiny_account_id, :amount, presence: true
  enum status: [:created, :reverted]

  def reverse?
    perfom_reversion if able_to_reverse?
  end

  private

  def able_to_reverse?
    created? && destiny_account.debit_permited?(amount)
  end

  def perfom_reversion
    origin = destiny_account
    destiny = origin_account
    origin.debit(amount)
    destiny.credit(amount)
    new_transaction(origin, destiny, amount)
    reverted!
  end

  def new_transaction(origin, destiny, amount)
    AccountTransaction.create(origin_account: origin,
                              destiny_account: destiny,
                              amount: amount)
  end
end
