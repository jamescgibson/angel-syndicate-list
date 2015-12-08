#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require_relative "../syndicate_list"
require "logger"
Bundler.require

LOGGER = Logger.new(STDOUT)
LOGGER.level = defined?(LOG_LEVEL) ? LOG_LEVEL : Logger::INFO

SyndicateList.new.export
