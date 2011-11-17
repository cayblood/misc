require 'csv'

raise "Usage: ruby transform.rb <filename>" unless ARGV.first
filename = ARGV.first
raise "File not found: #{filename}" unless File.exists?(filename)

content = ''
File.open(ARGV.first, 'r:iso-8859-1:utf-8') do |f|
  content = f.read
end
content.gsub!(';', ',')

transactions = CSV.parse(content)
CSV.open("#{File.basename(filename, '.csv')}_new.csv", 'w') do |csv|
  transactions.each do |line|
    [0, 1].each do |index|
      line[index].gsub!('-', '.')
    end
    [3, 4].each do |index|
      line[index].gsub!('.', '')
#      line[index].sub!(',', '.')
    end
    csv << line
  end
end
