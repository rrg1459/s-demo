class CreateGrupos < ActiveRecord::Migration[5.0]
  def change
    create_table :grupos do |t|
      t.string :nombre
      t.integer :cantidad_contactos,  default: 0

      t.timestamps
    end
  end
end
