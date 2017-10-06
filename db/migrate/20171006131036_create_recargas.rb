class CreateRecargas < ActiveRecord::Migration[5.0]
  def change
    create_table :recargas do |t|
      t.integer :monto_divisa
      t.string :tipo_divisa
      t.integer :cambio_bs
      t.integer :monto_bs
      t.string :banco_origen
      t.string :referencia_origen
      t.string :transaccion_origen
      t.string :banco_destino
      t.string :referencia_destino
      t.string :transaccion_destino
      t.boolean :aplicado, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
