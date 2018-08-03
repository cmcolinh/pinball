class Competition
  attr_accessor :id
  attr_accessor :name
  attr_accessor :basepath

  def self.generate(name, scoring_scheme)
    comp_id = ActiveRecord::Base.connection.invoke_function(:generateNewCompetition, name)

    c          = self.new
    c.id       = comp_id
    c.name     = name
    c.basepath = nil
    c
  end

  def self.find_by_name(name)
    begin
      ActiveRecord::Base.connection.invoke_function(:getCompetitionNumberForCompetition, self.name)
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
end

