class CreateContactos < ActiveRecord::Migration[5.0]
  def change
    create_table :contactos do |t|
      t.string :numero
      t.string :nombre
      t.string :archivo, default: "*cargado-linea*"
      t.references :user, index: true

      t.timestamps
    end
  end
end
