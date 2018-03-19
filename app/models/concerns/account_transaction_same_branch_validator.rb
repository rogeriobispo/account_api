class AccountTransactionSameBranchValidator < ActiveModel::Validator
  def validate(transaction)
    msg = 'Only account at same branch can create transactions'
    @transaction = transaction
    transaction.errors.add(:same_branch, msg) unless check_branch
  end

  private

  def check_branch
    relations = []
    relations = origin_account.all_relations if relations?
    true if relations.include?(destiny_account)
  end

  def relations?
    AccountRelation.where(parent_account: origin_account).any? ||
      AccountRelation.where(subsidiary_account: origin_account).any?
  end

  def origin_account
    @transaction.origin_account
  end

  def destiny_account
    @transaction.destiny_account
  end
end
