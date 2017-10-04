class CreateJoinTableGrupoMensaje < ActiveRecord::Migration[5.0]
  def change
    create_join_table :grupos, :mensajes do |t|
      # t.index [:grupo_id, :mensaje_id]
      # t.index [:mensaje_id, :grupo_id]
    end
  end
end
