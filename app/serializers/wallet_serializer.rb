class WalletSerializer < ApplicationSerializer
  attributes :id, :balance, :status

  attribute :transactions do |object|
    object.transactions.map do |t|
      {
        id: t.id,
        points: t.points,
        timestamp: t.timestamp
      }
    end
  end
end
