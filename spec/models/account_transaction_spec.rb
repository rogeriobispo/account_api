require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  before :each do
    @account_transaction = create(:created_account_transaction, amount: 10.0)
  end

  describe '#reverse' do
    it 'reverses all the transaction' do
      @account_transaction.reverse?
      expect(@account_transaction.status).to eq('reverted')
    end

    it 'returns false when transaction already reverted' do
      @account_transaction.reverse?
      expect(@account_transaction.reverse?).to be_falsy
    end

    it 'reverse values of transaction' do
      transaction_amount = @account_transaction.amount
      origin_amount = @account_transaction.origin_account.amount_holded
      destiny_amount = @account_transaction.destiny_account.amount_holded
      @account_transaction.reverse?

      expect(@account_transaction.origin_account.amount_holded).to eq(origin_amount + transaction_amount)

      expect(@account_transaction.destiny_account.amount_holded).to eq(destiny_amount - transaction_amount)
    end
  end

  context 'validations' do
    it 'destiny account is a parent_account' do
      parent_account = create(:parent_account)
      transaction = AccountTransaction.new(destiny_account: parent_account)
      transaction.valid?
      expect(transaction.errors).to include(:aport)
    end

    it 'only active account are able to transact' do
      blocked_account = create(:blocked_account)

      transaction = AccountTransaction.new(destiny_account: blocked_account)
      transaction.valid?
      expect(transaction.errors).to include(:active_account)

    end
  end
end
