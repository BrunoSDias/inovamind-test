class QuotesController < ApplicationController
  before_action :enable_cache, only: [:find_by_tag]
  before_action :clear_quotes, only: [:load]
  before_action :authorize_request

  def load_quotes
    url = "http://quotes.toscrape.com"
    page = Crawler.get(url)
    quotes_list = Crawler.get_list(page,'div.quote')
    quotes = quotes_search(url, quotes_list)
    quotes.map { |q| q.save }
    @message = Quote.loaded?
  end

  def index
    @quotes = Quote.all 
    render_json(@quotes)
  end

  def find_by_tag
    @quotes = mongo_cache(Quote.where(tags: params[:tag_name]))
    render_json(@quotes)
  end

  def create
    @quote = Quote.new(quote_params)
    @quote.save
  end

  private

    def clear_quotes
      unless Quote.empty?
        Quote.delete_all
      end
    end

    def quotes_search(url, list)
      quotes = []
      list.each do |qt|
        q = {
          quote: qt.css('span.text').text,
          author: qt.css('small.author').text,
          author_about: url + qt.css('a').attribute('href').value,
          tags: qt.css('div.tags .tag').map{|t| t.text}
        }
        quotes << Quote.new(q)
      end
      quotes
    end

    def enable_cache
      unless Mongoid::QueryCache.enabled?
        Mongoid::QueryCache.enabled = true
      end
    end

    def mongo_cache(query)
      ret = Mongoid::QueryCache.cache {query}
    end

    def render_json(result)
      if result == []
        render json: result, status: :no_content
      else
        render json: result
      end
    end
end
