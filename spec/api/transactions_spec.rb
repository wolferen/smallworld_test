# frozen_string_literal: true

require 'swagger_helper'

describe 'Transactions Area', type: :request do
  path '/wallets/{wallet_id}/transactions' do
    post 'Create transaction' do
      tags 'Transactions Area'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: 'transaction[points]',
                in: :formData,
                type: :string,
                required: true

      parameter name: 'transaction[debit_wallet_id]',
                in: :formData,
                type: :string,
                required: true

      parameter name: 'transaction[timestamp]',
                in: :formData,
                type: :string,
                required: true

      parameter name: 'wallet_id', in: :path,
                required: true,
                schema: {
                  type: :string
                },
                description: 'wallet id (creditWalletId)'

      response '200', 'Transaction create' do
        before do
          Wallet.create
          Wallet.create
        end

        let(:wallet_id) { Wallet.first.id }
        let('transaction[points]') { 100 }
        let('transaction[timestamp]') { Time.now }
        let('transaction[debit_wallet_id]') { Wallet.last.id }
        run_test!
      end
    end
  end

  path '/wallets/{wallet_id}/transactions/spend_points' do
    post 'Create spend points transaction' do
      tags 'Transactions Area'
      consumes 'multipart/form-data'
      produces 'application/json'

      parameter name: 'transaction[points]',
                in: :formData,
                type: :string,
                required: true

      parameter name: 'transaction[timestamp]',
                in: :formData,
                type: :string,
                required: true

      parameter name: 'wallet_id', in: :path,
                required: true,
                schema: {
                  type: :string
                },
                description: 'wallet id (creditWalletId)'

      response '200', 'Transaction create' do
        before do
          Wallet.create
          Wallet.create
        end

        let(:wallet_id) { Wallet.first.id }
        let('transaction[points]') { 100 }
        let('transaction[timestamp]') { Time.now }
        run_test!
      end
    end
  end
end
