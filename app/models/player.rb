class Player
  def self.exist?(name)
    ActiveRecord::Base.connection.invoke_function(
      :playerNameExists, name).eql?(1)
  end
end

