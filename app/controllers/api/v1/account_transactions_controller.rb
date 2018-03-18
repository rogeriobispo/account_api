module Api
  module V1
    class AccountTransactionsController < ApiController
      before_action :set_account_transaction, only: [:destroy, :revert, :show]
      def create
        acc_transaction = AccountTransaction.new(false, ac_transaction_params)
        if acc_transaction.save
          render json: acc_transaction
        else
          render json: acc_transaction.errors, status: :unprocessable_entity
        end
      end

      def revert
        if @account_transaction.created? && @account_transaction.reverse?
          render json: @account_transaction
        else
          msg = 'Reversion failed account cash missing or accout desabled'
          render json: { status: false, message: msg }
        end
      end

      def show
        render json: @account_transaction if @account_transaction
      end

      private

      def ac_transaction_params
        params.require(:account_transaction).permit(:origin_account_id,
                                                    :destiny_account_id,
                                                    :amount)
      end

      def set_account_transaction
        @account_transaction = AccountTransaction.find(params[:id])
      end
    end
  end
end
