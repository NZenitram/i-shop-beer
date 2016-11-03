class OrdersController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.new

    if @order.save && create_beer_orders
      flash[:success] = "Placed your order!"
      redirect_to user_order_path(@user, @order)
    else
      redirect_to cart_path
    end
  end

  def create_beer_orders
    cart_beers.each do |beer|
      @order.beer_orders.new(beer: beer).save
    end
  end

  def show
    @user = User.find(params[:user_id])
  end

end
