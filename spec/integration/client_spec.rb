require 'swagger_helper'

describe 'Account API' do
  path '/api/v1/clients/{id}' do
    get 'retrieve a cliente' do
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Client found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            cpf: { type: :string },
            birthdate: { type: :date_time }
          },

          required: ['id', 'name', 'cpf', 'birthdate']

          let(:id) { create(:client, :phy_person).id}
          run_test!
      end

      response '404', 'client not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
