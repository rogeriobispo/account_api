class ParentTransactionValidator < ActiveModel::Validator
  def validate(transaction)
    msg = 'ParentAccount cannot receive transactions try an aport'
    transaction.errors.add(:aport, msg) if check_par_transaction(transaction)
  end

  private

  def check_par_transaction(transaction)
    transaction.destiny_account.kind == 'parent_account' &&
      transaction.flag_aport == false
  end
end
