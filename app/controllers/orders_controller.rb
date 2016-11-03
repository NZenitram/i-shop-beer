class OrdersController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.new
    if @order.save
      @order.create_beer_orders(cart_beers, @cart)
      flash[:success] = "Placed your order!"
      redirect_to user_order_path(@user, @order)
    else
      redirect_to cart_path
    end
  end

  def show
    @user = User.find(params[:user_id])
  end

  def index
    @user = User.find(session[:user_id])
    @orders = @user.orders
  end

end
