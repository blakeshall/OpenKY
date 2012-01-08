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
  
  def bill_lookup(options={})
    url = "/bills/ky/"
    url += "#{options[:session]}/"
    url += "#{options[:bill_id]}/"
    url += "?apikey=#{API_KEY}"
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

#results for bill search
get '/bills/search/' do
  @results = OpenStates.new.bill_search({:keyword => params['keyword'], :chamber => params['chamber'], :subject => params['subject']})

  puts(@results)
  puts('#####################')
  puts(params)
  erb :bills_results
end

#bill detail / lookup
get '/bills/:session/:bill_id' do
  @bill = OpenStates.new.bill_lookup({:session => params[:session], :bill_id => params[:bill_id]})
  
  erb :bill_detail
end
