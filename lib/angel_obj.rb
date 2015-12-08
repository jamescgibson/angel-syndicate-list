class AngelObj
  attr_reader :url

  def initialize(url)
    @url = url
  end

  protected

  def host
    "https://angel.co"
  end

  def page
      return @page if @page
    @page = Nokogiri::HTML(PageCache.instance.fetch(url))
   rescue StandardError => e
     LOGGER.error "Execption fetching #{url}"
     byebug
     @page = Nokogiri::HTML("<html></html>")
  end
end
