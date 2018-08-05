class MigrationV003 < ActiveRecord::Migration[5.1]
  def up
    execute "DROP PROCEDURE addGame"
    execute <<-SQL
      CREATE FUNCTION addGame(
        name VARCHAR(40)) RETURNS tinyint(1)
      BEGIN
        IF (gameNameExists(name) = 0)
	THEN
	  INSERT INTO tblgame(gamename)
	    SELECT name;
	  RETURN LAST_INSERT_ID();
	END IF;
	RETURN NULL;
      END
    SQL
  end

  def down
    execute "DROP FUNCTION addGame"
    execute <<-SQL
      CREATE PROCEDURE addGame(
        IN name VARCHAR(40))
      BEGIN
        IF (gameNameExists(name) = 0)
	THEN
          INSERT INTO tblgame(gamename, ones)
	    SELECT name, 0;
	END IF;
      END
    SQL
  end
end


