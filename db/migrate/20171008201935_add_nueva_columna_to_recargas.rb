class AddNuevaColumnaToRecargas < ActiveRecord::Migration[5.0]
  def change
    add_column :recargas, :f_referencia_origen, :datetime
    add_column :recargas, :f_referencia_destino, :datetime
    add_column :recargas, :f_aplicado, :datetime
  end
end
