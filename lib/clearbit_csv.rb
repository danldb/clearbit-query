require 'net/http'
require 'csv'
require_relative './query'

class CSV

  def self.to_a(path)
    headers = foreach(path).first
    [].tap do |data|
      foreach(path).with_index do |row, index|
        data << headers.zip(row).to_h unless index == 0
      end
    end
  end
end

class Array

  def to_csv(csv_filename="hash.csv")
    CSV.open(csv_filename, "wb") do |csv|
      csv << first.keys 
      self.each do |hash|
        csv << hash.values
      end
    end
  end
end

class ClearbitCSV

  RATE_LIMIT = 60

  attr_reader :source
  private :source

  def self.generate(source:,target:)
    new(source).generate(target)
  end

  def initialize(source)
    @source = CSV.to_a(source)
  end

  def generate(target)
    total_suppliers = source.length
    source.each_with_index do |supplier, index|
      sleep(60/RATE_LIMIT)
      p "Getting #{supplier["supplier"]}, #{index + 1} of #{total_suppliers}"

      query = get_data(supplier)
      
      supplier["logo"] = query["logo"]
      supplier["domain"] = query["domain"]
      p "#{supplier["supplier"]} returned no results" if query.empty?
    end

    source.to_csv(target)
  end

  private

  def get_data(supplier)
    Query.new(supplier["supplier"], :clearbit).response.first || {}
  rescue
    {}
  end
end
