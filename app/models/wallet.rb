class Wallet < ApplicationRecord
  enum status: %i[personal system]

  has_many :transactions

  def balance
    transactions.where(status: %i[finished system]).sum(:points).to_i
  end
end
