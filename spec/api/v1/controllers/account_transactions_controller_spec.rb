require 'rails_helper'

RSpec.describe Api::V1::AccountTransactionsController, type: :request do
  before do
    origin_account = create(:account)
    destiny_account = create(:account)
    @transaction_params = {
      account_transaction: {
        origin_account_id: origin_account.id,
        destiny_account_id: destiny_account.id,
        amount: '10'
      }
    }
  end

  describe 'post #create' do
    context 'with valid params' do
      it 'create an account_transaction' do
        post '/api/v1/account_transactions', params: @transaction_params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['id']).to eq(AccountTransaction.last.id)
      end
    end

    context 'with invalid params' do
      it 'returns erros invalid origin_account_id' do
        @transaction_params[:account_transaction][:origin_account_id] = 'A'
        post '/api/v1/account_transactions', params: @transaction_params
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'get #Revert' do
    context 'only reverte transaction' do
      it 'reverse the transaction ' do
        account_transaction = create(:account_transaction, amount: 10.0)
        account_transaction.origin_account.amount_holded = 100.00
        account_transaction.origin_account.save
        account_transaction.destiny_account.amount_holded = 90.00
        account_transaction.destiny_account.save
        get "/api/v1/account_transactions/#{account_transaction.id}/revert"
        account_transaction.reload
        expect(account_transaction.status).to eq('reverted')
      end
    end
  end

  describe 'put #Show' do
    it 'consult a transaction' do
      transaction = create(:account_transaction)
      get "/api/v1/account_transactions/#{transaction.id}"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(transaction.id)
      expect(parsed_response['amount'].to_f).to eql(transaction.amount.to_f)
    end
  end
end
