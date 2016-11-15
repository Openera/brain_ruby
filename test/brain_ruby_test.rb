require 'test_helper'


class BrainRubyTest < Minitest::Test
  def setup
    @test_obj = BrainRuby::Brain.new(key: '5chhBCaseNwEk5YN', base_uri: 'https://brain-dev.masv.io', port: '8443')
    @test_url = "https://lon02.objectstorage.softlayer.net/v1/AUTH_37846607-7236-4a08-a6e3-5abe92a21958/masv-test/1000mb?temp_url_sig=625280d278d889c8a178c81b3e5edb974d4ef3b9&temp_url_expires=1480777878"
    @test_path = "v1/AUTH_37846607-7236-4a08-a6e3-5abe92a21958/masv-test/1000mb?temp_url_sig=625280d278d889c8a178c81b3e5edb974d4ef3b9&temp_url_expires=1480777878"
  end

  def test_request_success
    result = @test_obj.url("wdc", @test_url)
    assert_match(/.*pass.*/, result)
    assert result.include?(@test_path)
    assert_match(/.*wdc[0-9][0-9].*/, result)
    assert_match(/.*lon[0-9][0-9].*/, result)
  end

  def test_url_returns_nil_on_bad_location
    assert !@test_obj.url("xyz", @test_url)
    assert !@test_obj.url("wdc01", @test_url)
    assert !@test_obj.url("lon02", @test_url)
  end


  def test_url_returns_nil_on_bad_url
    assert !@test_obj.url("wdc", '')
    assert !@test_obj.url("wdc", "http://www.example.org")
  end

  #make sure the same request will receive the same response
  # def test_consistent
  #   first_result = @test_obj.url("wdc", "")
  #   second_result = @test_obj.url("wdc", "")
  #   assert_equal(first_result, second_result) #if this doesn't work, try assert_match
  # end

  # #make sure requests to different locations will receive different responses
  # def test_location
  #   first_result = @test_obj.url("wdc", "")
  #   second_result = @test_obj.url("lon", "")
  #   refute_equal(first_result, second_result)
  # end
end
