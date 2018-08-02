class MigrationV002 < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE PROCEDURE listCompetitions()
      BEGIN
        SELECT name FROM tblcompetition;
      END
    SQL
  end

  def down
    execute "DROP PROCEDURE listCompetitions"
  end
end
