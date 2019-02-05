class CombineItemsInCart < ActiveRecord::Migration[5.2]
  def up
    Cart.all.each do |cart|
      all_items = cart.line_items.group(:product_id).sum(:quantity)
      all_items.each do |product_id, quantity|
        if quantity > 1
          #deletes multiple single line products
          cart.line_items.where(product_id: product_id).delete_all

          #set single product with updated quantity
          item = cart.line_items.build(product_id: product_id)
          item.quantity = quantity
          item.save
        end
      end
    end
  end

  def down
    # split items with quantity > 1 into single line intems
    LineItem.where("quantity>1").each do |line_item|
      line_item.quantity.times do
        LineItem.create(
          cart_id: line_item.cart_id,
          product_id: line_item.product_id,
          quantity: 1
        )
      end
      #remove original item
      line_time.destroy
    end
  end
end
