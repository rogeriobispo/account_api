module Api
  module V1
    class AccountsController < ApiController
      before_action :set_account, only: [:show, :update]
      def create
        @account = Account.new(account_params)
        if @account.save
          render json: @account
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: @account
      end

      def update
        if @account.update(account_params)
          render json: @account
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      private

      def account_params
        params.require(:account).permit(:status,
                                        :kind,
                                        :client_id, :amount_holded)
      end

      def set_account
        @account = Account.find(params['id'])
      end
    end
  end
end
