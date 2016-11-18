require 'test_helper'

class BrainRubyDevTest < Minitest::Test
  def setup
    BrainRuby.configure_with("#{GEM_ROOT}/conf_test.yml")

    @test_url = "https://lon02.objectstorage.softlayer.net/v1/AUTH_37846607-7236-4a08-a6e3-5abe92a21958/masv-test/1000mb?temp_url_sig=625280d278d889c8a178c81b3e5edb974d4ef3b9&temp_url_expires=1480777878"
    @test_path = "v1/AUTH_37846607-7236-4a08-a6e3-5abe92a21958/masv-test/1000mb?temp_url_sig=625280d278d889c8a178c81b3e5edb974d4ef3b9&temp_url_expires=1480777878"
  end

  def test_correct_configuration
    config = BrainRuby.config
    assert config[:api_key]
    assert config[:base_uri]
    assert config[:port]
  end

  def test_url_returns_nil_on_bad_location
    assert_nil BrainRuby::Requests.url("xyz", @test_url)
    assert_nil BrainRuby::Requests.url("wdc01", @test_url)
    assert_nil BrainRuby::Requests.url("lon02", @test_url)
  end

  def test_url_returns_nil_on_bad_url
    assert_nil BrainRuby::Requests.url("wdc", '')
    assert_nil BrainRuby::Requests.url("wdc", "http://www.example.org")
  end

  def test_url_success_and_returns_brain_url
    result = BrainRuby::Requests.url("wdc", @test_url)

    assert_match(/.*pass.*/, result)
    assert result.include?(@test_path)
    assert_match(/.*wdc[0-9][0-9].*/, result)
    assert_match(/.*lon[0-9][0-9].*/, result)
  end
end
