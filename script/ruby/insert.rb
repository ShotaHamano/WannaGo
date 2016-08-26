require 'mysql2'

client = Mysql2::Client.new(:host => 'localhost', :username => 'root')
query = %q{insert into rubytest.languages values (4, 'PHP')}
results = client.query(query)

query = %q{select * from rubytest.languages}
results = client.query(query)
results.each do |row|
  puts "--------------------"
  row.each do |key, value|
    puts "#{key} => #{value}"
  end
end