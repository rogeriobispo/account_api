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
end
