class AddIndexToGrupo < ActiveRecord::Migration[5.0]
  def change
    add_column :grupos, :user_id, :integer
    add_index :grupos, :user_id
  end
end
