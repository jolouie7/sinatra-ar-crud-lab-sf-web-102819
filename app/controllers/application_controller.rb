
require_relative '../../config/environment'
require "pry"

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  #index
  get "/articles" do 
    #shows all created articles
    @articles = Article.all
    # binding.pry
    # 0
    erb :index
  end

  #new
  get '/articles/new' do
    #load the form to create a new article
    erb :new
  end
  
  #create
  post "/articles" do 
    #creates a article instance
    @article = Article.create(title: params[:title], content: params[:content])
    #we want to route the user to their newly created article
    redirect to "/articles/#{@article.id}"
  end

  #show
  get "/articles/:id" do
    #In order to display a single article
    @article = Article.find(params[:id])
    erb :show
  end

  #edit
  get "/articles/:id/edit" do
    #load edit form
    @article = Article.find(params[:id])
    erb :edit
  end

  patch "/articles/:id" do
    #find article that we want to update
    @article = Article.find(params[:id])
    #update attributes with new values
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    # binding.pry
    #go to newly updated article
    redirect to "/articles/#{@article.id}"
  end

  #delete
  delete "/articles/:id/delete" do
    #find a specfic article based on a current article instance id?
    @article = Article.find(params[:id])
    @article.delete
    #we should see 1 less article in articles
    redirect to '/articles'
  end
end
