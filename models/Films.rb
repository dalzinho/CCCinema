class Film

  attr_reader :film_id
  attr_accessor :title, :price, :remaining

  def initialize(options)
    @film_id = options['film_id'].to_i
    @title = options['title']
    @price = options['price'].to_i
    @remaining = options['remaining'].to_i
  end

  def save()

    sql = "INSERT INTO films (title, price, remaining) VALUES ('#{@title}', #{@price}, #{@remaining}) RETURNING *;"
    film = SqlRunner.run(sql).first
    @film_id = film['film_id'].to_i

  end

  def self.all()
    sql = "SELECT * FROM films;"
    SqlRunner.run(sql).map { |film| Film.new(film)}
  end

  def update()
    sql = "UPDATE films SET (title, price, remaining) = ('#{@title}', #{price}, #{@remaining}) WHERE film_id = #{@film_id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE film_id = #{@film_id};"
    SqlRunner.run(sql)
  end

  def self.get_by_id(search_id)
    sql = "SELECT * FROM films WHERE film_id = #{search_id};"
    Film.new(SqlRunner.run(sql).first)

  end

  def how_many_customers()
    sql = "SELECT * from tickets WHERE film_id = #{@film_id};"
    return SqlRunner.run(sql).count
  end


  def ticket_sold()
    @remaining -= 1
    self.update()
  end

  def busiest_time()
    
    sql = "SELECT mode() WITHIN GROUP (ORDER BY showtime) AS showtime FROM tickets WHERE film_id = #{@film_id};"
    # you won't be surprised to learn that the query above came from a bit of googling. I think I get what it does, but don't ask me to do it again :D
    result = SqlRunner.run(sql).first
    return Ticket.new(result).showtime
    
  end

end