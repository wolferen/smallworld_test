class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer   :points, null: false
      t.uuid      :wallet_id, null: false, index: true
      t.uuid      :debit_wallet_id, null: false, index: true
      t.integer   :status, default: 0
      t.datetime  :timestamp, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
