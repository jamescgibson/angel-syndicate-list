class SyndicateLead < AngelObj

  def tags
    return @tags if @tags
    startup_tags = startups.map(&:tags).flatten
    hash = Hash.new(0)
    startup_tags.each{|key| hash[key] += 1}
    @tags = hash
  end

  def startups
    startup_urls.map{ |x| Startup.new(x) }
  end

  private
  
  def investments
    return @investments if @investments
    data = open(investments_url, "Accept" => "application/json").read
    @investments = JSON.parse(data)
  end

  def investments_url
    host + "/startup_roles/investments?user_id=#{user_id}" if user_id
  end

  def user_id
    page.css(".profiles-show[data-user_id]").first&.attr("data-user_id")
  end

  def startup_urls
    if investments_url
      investments.map{|x| x["company"]["slug_url"]}
    else
      page.css("[data-type='Startup']").map{ |a| a.attr("href") }.uniq
    end
  end
end
