class Quote
  include Mongoid::Document
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array, default: []

  def self.loaded?
    if self.empty?
      "Not able to load collection quotes"
    else
      "Collection loaded with success"
    end
  end
end
