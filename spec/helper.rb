if RUBY_VERSION >= '1.9'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

  SimpleCov.start do
    add_filter '/spec/'
    minimum_coverage(99.63)
  end
end

require 'armory'
require 'rspec'
require 'stringio'
require 'tempfile'
require 'timecop'
require 'webmock/rspec'

WebMock.disable_net_connect!(:allow => 'coveralls.io')

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

URL_PREFIX = 'https://us.api.battle.net'
TEST_APIKEY_LOCALE = { apikey:"API", locale: "en_US" }


def a_delete(path, params = {})
  a_request(:delete, URL_PREFIX + path + merge_api_and_locale(params))
end

def a_get(path, params = {})
  a_request(:get, URL_PREFIX + path + merge_api_and_locale(params))
end

def a_post(path, params = {})
  a_request(:post, URL_PREFIX + path + merge_api_and_locale(params))
end

def a_put(path, params = {})
  a_request(:put, URL_PREFIX + path + merge_api_and_locale(params))
end

def stub_delete(path, params = {})
  stub_request(:delete, URL_PREFIX + path + merge_api_and_locale(params))
end

def stub_get(path, params = {})
  stub_request(:get, URL_PREFIX + path + merge_api_and_locale(params))
end

def stub_post(path, params = {})
  stub_request(:post, URL_PREFIX + path + merge_api_and_locale(params))
end

def stub_put(path, params = {})
  stub_request(:put, URL_PREFIX + path + merge_api_and_locale(params))
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def fixture_as_json(file)
  JSON.parse(fixture(file).read, :symbolize_names => true)
end

def capture_warning
  begin
    old_stderr = $stderr
    $stderr = StringIO.new
    yield
    result = $stderr.string
  ensure
    $stderr = old_stderr
  end
  result
end

def merge_api_and_locale(params)
  url_query = URI.encode_www_form params.merge(TEST_APIKEY_LOCALE).sort
  url_query.empty? ? "" : "?"+url_query
end
