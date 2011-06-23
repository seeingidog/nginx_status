require 'rubygems'
require 'httparty'

# Read Nginx status and return a Hash of current status counters

class NginxStatus
  include HTTParty
    
  def self.get_status(host)
    response = get("http://#{host}/nginx_status").parsed_response
    parse_status(response)
  end
  
  def self.parse_status(parsed_response)
    status = parsed_response.split("\n")
    rww = status[3].split
    sahr = status[2].split
    {:active_connections => status[0].gsub("Active connections: ", "").to_i, :accepted => sahr[0].to_i, :handled => sahr[1].to_i, :handles => sahr[2].to_i, :reading => rww[1].to_i, :writing => rww[3].to_i, :waiting => rww[5].to_i}
  end
  
end

