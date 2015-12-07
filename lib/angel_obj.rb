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
    puts "Fetching #{url}"
    @page = Nokogiri::HTML(open(url))
   rescue StandardError => e
     puts "Execption fetching #{url}"
     @page = Nokogiri::HTML("<html></html>")
  end
end
