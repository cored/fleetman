require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("<FLEETIO_API_TOKEN>") { ENV.fetch("FLEETIO_API_TOKEN") }
  config.filter_sensitive_data("<FLEETIO_ACCOUNT_TOKEN>") { ENV.fetch("FLEETIO_ACCOUNT_TOKEN") }
end
