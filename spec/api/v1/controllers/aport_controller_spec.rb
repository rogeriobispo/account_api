require 'rails_helper'

RSpec.describe Api::V1::AportController, type: :request do
  before do
    origin_account = create(:account)
    destiny_account = create(:parent_account)
    @aport_params = {
      account_transaction: {
        ac_transaction: {
          origin_account_id: origin_account.id,
          destiny_account_id: destiny_account.id,
          amount: '10'
        },
        aport: { code: SecureRandom.hex(15) }
      }
    }

    @invalid_aport_params = {
      account_transaction: {
        ac_transaction: {
          origin_account_id: 'invalid account',
          destiny_account_id: destiny_account.id,
          amount: '10'
        },
        aport: { code: SecureRandom.hex(15) }
      }
    }
  end

  describe 'post #create' do
    context 'with valid params' do
      it 'create an aport' do
        post '/api/v1/aport', params: @aport_params
        parsed_response = JSON.parse(response.body)
        lid = AccountTransaction.last.id
        expect(parsed_response['transaction']['id']). to eq(lid)
      end
    end

    context 'with invalid params' do
      it 'returns erros invalid origin_account_id' do
        post '/api/v1/aport', params: @invalid_aport_params
        expect(response.status).to eq(422)
      end
    end

    describe 'put #show' do
      it 'consult a aportTransaction' do
        aport = create(:aport)
        get "/api/v1/aport/#{aport.id}"
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['aport']['code']).to eq(aport.code)
      end
    end

    describe 'post #revert' do
      it 'revert transaction successefuly' do
        aport = create(:aport)
        aport.account_transaction.origin_account.amount_holded = 100.00
        aport.account_transaction.origin_account.save
        aport.account_transaction.destiny_account.amount_holded = 90.00
        aport.account_transaction.destiny_account.save
        post '/api/v1/aport/revert', params: { code: aport.code }
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['aport']['code']).to eq(aport.code)
        expect(parsed_response['transaction']['status']).to eq('reverted')
      end

      it 'revert transaction when code inesistente' do
        unkowncode = SecureRandom.hex(15)
        post '/api/v1/aport/revert', params: { code: unkowncode }
        expect(response.status).to eq(422)
      end
    end
  end
end
