require "rubygems"
require "bundler/setup"
require 'logger'
require_relative "../syndicate_list"

Bundler.require

LOG_LEVEL = Logger::WARN

VCR.config do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.stub_with :fakeweb
  c.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
