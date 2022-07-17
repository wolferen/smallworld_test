class WalletsController < ApplicationController
  before_action :set_wallet, only: :show

  # GET /wallets
  def index
    wallets = Wallet.all

    render json: ::WalletsSerializer.new(wallets)
  end

  # GET /wallets/1
  def show
    render json: ::WalletSerializer.new(@wallet)
  end

  # POST /wallets
  def create
    @wallet = Wallet.new

    if @wallet.save
      render json: ::WalletSerializer.new(@wallet)
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_wallet
    @wallet = Wallet.find(params[:id])
  end
end
