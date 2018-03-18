class AportService
  def initialize(aport_params)
    @aport_params = aport_params
  end

  def call
    aport_create
  end

  private

  def create_transaction
    at = AccountTransaction.new(true, @aport_params['ac_transaction'])
    if at.valid?
      at.save
      at.reload
    end
  end

  def aport_code
    @aport_params['aport']['code']
  end

  def aport_create
    Aport.create(code: aport_code, account_transaction: create_transaction)
  end
end
