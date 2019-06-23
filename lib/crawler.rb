class Crawler
  class << self

    def get(url)
      begin
        Nokogiri::HTML(HTTParty.get(url))
      rescue HTTParty::Error => e
        render json: { errors: e.message }
      end
    end

    def get_list(page, search_param)
      page.search(search_param)
    end
  end
end
