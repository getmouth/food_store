class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :zipcode
      t.string :email

      t.timestamps
    end
  end
end
