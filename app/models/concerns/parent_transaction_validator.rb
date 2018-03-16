class ParentTransactionValidator < ActiveModel::Validator
  def validate(transaction)
    if transaction.destiny_account.kind == 'parent_account'
      transaction.errors.add(:aport, 'ParentAccount cannot receive transactions try an aport')
    end
  end
end
