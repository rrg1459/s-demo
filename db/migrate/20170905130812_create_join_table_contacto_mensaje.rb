class CreateJoinTableContactoMensaje < ActiveRecord::Migration[5.0]
  def change
    create_join_table :contactos, :mensajes do |t|
      # t.index [:contacto_id, :mensaje_id]
      # t.index [:mensaje_id, :contacto_id]
    end
  end
end
