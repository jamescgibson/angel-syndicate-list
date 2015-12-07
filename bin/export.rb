#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require_relative "../syndicate_list" 
Bundler.require

SyndicateList.new.export
