#require 'rubygems'
require 'sinatra'
require 'json'
require 'httparty'
require 'uri'
require 'pp'
require 'geocoder'
require './models/open_states_wrapper'


get '/' do
  erb :index
end

#Search form for legislators
get '/legislator_search' do
  erb :legislator_search
end

get '/legislator/search/' do
  @results = OpenStates.legislator_search(params)
  erb :legislator_results
end

get '/legislators/:leg_id' do
  @legislator = OpenStates.legislator_lookup({:leg_id => params['leg_id']});
  @bills = OpenStates.bill_search({:leg_id => params['leg_id']})
  erb :legislator_detail
end

get '/legislator_geo' do
  @coords = Geocoder.coordinates(params[:zipcode])
  @results = OpenStates.legislator_geo({:lat => @coords[0], :long => @coords[1]})

  erb :legislator_results
end

#Search form for bills
get '/bill_search' do
  erb :bill_search
end

#results for bill search
get '/bills/search/' do
  @results = OpenStates.bill_search({:keyword => params['keyword'], :chamber => params['chamber'], :subject => params['subject'], :leg_id => params['leg_id']})
  erb :bills_results
end

#bill detail / lookup
get '/bills/:session/:bill_id' do
  @bill = OpenStates.bill_lookup({:session => params[:session], :bill_id => params[:bill_id]})
  erb :bill_detail
end

get '/committee/:com_id' do
  @committee = OpenStates.committee_lookup(params[:com_id])
  erb :committee_detail
end

get '/committees' do
  erb :committees
end
