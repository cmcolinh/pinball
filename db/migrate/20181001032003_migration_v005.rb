class MigrationV005 < ActiveRecord::Migration[5.1]
  def up
    ActiveRecord::Base.connection.execute <<-SQL
      CREATE TABLE `randomtournamentmatchup` (
        `matchNum` INT(11) NOT NULL,
        `playerNum` INT(11) NOT NULL,
        `numPlayers` INT(11) NOT NULL,
        `numrounds` INT(11) NOT NULL,
        UNIQUE KEY `randomtournamentmatchup_players_rounds_match` (`matchNum`, `playerNum`, `numPlayers`, `numrounds`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8
    SQL
  end
  def down
    ActiveRecord::Base.connection.execute <<-SQL
      DROP TABLE `randomtournamentmatchup`
    SQL
  end
end

