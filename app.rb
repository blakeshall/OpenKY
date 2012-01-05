#require 'rubygems'
require 'sinatra'
require 'json'
require 'httparty'
require 'uri'
require 'pp'

API_KEY = '15976b43616b43298ea1a3a98971d3e0'
class OpenStates
  include HTTParty
  base_uri 'http://openstates.org/api/v1/'

  def bill_search(options ={})
    url = "/bills/?state=KY&q=#{options[:keyword]}"
    url += "&chamber=#{options[:chamber]}"
    if !options[:subject].nil?
      url += "&subject=#{URI.encode(options[:subject])}"
    end
    url += "&apikey=" + API_KEY
    puts("!!!!!!!!!!!")
    puts(url)
    self.class.get(url)
  end

end
get '/' do
  erb :index
end

#Search form for bills
get '/bill_search' do
  erb :bill_search
end

get '/bill/:id' do
  #TODO Lookup a specific bill based on Session and/or Chamber and Bill ID
  erb :bill
end

#results for bill search
get '/bills/search/' do
  @results = OpenStates.new.bill_search({:keyword => params['keyword'], :chamber => params['chamber'], :subject => params['subject']})

  puts(@results)
  puts('#####################')
  puts(params)
  erb :bills_results
end
