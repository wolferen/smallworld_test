class Transaction < ApplicationRecord
  belongs_to :wallet

  enum status: %i[processing finished system]

  validate :positive_balance, if: :processing?

  def positive_balance
    errors.add(:wallet, 'insufficient funds') if wallet.balance < points
  end

  after_create :process_transaction, if: :processing?

  def process_transaction
    transactions_list = []
    wallet.transactions.where(status: %i[finised system]).order(timestamp: :desc).each do |transaction|
      transactions_list << transaction if transactions_list.pluck(:points).sum.to_i < points
    end
    calculate_transaction(transactions_list)
    update(wallet_id: debit_wallet_id, status: 1)
  end

  def calculate_transaction(transactions_list)
    counter = 0
    transactions_list.each do |transaction|
      transaction_points = transaction.points
      loop do
        counter += 1
        transaction_points -= 1

        if counter == points || transaction_points.zero?
          transaction.update(points: transaction_points)
          break
        end
      end
    end
  end
end
