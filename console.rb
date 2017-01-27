require './models/Customers.rb'
require './models/Films.rb'
require './models/Tickets.rb'

require './db/SqlRunner'

require 'pry-byebug'

customer1 = Customer.new({ 'name' => 'Jim Baxter', 'funds' => 20})
customer2 = Customer.new({ 'name' => 'Billy Bremner', 'funds' => 20})
customer3 = Customer.new({ 'name' => 'Matt Busby', 'funds' => 20})
customer4 = Customer.new({ 'name' => 'Kenny Dalglish', 'funds' => 20})
customer5 = Customer.new({ 'name' => 'Alex Ferguson', 'funds' => 20})
customer6 = Customer.new({ 'name' => 'Hughie Gallagher', 'funds' => 2_000_000})

customer1.save
customer2.save
customer3.save
customer4.save
customer5.save
customer6.save

# the films listed below are taken from https://en.wikipedia.org/wiki/List_of_films_considered_the_worst#1950s and in no way reflect my personal taste :)
film1 = Film.new({'title' => 'Glen or Glenda', 'price' => 7, 'remaining' => 3})
film2 = Film.new({'title' => 'Robot Monster', 'price' => 7,'remaining' => 3})
film3 = Film.new({'title' => 'Bride of the Monster', 'price' => 7, 'remaining' => 3})

film1.save
film2.save
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.customer_id, 'film_id' => film1.film_id})
ticket2 = Ticket.new({'customer_id' => customer5.customer_id, 'film_id' => film3.film_id})
ticket3 = Ticket.new({'customer_id' => customer2.customer_id, 'film_id' => film3.film_id})
ticket4 = Ticket.new({'customer_id' => customer1.customer_id, 'film_id' => film2.film_id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save

binding.pry
nil
