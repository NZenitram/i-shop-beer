require 'rails_helper'

describe  'As a logged in user' do
  context 'when I add items to my cart' do
    it "I can place an order" do
      style = Style.create(name: "IPA")
      beer = Beer.create(name: "Pallet Jack", style: style, price: 5.00)
      user = User.create(email: "brad@yahoo.com", password: "pass")
      order = Order.new(user: user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit style_beers_path(style, beer)
      click_button "Add to Cart"
      visit cart_path
      click_on "Place Order"

      expect(current_path).to eq(user_order_path(user, Order.all.first))
      expect(page).to have_content("Pallet Jack")
      expect(page).to have_content("Price: $5.00")
      expect(page).to have_content("Subtotal: $5.00")
      expect(page).to have_content("Order Date: #{order.created_at}")
      expect(page).to have_content("Order Total: $5.00")
    end
  end

  context 'when the cart is empty' do
    it "I can't place an order" do
      user = User.create(email: "brad@yahoo.com", password: "pass")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit cart_path

      expect(page).to have_button("Place Order", disabled: true)
    end
  end
end
