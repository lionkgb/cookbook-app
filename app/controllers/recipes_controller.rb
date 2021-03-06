class RecipesController < ApplicationController

  def index
    if params[:prep_time]
      @recipes = Recipe.all.order(prep_time: params[:prep_time])
    else
      @recipes = Recipe.all
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def new
    unless current_user
      flash[:message] = "Only signed in cooks can create recipes!"
      redirect_to "/signup"
    end
  end

  def create
    title = params[:title]
    ingredients = params[:ingredients]
    prep_time = params[:prep_time]
    image = params[:image]
    recipe = Recipe.new({title: title, ingredients: ingredients, prep_time: prep_time, image: image, user_id: current_user.id })
    recipe.save
    flash[:success] = "Recipe Created"
    redirect_to "/recipes/#{recipe.id}"
  end

  def edit
    @recipe = Recipe.find_by(id: params[:id])
  end

  def update
    recipe = Recipe.find_by(id: params[:id])
    recipe.title = params[:title]
    recipe.ingredients = params[:ingredients]
    recipe.prep_time = params[:prep_time]
    recipe.image = params[:image]
    recipe.save
    flash[:success] = "Recipe Updated"
    redirect_to "/recipes/#{recipe.id}"
  end

  def destroy
    recipe = Recipe.find_by(id: params[:id])
    recipe.destroy
    flash[:warning] = "Recipe Deleted"
    redirect_to "/recipes"
  end
end