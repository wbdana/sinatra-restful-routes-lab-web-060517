class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Homepage redirect
  get '/' do
    redirect to '/recipes'
  end

  # All recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # Create a new recipe
  get '/recipes/new' do
    erb :new
  end

  # Submit new recipe & redirect to new recipe page
  post '/recipes' do
    # binding.pry
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}/"
    # erb :show
  end

  # Show a recipe
  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id].to_i)
    erb :show
  end

  # Delete a recipe
  post '/recipes/:id/delete' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.delete
    # erb :index
  end

  # Edit a recipe
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params[:id])
    erb :edit
  end

  # Post updates
  post '/recipes/:id' do
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.update(params[:recipe])
    redirect to '/recipes/#{recipe.id}'
  end




end
