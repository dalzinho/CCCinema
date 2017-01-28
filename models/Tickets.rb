class Ticket

  attr_reader :ticket_id
  attr_accessor :customer_id, :film_id, :showtime

  def initialize(options)
    @ticket_id = options['ticket_id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @showtime = options['showtime']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, showtime) VALUES (#{customer_id}, #{film_id}, '#{@showtime}') RETURNING *;"
    ticket = SqlRunner.run(sql).first
    @ticket_id = ticket['ticket_id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets;"
    SqlRunner.run(sql).map { |ticket| Ticket.new(ticket)}
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id) = (#{@customer_id}, #{@film_id}) WHERE ticket_id = #{@ticket_id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE ticket_id = #{@ticket_id};"
    SqlRunner.run(sql)
  end

end