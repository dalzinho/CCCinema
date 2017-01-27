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
    price = Film.get_by_id(film_id)['price'].to_i

    unless quantity * price > @funds
      quantity.times do
        new_ticket = Ticket.new({'customer_id' => @customer_id, 'film_id' => film_id}).save
        @funds -= price
        self.update()
      end
    else return "Sorry, insufficient funds!"
    end
  end

  def ticket_count()
    sql ="SELECT * FROM tickets WHERE customer_id = '#{@customer_id}'"
    result = SqlRunner.run(sql)
    return result.count
  end

end