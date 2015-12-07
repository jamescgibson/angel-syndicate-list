class Syndicate
  attr_reader :nok

  def initialize(nokogiri)
    @nok = nokogiri
  end

  def to_a
    [name, deals, recent_deals, investment, valuation, blurb, url]
  end

  private

  def blurb
    nok.css(".syndicate-blurb").text.clean
  end

  def details
    return @details if defined?(@details)
    data = open(details_url).read
    json = JSON.parse(data)
    @details = Nokogiri::HTML(json["html"])
  end

  def details_url
    host + nok.css(".syndicate-details").first&.attr("data-details-url")
  end

  def host
    "https://angel.co"
  end

  def investment
    details.text[/Typical Syndicate Investment(.+?)Typical/m, 1].clean
  end

  def name
    nok.css(".syndicate-name").text.clean
  end

  def deals
    details.text[/(\d+)\sConfirmed\sInvestment/, 1]&.to_i
  end

  def recent_deals
    nok.css(".s-vgPadTop1").text.clean
  end

  def valuation
    details.text[/Typical Valuation(.+?)Typical/m, 1].clean
  end

  def url
    host + nok.css(".syndicate-name a").attr("href")
  end
end
