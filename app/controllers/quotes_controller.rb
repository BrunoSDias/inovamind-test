class QuotesController < ApplicationController
  before_action :enableCache, only: [:find_by_tag]
  before_action :clear_quotes, only: [:load]
  before_action :authorize_request

  def load
    url = "http://quotes.toscrape.com"
    page = Crawler.get(url)
    quotes_list = Crawler.get_list(page,'div.quote')
    quotes = quotesSearch(url, quotes_list)
    quotes.map { |q| q.save }
    @message = Quote.loaded?
  end

  def index
    @quotes= Quote.all 
    render json: @quotes
  end

  def find_by_tag
    @quotes = mongoCache(Quote.where(tags: params[:tag_name]))
    render json: @quotes
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

    def quotesSearch(url, list)
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

    def enableCache
      unless Mongoid::QueryCache.enabled?
        Mongoid::QueryCache.enabled = true
      end
    end

    def mongoCache(query)
      Mongoid::QueryCache.cache {query}
    end
end
