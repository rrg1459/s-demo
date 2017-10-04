class CreateSaldos < ActiveRecord::Migration[5.0]
  def change
    create_table :saldos do |t|
      t.integer :usuario_id
      t.integer :saldo, default: 1000

      t.timestamps
    end
  end
end
