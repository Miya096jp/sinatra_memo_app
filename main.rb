# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require_relative 'memo'

before do
  @memo = Memo.new
end

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

not_found do
  '404 - This is nowhere to be found.'
end

get '/' do
  @dataset = @memo.read
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @memo.write(h(params[:title]), h(params[:body]))
  redirect '/'
end

get '/:id' do
  @data = @memo.show(params[:id])
  halt 404 unless @data
  erb :show
end

delete '/:id' do
  @memo.delete(params[:id])
  redirect '/'
end

get '/edit/:id' do
  @data = @memo.show(params[:id])
  erb :edit
end

patch '/:id' do
  @memo.update(h(params[:id]), h(params[:title]), h(params[:body]))
  redirect '/'
end
