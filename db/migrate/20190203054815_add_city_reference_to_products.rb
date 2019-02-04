class AddCityReferenceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :city, foreign_key: true
  end
end
