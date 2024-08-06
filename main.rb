# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require_relative 'memo'
require 'webrick'

before do
  @memo = Memo.new
end

helpers do
  def h(text)
    WEBrick::HTMLUtils.escape(text)
  end
end

not_found do
  '404 - This is nowhere to be found.'
end

get '/' do
  @contents = @memo.read
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @memo.write(params[:title], params[:body])
  redirect '/'
end

get '/:id' do
  @content = @memo.fetch(params[:id])
  halt 404 unless @content
  erb :show
end

delete '/:id' do
  @memo.delete(params[:id])
  redirect '/'
end

get '/edit/:id' do
  @content = @memo.fetch(params[:id])
  erb :edit
end

patch '/:id' do
  @memo.update(params[:id], params[:title], params[:body])
  redirect '/'
end
