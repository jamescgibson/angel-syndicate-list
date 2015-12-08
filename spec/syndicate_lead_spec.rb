require_relative "./spec_helper"

RSpec.describe SyndicateLead do
  use_vcr_cassette

  describe "penchina" do
    subject do
      SyndicateLead.new("https://angel.co/penchina")
    end

    it "gets the user id" do
      expect(subject.send(:user_id)).to match "27072"
    end

    it "gets the correct investments url" do
      expect(subject.send(:investments_url)).to match(/investments\?user_id=27072/)
    end

    it "includes the correct startups" do
      expect(subject.send(:startup_urls)).to include("https://angel.co/barricade")
    end

    it "includes tags" do
      expect(subject.tags.keys.count).to be > 10
    end
  end

  describe "fg-angels" do
    subject do
      SyndicateLead.new("https://angel.co/fg-angels")
    end

    it "has startups" do
      expect(subject.send(:startup_urls)).to include("https://angel.co/mattermark")
    end
  end
end
