class Competition
  attr_accessor :name
  attr_accessor :basepath

  def self.generate(name, scoring_scheme)
    comp_id = ActiveRecord::Base.connection.invoke_function(:generateNewCompetition, name)

    create_new(name, comp_id)
  end

  def exist?(name)
    ActiveRecord::Base.connection.invoke_function(:competitionNameExists, name).eql?(1)
  end

  def self.find_by_name(name)
    begin
      comp_id = ActiveRecord::Base.connection.invoke_function(
        :getCompetitionNumberForCompetition, self.name)

      create_new(name, comp_id)
    rescue StandardError < e
      nil
    end
  end

  def self.all
    ActiveRecord::Base.connection.execute_procedure(:listCompetitions).map{|a| a.first}
  end

  def setup(type)
    if type.eql?(:random_matchup)
      ActiveRecord::Base.connection.invoke_function(:generateRandomMatchupTournament, self.id)
    end
  end

  def players
    ActiveRecord::Base.connection.execute_procedure(
      :getPlayerNamesInCompetition, @id)
  end

  def games
    ActiveRecord::Base.connection.execute_

  def enrollPlayer(player, seed)
    ActiveRecord::Base.connection.execute_procedure(
      :enrollPlayerToCompetition, player, @id, seed)
  end

  private
  def self.create_new(name, id)
    c      = self.new
    c.@id  = id
    c.name = name
    c
  end
end

