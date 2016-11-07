require 'rails_helper'

describe  "As a logged in user" do
  context "when I place an order" do
    it "I can view past orders" do
      style = Style.create(name: "IPA")
      beer = Beer.create(name: "Pallet Jack", style: style, price: 5.00)
      user = User.create(email: "brad@yahoo.com", password: "pass")
      order = Order.new(user: user)

      visit '/login'
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      within(".form-horizontal") do
        click_on "Login"
      end

      visit beers_path
      click_button "Add to Cart"
      visit cart_path
      click_on "Checkout"

      visit orders_path

      expect(page).to have_content(user.orders.first.id)
    end
  end
  context "with no placed orders" do
    it "shows no orders" do
      user = User.create(email: "brad@yahoo.com", password: "pass")

      visit '/login'
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      within(".form-horizontal") do
        click_on "Login"
      end

      visit orders_path

      expect(page).to have_content("No previous orders")
    end
  end

end
