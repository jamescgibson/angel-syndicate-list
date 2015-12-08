require_relative "./spec_helper"

RSpec.describe Startup do
  use_vcr_cassette
  subject do
    Startup.new("https://angel.co/sprig")
  end

  it "gets the name" do
    expect(subject.name).to eq "Sprig"
  end

  it "gets the tags" do
    expect(subject.tags).to include "San Francisco"
    expect(subject.tags).to include "Mobile Commerce"
    expect(subject.tags).to include "Food and Beverages"
  end
end
