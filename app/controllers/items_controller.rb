# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def new
    @item = Item.new
    authorize @item
  end

  def admin_index
    @items = Item.order('created_at')
    authorize @items
  end

  def index
    if current_user
      order = Order.find_by(nil)
      order&.update(user_id: current_user&.id) if order
    end
    @items = if params[:format]
               Category.find_by(id: params[:format])&.items
             else
               Item.all
             end
    @items = @items.where(status: 'active')
  end

  def show
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    if @item.save
      flash[:notice] = 'Item created successfully'
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def edit
    authorize @item
  end

  def update
    authorize @item
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  def destroy
    authorize @item
    if @item.destroy
      redirect_to admin_items_path
    else
      render js: "alert('Error in deletion')"
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :price, :description, :status, :image, category_ids: [])
  end
end
