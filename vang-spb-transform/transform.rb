require 'csv'

raise "Usage: ruby transform.rb <filename>" unless ARGV.first
filename = ARGV.first
raise "File not found: #{filename}" unless File.exists?(filename)
transactions = CSV.read(ARGV.first)
CSV.open("#{File.basename(filename, '.csv')}_new.csv", 'w') do |csv|
  transactions.each do |line|
    [0, 1].each do |index|
      line[index].gsub!('-', '.')
    end
    [3, 4].each do |index|
      line[index].gsub!(',', '')
      line[index].sub!('.', ',')
    end
    csv << line
  end
end