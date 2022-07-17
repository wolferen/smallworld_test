# frozen_string_literal: true

require 'swagger_helper'

describe 'Wallets Area', type: :request do
  path '/wallets' do
    post 'Create wallet' do
      tags 'Wallets Area'
      consumes 'application/json'

      response '200', 'Wallet created' do
        run_test!
      end
    end

    get 'Get all wallets' do
      tags 'Wallets Area'
      consumes 'application/json'

      response '200', 'Wallet index' do
        run_test!
      end
    end
  end

  path '/wallets/{id}' do
    get 'Get wallet' do
      tags 'Wallets Area'
      consumes 'application/json'

      parameter name: 'id', in: :path,
                required: true,
                schema: {
                  type: :string
                },
                description: 'wallet id'

      response '200', 'Wallet show' do
        before do
          Wallet.create
        end

        let(:id) { Wallet.last.id }
        run_test!
      end
    end
  end
end
