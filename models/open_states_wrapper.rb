
API_KEY = '15976b43616b43298ea1a3a98971d3e0'

class OpenStates
  include HTTParty
  base_uri 'http://openstates.org/api/v1/'
  
  def self.legislator_search(options={})
    url = "/legislators/?state=KY"
    url += "&first_name=#{options[:first_name]}" 
    url += "&last_name=#{options[:last_name]}" 
    url += "&chamber=#{options[:chamber]}" 
    url += "&active=#{options[:active]}" 
    url += "&term=#{options[:term]}" 
    url += "&district=#{options[:district]}" 
    url += "&party=#{options[:party]}" 
    
    url += "&apikey=" + API_KEY
    puts("!!!!!!!!!!!!!")
    puts(url)
    get(url)
  end
  
  def self.legislator_lookup(options={})
    url = "/legislators/"
    url += "#{options[:leg_id]}/"
    url += "?apikey=#{API_KEY}"
    get(url)
  end

  def self.legislator_geo(options={})
    url = "/legislators/geo/"
    url += "?long=#{options[:long]}"
    url += "&lat=#{options[:lat]}"
    url += "&apikey=" + API_KEY
    puts url
    get(url)
    end

  def self.bill_search(options ={})
    url = "/bills/?state=KY&q=#{options[:keyword]}"
    url += "&chamber=#{options[:chamber]}"
    if !options[:subject].nil?
      url += "&subject=#{URI.encode(options[:subject])}"
    end
    if !options[:leg_id].nil?
      url += "&sponsor_id=#{options[:leg_id]}"
    end
    url += "&apikey=" + API_KEY
    get(url)
  end
  
  def self.bill_lookup(options={})
    url = "/bills/ky/"
    url += "#{options[:session]}/"
    url += "#{options[:bill_id]}/"
    url += "?apikey=#{API_KEY}"
    get(URI.encode(url))
  end
 
  def self.committee_lookup(com_id)
    url = "/committees/#{com_id}/?apikey=#{API_KEY}"
    get(url)
  end

end

