require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

MOCK_RESPONSE = "Active connections: 183
server accepts handled requests
 914384 914384 2725561
Reading: 3 Writing: 2 Waiting: 178
"

describe "NginxStatus" do
  it "parses mock /nginx_status response" do
    expected = {:waiting=>178, :handled=>914384, :reading=>3, :active_connections=>183, :accepted=>914384, :handles=>2725561, :writing=>2}
    NginxStatus.parse_status(MOCK_RESPONSE).should == expected
  end
  
end
