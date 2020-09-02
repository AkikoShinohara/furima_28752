class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index
    @items = Item.all
  end

  def new  
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    else
    end
  end

  # def  done
  #   @item_purchaser= Item.find(params[:id])
  #   @item_purchaser.update( item_id: current_user.id)
  #  end

  def item_params
    params.require(:item).permit(:name, :messages, :category_id, :condition_id, :shopping_cost_id, :prefecture_id, :send_day_id, :price, :image).merge(user_id: current_user.id)
  end
end