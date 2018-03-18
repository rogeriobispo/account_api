require 'rails_helper'

RSpec.describe AportService, type: :service do
  before do
    origin_account = create(:account)
    destiny_account = create(:parent_account)
    ActionController::Parameters.permit_all_parameters = true
    @aport_params = ActionController::Parameters.new(
      account_transaction: {
        ac_transaction: {
          origin_account_id: origin_account.id,
          destiny_account_id: destiny_account.id,
          amount: '10'
        },
        aport: { code: SecureRandom.hex(15) }
      }
    )
  end

  describe '#call' do
    it 'create a aport' do
      aport = AportService.new(@aport_params[:account_transaction]).call
      expect(aport.class).to be(Aport)
    end
  end
end
