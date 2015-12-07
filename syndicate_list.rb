require "csv"
Dir["./lib/*.rb"].each { |f| require f }


class SyndicateList
  attr_reader :fragments

  def initialize
    @fragments = []
    @fragments << Fragment.new(url)
#    build_fragments
  end

  def url
    "https://angel.co/syndicates/deals-in-last-year"
  end

  def export
    headers = %w(name deals recent_deals investment valuation tags url)
    data = ([headers] + syndicates.map(&:to_a)).map(&:to_csv).join("")
    File.write("syndicates.csv", data)
  end

  private

  def syndicates
    @fragments.map(&:syndicates).flatten
  end

  def build_fragments
    if fragments.last.more?
      fragments << Fragment.new(fragments.last.more_url)
      build_fragments
    end
  end

end
