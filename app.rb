#require 'rubygems'
require 'sinatra'
require 'json'
require 'httparty'
require 'uri'
require 'pp'
load "models/open_states_wrapper.rb" 



get '/' do
  erb :index
end

#Search form for legislators
get '/legislator_search' do
  erb :legislator_search
end

get '/legislator/search/' do
  @results = OpenStates.new.legislator_search({:first_name => params['first_name'], :last_name => params['last_name'], :chamber => params['chamber'], :active => params['active'], :term => params['term'], :district => params['district'], :party => params['party']})
  erb :legislator_results
end

get '/legislators/:leg_id' do
  @legislator = OpenStates.new.legislator_lookup({:leg_id => params['leg_id']});
  erb :legislator_detail
end

#Search form for bills
get '/bill_search' do
  erb :bill_search
end

#results for bill search
get '/bills/search/' do
  @results = OpenStates.new.bill_search({:keyword => params['keyword'], :chamber => params['chamber'], :subject => params['subject']})
  erb :bills_results
end

#bill detail / lookup
get '/bills/:session/:bill_id' do
  @bill = OpenStates.new.bill_lookup({:session => params[:session], :bill_id => params[:bill_id]})
  erb :bill_detail
end

get '/committee/:com_id' do
  @committee = OpenStates.new.committee_lookup(params[:com_id])
  erb :committee_detail
end

get '/committees' do
  erb :committees
end
