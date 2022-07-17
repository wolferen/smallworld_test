# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ActiveRecord::Base.transaction do
  wallet_1 = Wallet.create
  wallet_2 = Wallet.create

  system_wallet = Wallet.create(status: 1)

  10.times do
    wallet_1.transactions.create!(points: rand(100..1000),
                                 status: 'system',
                                 debit_wallet_id: wallet_2.id)
    wallet_2.transactions.create!(points: rand(100..1000),
                                 status: 'system',
                                 debit_wallet_id: wallet_2.id)
  end

  100.times do
    wallet_2.transactions.create!(points: rand(100..1000),
                                 status: 'finished',
                                 debit_wallet_id: wallet_1.id)

    wallet_1.transactions.create!(points: rand(100..1000),
                                 status: 'finished',
                                 debit_wallet_id: wallet_2.id)
  end
end
