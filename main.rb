# frozen_string_literal: true

require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require_relative 'memo_db'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

not_found do
  '404 - This is nowhere to be found.'
end

get '/' do
  @memos = MemoDB.read
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  MemoDB.write(params[:title], params[:body])
  redirect '/'
end

get '/:id' do
  @memo = MemoDB.fetch(params[:id])
  halt 404 unless @memo
  erb :show
end

delete '/:id' do
  MemoDB.delete(params[:id])
  redirect '/'
end

get '/edit/:id' do
  @memo = MemoDB.fetch(params[:id])
  halt 404 unless @memo
  erb :edit
end

patch '/:id' do
  MemoDB.update(params[:id], params[:title], params[:body])
  redirect '/'
end
