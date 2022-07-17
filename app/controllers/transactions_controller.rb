class TransactionsController < ApplicationController
  before_action :set_wallet

  # POST /transactions
  def create
    transaction = @wallet.transactions.new(transaction_params)

    if transaction.save
      render json: ::TransactionSerializer.new(transaction)
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end

  def spend_points
    transaction = @wallet.transactions
                         .new(system_transaction_params.merge!(debit_wallet_id: Wallet.system.first.id))

    if transaction.save
      render json: ::TransactionSerializer.new(transaction)
    else
      render json: transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def set_wallet
    @wallet = Wallet.find(params[:wallet_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = @wallet.transactions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:points,
                                        :debit_wallet_id,
                                        :wallet_id,
                                        :timestamp)
  end

  def system_transaction_params
    params.require(:transaction).permit(:points,
                                        :wallet_id,
                                        :timestamp)
  end
end
