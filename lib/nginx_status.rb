require 'httparty'

class NginxStatus
  include HTTParty
    
  def self.get_status(host)
    r = get("http://#{host}/nginx_status").parsed_response.split("\n")
    rww = r[3].split
    sahr = r[2].split
    {:active_connections => r[0].gsub("Active connections: ", "").to_i, :accepted => sahr[0].to_i, :handled => sahr[1].to_i, :handles => sahr[2].to_i, :reading => rww[1].to_i, :writing => rww[3].to_i, :waiting => rww[5].to_i}
  end
  
end

