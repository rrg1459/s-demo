class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.string :texto, limit: 160
      t.references :user, index: true
      t.integer :parent_id
      t.integer :enviado_por_id
      t.datetime :f_enviado
      t.integer :cantidad_contactos,  default: 0

      t.timestamps
    end
  end
end
