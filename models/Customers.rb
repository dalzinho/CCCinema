class Customer

  attr_reader :customer_id
  attr_accessor :name, :funds

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *;"
    customer = SqlRunner.run(sql).first
    @customer_id = customer['customer_id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers;"
    SqlRunner.run(sql).map { |customer| Customer.new(customer)}
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{@funds}) WHERE customer_id = #{@customer_id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = 'DELETE FROM customers;'
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE customer_id = #{@customer_id};"
    SqlRunner.run(sql)
  end

  def buy_ticket(film_id, quantity)
    film = Film.get_by_id(film_id)
    if quantity <= film.remaining
      unless quantity * film.price > @funds
        quantity.times do
          Ticket.new({'customer_id' => @customer_id, 'film_id' => film_id}).save
          @funds -= film.price
          film.ticket_sold
          self.update()
        end
      else return "Sorry, insufficient funds!"
      end
    else return "Sorry, not enough tickets left!"
    end
  end

  def ticket_count()
    sql ="SELECT * FROM tickets WHERE customer_id = '#{@customer_id}';"
    result = SqlRunner.run(sql)
    return result.count
  end

  def history()
    # db query; will require a join of tickets and films
    sql = "SELECT f.title, t.showtime FROM films f INNER JOIN tickets t ON f.film_id = t.film_id WHERE t.customer_id = #{@customer_id};"
    SqlRunner.run(sql).map { |item| History.new(item) }


    # iterate through the tuple to give a list
    # create class for response
  end

end