require 'rails_helper'

RSpec.describe Api::V1::AccountRelationsController, type: :request do
  before do
    origin_account = create(:account)
    destiny_account = create(:destiny_account)
    @account_relation_params = {
      account_relation: {
        parent_account_id: origin_account.id,
        subsidiary_account_id: destiny_account.id
      }
    }
  end

  describe 'post #create' do
    context 'with valid params' do
      it 'create an account_relation' do
        post '/api/v1/account_relations', params: @account_relation_params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response['id']).to eq(AccountRelation.last.id)
      end
    end

    context 'with invalid params' do
      it 'returns erros invalid origin_account_id' do
        @account_relation_params[:account_relation][:parent_account_id] = 'A'
        post '/api/v1/account_relations', params: @account_relation_params
        expect(response.status).to eq(422)
      end
    end

    describe 'delete #destroy' do
      context 'delete a relation' do
        it 'successfully' do
          relation = create(:account_relation)
          delete '/api/v1/account_relations', params: { id: relation.id }
          expect(response.status).to eq(200)
        end
      end
    end
  end
end
