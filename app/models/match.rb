class Match
  attr_accessor :id

  def self.generate(match_num, scoring_scheme)
    ActiveRecord::Base.connection.invoke_function(:createMatch, match_num, scoring_scheme)

    m    = self.new
    m.id = match_num
  end

  def self.exist?(match_num)
    ActiveRecord::Base.connection.invoke_function(:matchNumExists, match_num).eql?(1)
  end

  def players
    ActiveRecord::Base.connection.execute_procedure(:getPlayerNamesInMatch, self.id)
  end

  def game=(game)
    game_name = game.is_a?(Game) ? game.name : game
    ActiveRecord::Base.connection.execute_procedure(:assignGameToMatch, self.id, game_name)
  end
end
