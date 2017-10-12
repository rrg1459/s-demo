class AddNuevaColToRecargas < ActiveRecord::Migration[5.0]
  def change
    add_column :recargas, :referencia, :string
    add_column :recargas, :comentarios, :string
  end
end
