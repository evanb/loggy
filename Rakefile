require 'lib/path_collapser.rb'

SOURCE_DIR = "source"
WORK_DIR = "work"
ORIG_LOG = "#{SOURCE_DIR}/access_log.2010-06-10-business-hours"

desc 'filter out only swannweb requests'
task :filter_webapp do
  directory "#{WORK_DIR}"
  sh "grep the-host:10700 #{ORIG_LOG} > #{WORK_DIR}/access_log.2010-06-10-business-hours"
end

desc 'extract date and path'
task :extract_date_path do

  counters = Hash.new

  collapser = PathCollapser.new

  # static assets
  collapser.add '/images/.*'
  collapser.add '/stylesheets/.*'
  collapser.add '/javascripts/.*'

  # documents
  collapser.add '/documents/pds/.*'
  collapser.add '/documents/[0-9]*\.pdf'

  # comms
  collapser.add '/communications/.*'

  # unicycle
  collapser.add '/unicycle_product_options/[0-9]*'
  collapser.add '/unicycle/disclosures/new/[0-9]*'
  collapser.add '/unicycle_customizations/[0-9]*'
  collapser.add '/unicycle_financiers/[0-9]*'
  collapser.add '/unicycle/customizations/premium_sidebar/[0-9]*'
  collapser.add '/unicycle_additional_cover_options/[0-9]*'
  collapser.add '/unicycle_policies/[0-9]*/edit'
  collapser.add '/unicycle_accessories/[0-9]*'
  collapser.add '/unicycle_confirmation/[0-9]*'
  collapser.add '/unicycle_modifications/[0-9]*'
  collapser.add '/unicycle/payments/create/[0-9]*'
  collapser.add '/unicycle_payments/[0-9]*'

  File.open("#{WORK_DIR}/access_log.2010-06-10-business-hours", "r") do |infile|
    while (line = infile.gets)
      bits = line.split
      timestamp = bits[1]
      timestamp.slice!(0)
      method = bits[4]

      path = bits[5]
      path.slice!(0) # remove leading double quote
      path.chop! #remove trailing double quote
      path = collapser.collapse(path)

      #puts "#{timestamp}, #{method}, #{path}"

      counter = counters[path]
      if !counter
        counter = HitCounter.new path
        counters[path] = counter
      end
      counter.hit
    end
  end

  counters.values.each do |counter|
    puts "#{counter.url},#{counter.count}"
  end

end

class HitCounter

  attr_reader :url, :count

  def initialize url
    @url = url
    @count = 0
  end

  def hit
    @count += 1
  end

end

