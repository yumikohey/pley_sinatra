require_relative '../app/models/violation'
require 'csv'
require 'iconv'

module ViolationsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/violations_plus.csv")
    field_names = nil
    Violation.transaction do
      File.open(filename).each do |line|
        ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
        valid_line = ic.iconv(line)
        data = valid_line.chomp.split(',')
        data.each do |string|
          string.gsub!(/["]/,"")
        end
        if field_names.nil?
          field_names = data
        else
          attribute_hash = Hash[field_names.zip(data)]
          violation = Violation.create!(attribute_hash)
        end
      end
    end
  end
end
