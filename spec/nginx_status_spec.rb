require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

MOCK_CORRECT_RESPONSE = "Active connections: 183
server accepts handled requests
 914384 914384 2725561
Reading: 3 Writing: 2 Waiting: 178
"
MOCK_INCORRECT_RESPONSE = "error"

describe "NginxStatus" do
  it "parses mock /nginx_status response and returns a Hash" do
    NginxStatus.parse_status(MOCK_CORRECT_RESPONSE).class.should == Hash
  end
  
  it "parses mock /nginx_status response and returns a Hash with the correct keys" do
    expected_keys = [:active_connections, :accepted, :handled, :handles, :reading, :writing, :waiting]
    NginxStatus.parse_status(MOCK_CORRECT_RESPONSE).keys.should == expected_keys
  end
  
  it "parses mock /nginx_status response and returns the correct Hash" do
    expected = {:waiting=>178, :handled=>914384, :reading=>3, :active_connections=>183, :accepted=>914384, :handles=>2725561, :writing=>2}
    NginxStatus.parse_status(MOCK_CORRECT_RESPONSE).should == expected
  end
  
  it "throws ParseError when the server response is not an nginx status" do
    lambda {NginxStatus.parse_status(MOCK_INCORRECT_RESPONSE)}.should raise_error("ParseError")
  end
  
end
