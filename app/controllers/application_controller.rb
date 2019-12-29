require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end
  
  # CREATE
  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(title: params[:article][:title], content: params[:article][:content])
    redirect "/articles/#{@article.id}"
  end
  
  # READ
  get '/articles/:id' do 
    @article = Article.find(params[:id])
    erb :show
  end
  
  # UPDATE
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end
  
  patch '/articles/:id' do
    Article.update(params[:id], params[:article])
    redirect "/articles/#{id}"
  end
  
  # DELETE 
  delete '/articles/:id' do
    Article.delete(params[:id])
    redirect '/articles'
  end
end
