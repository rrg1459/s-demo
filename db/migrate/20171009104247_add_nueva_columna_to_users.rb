class AddNuevaColumnaToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :saldo, :integer, default: 0
  end
end
