require 'net/http'
require 'json'

class Query
  attr_reader :search_term, :source

  CLEARBIT = ->(search_term){ "https://autocomplete.clearbit.com/v1/companies/suggest?query=\"#{search_term}\"&sort=employees_desc"}

  def initialize(search_term, source)
    @search_term = sanitize(search_term.dup)
    p @search_term
    @source = Object.const_get("Query::#{source.upcase}")
  end

  def response
    res = Net::HTTP.get_response(URI( source.call(search_term) ))
    body = JSON.parse(res.body)
    p body.inspect
    body
  end

  private

  EXTRANEOUS_TERMS = [" ltd", " Plc", " PLC", " plc", " Ltd", " (LLP)", " UK Plc", " UK Ltd", " Limited", " UK LImited", " Limited (UK)", " (UK) Limited", /\([^\]]*\)/ ].freeze

  def sanitize(string)
    EXTRANEOUS_TERMS.each do |term| 
      string.gsub!(term, "")
      string.upcase.gsub!(term, "")
      string.downcase.gsub!(term, "")
    end
    string
  end

end
