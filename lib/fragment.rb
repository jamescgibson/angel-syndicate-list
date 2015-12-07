require 'json'
require 'open-uri'

class Fragment
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def more?
    page.css("[data-see-more-url]").count > 0
  rescue StandardError => e
  end

  def more_url
    host + more_path
  end

  def syndicates
    page.css(".syndicate-card-container").map{ |x| Syndicate.new(x) }
  end

  private

  def host
    @url[/(https:\/\/.+?)\//, 1]
  end

  def page
    return @page if defined?(@page)
    data = open(url).read
    if data[0] == "{"
      json = JSON.parse(data)
      @page = Nokogiri::HTML(json["html"])
    else
      @page = Nokogiri::HTML(data)
    end
    @page
  end


  def more_path
    page.css("[data-see-more-url]").first&.attr("data-see-more-url")
  end

end
