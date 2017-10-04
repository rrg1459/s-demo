class CreateDirectos < ActiveRecord::Migration[5.0]
  def change
    create_table :directos do |t|
      t.string :tlf
      t.string :sms

    end
  end
end
