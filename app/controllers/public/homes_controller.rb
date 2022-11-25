class Public::HomesController < ApplicationController
  def top
    @guides = Genre.all
    @items = Item.all
  end

  def about
  end
end
