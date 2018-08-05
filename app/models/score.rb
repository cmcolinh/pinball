class Score
  def generate(match, player)
    ActiveRecord::Base.connection.invoke_function(
      :createScore, match.id, player.id)
  end
end
