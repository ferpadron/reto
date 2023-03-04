# frozen_string_literal: true

##
# You can run any times this seed file
#

# If you change the name, another Client will be created
client = Client.find_or_initialize_by(name: 'First client is for testing here')
if client.new_record?
  client.save
  puts 'Test client created'
else
  puts 'The test client was not changed because it already exists'
end

# If you change the name, another Item for above Client will be created
# If you change rest of values, Item will be updated only
items = [{name: 'First item', length: 25.0, width: 28.0, height: 46.0, weight: 6.5},
         {name: 'Second item', length: 20.456, width: 31.567, height: 50.015, weight: 8.235}]

items.each do |item|
  i = client.items.find_or_initialize_by(name: item[:name])
  if i.new_record?
    i.assign_attributes(item)
    i.save
    puts "Item '#{i.name}' for Client: '#{client.name}' created"
  else
    i.update(item)
    puts "Item '#{i.name}' updated"
  end
end
