# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
    authorize @categories
  end

  def show
    authorize @category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category
    if @category.save
      flash[:notice] = 'Category created successfully.'
      redirect_to @category
    else
      render :new
    end
  end

  def update
    authorize @category
    if @category.update(category_params)
      flash[:notice] = 'Category updated successfully.'
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    authorize @category
    if @category.destroy
      flash[:notice] = 'Category destroyed successfully.'
      redirect_to categories_path
    else
      render js: "alert(Error in deletion'')"
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
