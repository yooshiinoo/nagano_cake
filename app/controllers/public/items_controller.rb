class Public::ItemsController < ApplicationController
  def index
    @guides = Genre.all
    @total_items = Item.all
    @items = Item.all.page(params[:page])
  end

  def show
    @guides = Genre.all
    @item = Item.find(params[:id])
  end
end
