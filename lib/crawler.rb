class Crawler
  class << self

    def get(url)
      Nokogiri::HTML(HTTParty.get(url))
    end

    def get_list(page, search_param)
      page.search(search_param)
    end
  end
end
