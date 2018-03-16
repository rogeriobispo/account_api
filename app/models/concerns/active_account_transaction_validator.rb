class ActiveAccountTransactionValidator < ActiveModel::Validator
  def validate(transaction)
    if account_check(transaction)
      transaction.errors.add(:active_account, 'only active account can create transactions')
    end
  end

  private

  def account_check(transaction)
    transaction.try(:origin_account).try(:blocked?) ||
    transaction.try(:origin_account).try(:canceled?) ||
    transaction.try(:destiny_account).try(:blocked?) ||
    transaction.try(:destiny_account).try(:canceled?)
  end
end
