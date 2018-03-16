module Api
  module V1
    class AccountTransactionsController < ApiController
      before_action :set_account_transaction, only: [:destroy]
      def create
        acc_transaction = AccountTransaction.new(account_transaction_params)
        if acc_transaction.save
          render json: acc_transaction
        else
          render json: acc_transaction.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @account_transaction.created? && @account_transaction.reverse?
          render json: true
        else
          render json: { status: false,
                         message: 'without cash or already reverted' }
        end
      end

      private

      def account_transaction_params
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
