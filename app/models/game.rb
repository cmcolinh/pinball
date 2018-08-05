class Game
  attr_accessor :name

  def self.generate(name)
    game_id = ActiveRecord::Base.connection.invoke_function(:addGame, name)

    create_new(name, game_id)
  end

  def self.exists?(name)
    ActiveRecord::Base.connection.invoke_function(:gameNameExists, name).eql?(1)
  end

  private
  def self.create_new(name, id)
    g      = self.new
    g.@id  = id
    g.name = name
  end

  def id
    @id ||= ActiveRecord::Base.connection.invoke_function(:getGameNumberForGame, self.name)
  end
end

