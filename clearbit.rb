raise "Missing argument try:\nruby #{__FILE__} [source] [destination]" unless ARGV[0] && ARGV[1]
require './lib/clearbit_csv'

ClearbitCSV.generate(source: ARGV[0], target: ARGV[1])
