class Film

  attr_reader :film_id
  attr_accessor :title, :price

  def initialize(options)
    @film_id = options['film_id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()

    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *;"
    film = SqlRunner.run(sql).first
    @film_id = film['film_id'].to_i

  end

  def self.all()
    sql = "SELECT * FROM films;"
    SqlRunner.run(sql).map { |film| Film.new(film)}
  end

  def update()
    sql = "UPDATE films SET (title, price) = ('#{@title}', #{price}) WHERE film_id = #{@film_id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE film_id = #{@film_id};"
    SqlRunner.run(sql)
  end

  def self.get_by_id(search_id)
    sql = "SELECT * FROM films WHERE film_id = #{search_id};"
    SqlRunner.run(sql).first
  end

  def how_many_customers()
    sql = "SELECT * from tickets WHERE film_id = #{@film_id};"
    return SqlRunner.run(sql).count
    
  end

end