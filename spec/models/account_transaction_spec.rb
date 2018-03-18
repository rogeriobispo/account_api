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
      ori_res = origin_amount + transaction_amount
      des_res = destiny_amount - transaction_amount
      expect(@account_transaction.origin_account.amount_holded).to eq(ori_res)

      expect(@account_transaction.destiny_account.amount_holded).to eq(des_res)
    end
  end

  context 'validations' do
    it 'destiny account is a parent_account' do
      par_account = create(:parent_account)
      transaction = AccountTransaction.new(false, destiny_account: par_account)
      transaction.valid?
      expect(transaction.errors).to include(:aport)
    end

    it 'only active account are able to transact' do
      bloc_account = create(:blocked_account)
      transaction = AccountTransaction.new(false, destiny_account: bloc_account)
      transaction.valid?
      expect(transaction.errors).to include(:active_account)
    end
  end
end
