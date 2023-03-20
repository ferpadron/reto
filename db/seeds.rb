# frozen_string_literal: true

##
# You can run any times this seed file
#

# random_name is useful for Test Coverage (testing), never mind in development
random_name = 2.times.map { (2..10).map { ('a'..'z').to_a[rand(26)] }.join.capitalize }.join(' ')

clients = [{ name: 'Karla Smith', zip: '29000', country: 'MX' }, { name: 'Joe Douglas', zip: '05500', country: 'MX' },
           { name: 'Sophie Kenneth', zip: '97000', country: 'MX' }, { name: 'Louis Zu', zip: '02420', country: 'MX' },
           { name: random_name, zip: '00400', country: 'US' }]

clients.each do |c|
  client = Client.find_or_initialize_by(name: c[:name])
  if client.new_record?
    client.assign_attributes(c)
    client.save
    puts "Client '#{client.name}' created"
  else
    client.update(c)
    puts "Client '#{client.name}' updated"
  end

  items = [{ name: "#{client.name} First item", length: 25.0, width: 28.0, height: 46.0, weight: 6.5 },
           { name: "#{client.name} Second item", length: 20.456, width: 31.567, height: 50.015, weight: 8.235 }]

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
end
