class MigrationV001 < ActiveRecord::Migration[5.1]
  def up
    create_table :tblcompetition, id: false do |t|
      t.primary_key :_key, :integer
      t.string  :name,     limit: 100, null: false
      t.string  :basepath, limit: 100
      t.index   :name,     unique: true
    end

    create_table :tblgame, id: false do |t|
      t.primary_key :_key, :integer
      t.string  :gamename, null: false, limit: 40
      t.integer :ones,     null: false, limit: 4
      t.index   :gamename, unique: true
    end

    create_table :tblscoringscheme, id: false do |t|
      t.primary_key :_key,    :integer
      t.string  :description, null: false, limit: 40
    end

    create_table :tblmatch, id: false do |t|
      t.primary_key :_key,           :integer
      t.integer  :_fk_game,          null: false
      t.integer  :_fk_scoringscheme, null: false
    end
    add_foreign_key :tblmatch, :tblgame,          column: :_fk_game, primary_key: :_key, name: 'match_to_game_fk'
    add_foreign_key :tblmatch, :tblscoringscheme, column: :_fk_scoringscheme, primary_key: :_key, name: 'scoringscheme_to_match_fk'

    create_table :tblplayer, id: false do |t|
      t.primary_key :_key,   :integer
      t.string      :name,   null: false, limit: 40
      t.integer     :report, null: false
    end

    create_table :tblscoreset, id: false do |t|
      t.primary_key :_key,        :integer
      t.integer  :_fk_player,      null: false
      t.integer  :_fk_competition, null: false
    end
    add_foreign_key :tblscoreset, :tblplayer,      column: :_fk_player,      primary_key: :_key, name: 'scoreset_to_player_fk'
    add_foreign_key :tblscoreset, :tblcompetition, column: :_fk_competition, primary_key: :_key, name: 'scoreset_to_competition_fk'

    create_table :tblscore, id: false do |t|
      t.primary_key :_key,     :integer
      t.integer :_fk_player,   null: false
      t.integer :_fk_match,    null: false
      t.integer :_fk_scoreset, null: false
      t.integer :score,        null: false
      t.integer :rank,                      limit: 6
      t.integer :points,                    limit: 4
    end
    add_foreign_key :tblscore, :tblplayer,   column: :_fk_player,   primary_key: :_key,  name: 'score_to_player_fk'
    add_foreign_key :tblscore, :tblmatch,    column: :_fk_match,    primary_key: :_key,  name: 'score_to_match_fk'
    add_foreign_key :tblscore, :tblscoreset, column: :_fk_scoreset, primary_key: :_key,  name: 'score_to_scoreset_fk'

    create_table :tblscoring, id: false do |t|
      t.primary_key :_key,          :integer
      t.integer :_fk_scoringscheme, null: false
      t.integer :numplayers,        null: false
      t.integer :rank,              null: false
      t.integer :pointsforrank,     null: false
    end
    add_foreign_key :tblscoring, :tblscoringscheme, column: :_fk_scoringscheme, primary_key: :_key, name: 'scoring_to_scoringscheme_fk'

    create_table :tblbonusscoring, id: false do |t|
      t.primary_key :_key,    :integer
      t.integer :_fk_scoring, null: false
      t.integer :bonuspoints, null: false
      t.string  :cond,        null: false, limit: 10000
    end
    add_foreign_key :tblbonusscoring, :tblscoring, column: :_fk_scoring, primary_key: :_key, name: 'bonusscoring_to_scoring_fk'

    create_table :tblwebsitegenerator, id: false do |t|
      t.primary_key :_key,        :integer
      t.integer :_fk_competition, null: false
      t.string :filename,         null: false, limit: 40
      t.string :filedef,          null: false, limit: 10000
    end
    add_foreign_key :tblwebsitegenerator, :tblcompetition, column: :_fk_competition, primary_key: :_key, name: 'websitegenerator_to_competition_fk'

    create_table :tblcompetitionenrollment, id: false do |t|
      t.primary_key :_key,        :integer
      t.integer :_fk_competition, null: false
      t.integer :_fk_player,      null: false
      t.integer :seed
      t.integer :report,          null: false
      t.index   [:_fk_competition, :_fk_player], unique: true, name: 'competitionenrollment_competition_player_uk'
    end
    add_foreign_key :tblcompetitionenrollment, :tblcompetition, column: :_fk_competition, primary_key: :_key, name: 'competitionenrollment_to_competition_fk'
    add_foreign_key :tblcompetitionenrollment, :tblplayer, column: :_fk_player, primary_key: :_key, name: 'competitionenrollment_to_player_fk'

    create_table :tblcompetitionadvancementscript, id: false do |t|
      t.primary_key :_key,        :integer
      t.integer :_fk_competition, null: false
      t.integer :step,            null: false
      t.string  :command,         null: false, limit: 10000
      t.integer :active,          null: false, limit: 1
      t.index   [:_fk_competition, :step], unique: true, name: 'competionadvancementscript_competition_step_uk'
    end
    add_foreign_key :tblcompetitionadvancementscript, :tblcompetition, column: :_fk_competition, primary_key: :_key, name: 'competitionadvancementscript_to_competition_fk'

    create_table :tblattributename, id: false do |t|
      t.primary_key :_key,           :integer
      t.string  :attrname,           null: false, limit: 40
      t.string  :description,        null: false, limit: 40
      t.integer :playernotnull,      null: false, limit: 1
      t.integer :gamenotnull,        null: false, limit: 1
      t.integer :competitionnotnull, null: false, limit: 1
      t.string  :regex,              null: false, limit: 10000, default: '.{1,40}'
      t.index [:attrname, :playernotnull, :gamenotnull, :competitionnotnull], unique: true, name: 'attributevalue_player_game_competition_notnull_uk'
    end

    create_table :tblattributevalue, id: false do |t|
      t.primary_key :_key,    :integer
      t.integer  :_fk_player
      t.integer  :_fk_game
      t.integer  :_fk_competition
      t.integer  :_fk_attributename
      t.string   :attrvalue, null: false, limit: 40
      t.datetime :startdate, null: false
      t.datetime :enddate, null: false, default: '9999-12-31 23:59:59'
    end
    add_foreign_key :tblattributevalue, :tblattributename, column: :_fk_attributename, primary_key: :_key, name: 'attributevalue_to_attributename_fk'
    add_foreign_key :tblattributevalue, :tblplayer, column: :_fk_player, primary_key: :_key, name: 'attributevalue_to_player_fk'
    add_foreign_key :tblattributevalue, :tblgame, column: :_fk_game, primary_key: :_key, name: 'attributevalue_to_game_fk'
    add_foreign_key :tblattributevalue, :tblcompetition, column: :_fk_competition, primary_key: :_key, name: 'attribute_value_to_competition_fk'

    create_table :tempScore, id: false do |t|
      t.primary_key :_key,   :integer
      t.integer :_fk_player
      t.integer :_fk_match
      t.integer :_fk_scoreset
      t.bigint  :score
      t.integer :rank
      t.integer :points
      t.integer :session_id,   null: false
    end
    add_foreign_key :tempScore, :tblplayer,   column: :_fk_player,   primary_key: :_key, name: 'tempscore_to_player_fk'
    add_foreign_key :tempScore, :tblmatch,    column: :_fk_match,    primary_key: :_key, name: 'tempscore_to_match_fk'
    add_foreign_key :tempScore, :tblscoreset, column: :_fk_scoreset, primary_key: :_key, name: 'tempscore_to_scoreset_fk'

    create_table :tempattributevalue, id: false do |t|
      t.integer  :_fk_player
      t.integer  :_fk_game
      t.integer  :_fk_competition
      t.integer  :_fk_attributename, null: false
      t.string   :attrvalue,         null: false, limit: 41
      t.datetime :startdate,         null: false
      t.datetime :enddate,           null: false, default: '9999-12-31 23:59:59'
      t.integer  :session_id,        null: false
    end
    add_foreign_key :tempattributevalue, :tblattributename, column: :_fk_attributename, primary_key: :_key, name: 'tempattributevalue_to_attributename_fk'
    add_foreign_key :tempattributevalue, :tblplayer, column: :_fk_player, primary_key: :_key, name: 'tempattributevalue_to_player_fk'
    add_foreign_key :tempattributevalue, :tblgame, column: :_fk_game, primary_key: :_key, name: 'tempattributevalue_to_game_fk'
    add_foreign_key :tempattributevalue, :tblcompetition, column: :_fk_competition, primary_key: :_key, name: 'tampattributevalue_to_competition_fk'
    execute <<-SQL
      CREATE PROCEDURE addPlayer(
        IN playerName VARCHAR(40))
      BEGIN

      IF (playerNameExists(playerName) = 0)
      THEN
      INSERT INTO tblplayer(name, report)
        SELECT playerName, 1;
      ELSE
      UPDATE tblplayer SET report = 1 WHERE NAME = playerName;
      END IF;

      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE removePlayer(
	IN playerName VARCHAR(40))
      BEGIN
      UPDATE tblplayer SET report = 0 WHERE name = playerName;
      END
    SQL
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
    execute <<-SQL
      CREATE PROCEDURE getGameNamesInCompetition(
	IN competitionNumber smallint)
      BEGIN
        SELECT
	  g.gamename
	FROM
	  tblgame g
	JOIN
	  tblattributevalue av ON g._key = av._fk_game
	WHERE
	  av.enddate IS NULL
	  AND av._fk_competition = competitionNumber
	  AND av.attrname = 'gameInCompetition'
	  AND av.attrvalue = 'Y';
      END
    SQL
    execute <<-SQL
      CREATE TRIGGER forNewPlayers
      AFTER INSERT ON tblplayer
      FOR EACH ROW
      BEGIN
        INSERT INTO
          tempattributevalue (_fk_player, _fk_attributename, attrvalue, startdate, enddate, session_id)
        VALUES (
          NEW._key
          ,(SELECT _key FROM tblattributename WHERE attrname = 'playerName' AND playernotnull = 1 AND gamenotnull = 0 AND competitionnotnull = 0)
          ,NEW.name
          ,CONVERT_TZ(NOW(), @@session.time_zone, '+00:00')
          ,NULL
          ,connection_id());
        INSERT INTO
          tempattributevalue (_fk_player, _fk_attributename, attrvalue, startdate, enddate, session_id)
        VALUES
          (NEW._key
          ,(SELECT _key FROM tblattributename WHERE attrname = 'playerActive' AND playernotnull = 1 AND gamenotnull = 0 AND competitionnotnull = 0)
          ,CASE NEW.report WHEN 1 THEN 'Y' ELSE 'N' END
          ,CONVERT_TZ(NOW(), @@session.time_zone, '+00:00')
          ,NULL
          ,connection_id()
        );
        DELETE FROM tempattributevalue WHERE session_id = connection_id();
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER forAlteredPlayers
      BEFORE UPDATE ON tblplayer
      FOR EACH ROW
      BEGIN
        INSERT INTO tempattributevalue(
          _fk_player
          ,_fk_attributename
          ,attrvalue
          ,startdate
          ,enddate
          ,session_id)
        VALUES(
          NEW._key
          ,(SELECT _key FROM tblattributename WHERE attrname = 'playerName' AND playernotnull = 1 AND gamenotnull = 0 AND competitionnotnull = 0)
          ,NEW.name
          ,CONVERT_TZ(NOW(), @@session.time_zone, '+00:00')
          ,NULL,
          connection_id());
        INSERT INTO tempattributevalue(
          _fk_player
          ,_fk_attributename,
          attrvalue,
          startdate,
          enddate,
          session_id)
        VALUES(
          NEW._key
          ,(SELECT _key FROM tblattributename WHERE attrname = 'playerActive' AND playernotnull = 1 AND gamenotnull = 0 AND competitionnotnull = 0)
          ,CASE NEW.report WHEN 1 THEN 'Y' ELSE 'N' END
          ,CONVERT_TZ(NOW(), @@session.time_zone, '+00:00')
          ,NULL
          ,connection_id());
        DELETE FROM
          tempattributevalue
        WHERE
          session_id = connection_id();
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER forNewGames
      BEFORE INSERT ON tblgame
      FOR EACH ROW
      BEGIN
        INSERT INTO tempattributevalue(
          _fk_game
          ,_fk_attributename
          ,attrvalue
          ,startdate
          ,enddate
          ,session_id)
        VALUES(
          NEW._key
          ,(SELECT _key FROM tblattributename WHERE attrname = 'gameName' AND playernotnull = 0 AND gamenotnull = 1 AND competitionnotnull = 0)
          ,NEW.gamename
          ,CONVERT_TZ(NOW(), @@session.time_zone, '+00:00')
          ,NULL
          ,connection_id());
        DELETE FROM
          tempattributevalue
        WHERE
          session_id = connection_id();
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER forAlteredGames
      BEFORE UPDATE ON tblgame
      FOR EACH ROW
      BEGIN
        INSERT INTO tempattributevalue(
          _fk_game
          ,_fk_attributename
          ,attrvalue
          ,startdate
          ,enddate
          ,session_id)
        VALUES(
          NEW._key
          ,(SELECT _key FROM tblattributename WHERE attrname = 'gameName' AND playernotnull = 0 AND gamenotnull = 1 AND competitionnotnull = 0)
          ,NEW.gamename
          ,CONVERT_TZ(NOW(), @@session.time_zone, '+00:00')
          ,NULL
          ,connection_id());
        DELETE FROM
          tempattributevalue
        WHERE
          session_id = connection_id();
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER updateAttributeValues
      AFTER INSERT ON tempattributevalue
      FOR EACH ROW
      BEGIN
        IF (!   (NEW.attrvalue IS NOT NULL
          AND (NEW._fk_player IS NOT NULL) = (SELECT playernotnull FROM tblattributename WHERE _key = NEW._fk_attributename)
          AND (NEW._fk_game IS NOT NULL) = (SELECT gamenotnull FROM tblattributename WHERE _key = NEW._fk_attributename)
          AND (NEW._fk_game IS NOT NULL) = (SELECT gamenotnull FROM tblattributename WHERE _key = NEW._fk_attributename)
          AND (NEW._fk_competition IS NOT NULL) = (SELECT competitionnotnull FROM tblattributename WHERE _key = NEW._fk_attributename) ) )
        THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'the types of entities associated with the attribute value do not match the specification of the attribute name';
        END IF;
        IF (NEW.attrvalue NOT RLIKE (SELECT regex FROM tblattributename WHERE _key = NEW._fk_attributename))
        THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'attempting to set a value that is invalid according to the specification';
        END IF;
        UPDATE
          tblattributevalue
        SET
          enddate = NEW.startdate
        WHERE
          _fk_player <=> NEW._fk_player
          AND _fk_game <=> NEW._fk_game
          AND _fk_competition <=> NEW._fk_competition
          AND _fk_attributename = NEW._fk_attributename
          AND attrvalue != NEW.attrvalue
          AND enddate IS NULL;
        IF (
          SELECT NOT EXISTS
            (
              SELECT
                *
              FROM
                tblattributevalue
              WHERE
                _fk_player <=> NEW._fk_player
                AND _fk_game <=> NEW._fk_game
                AND _fk_competition <=> NEW._fk_competition
                AND _fk_attributename = NEW._fk_attributename
                AND attrvalue = NEW.attrvalue AND enddate IS NULL
            ) = 1)
        THEN
          INSERT INTO
            tblattributevalue (_fk_player, _fk_game, _fk_competition, _fk_attributename, attrvalue, startdate, enddate)
          VALUES (
            NEW._fk_player
            ,NEW._fk_game
            ,NEW._fk_competition
            ,NEW._fk_attributename
            ,NEW.attrvalue
            ,NEW.startdate
            ,NEW.enddate);
        END IF;
      END;
    SQL
    execute <<-SQL
      CREATE TRIGGER guardAttributeValueInserts
      BEFORE INSERT ON tblattributevalue
      FOR EACH ROW
      BEGIN
	IF
	  (
	    SELECT NOT EXISTS
	      (
	        SELECT
	          1
	        FROM
	          tempattributevalue
	        WHERE _fk_player <=> NEW._fk_player
	        AND _fk_game <=> NEW._fk_game
	        AND _fk_competition <=> NEW._fk_competition
	        AND _fk_attributename <=> NEW._fk_attributename
	        AND attrvalue <=> NEW.attrvalue
	        AND startdate <=> NEW.startdate
	        AND enddate <=> NEW.enddate
	      ) = 1
	   )
	THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'not setting this attribute value in the proper manner';
        END IF;
      END;
    SQL
    execute <<-SQL
      CREATE PROCEDURE enterScoreByMatchNumberAndName(
        IN matchNum smallint, IN playerName VARCHAR(40), IN gameScore bigint)
      BEGIN
        CALL enterScore (
          (
            SELECT
              s._key
            FROM
              tblscore s
              JOIN tblplayer p ON s._fk_player = p._key
            WHERE
              s._fk_match = matchNum
              AND p.name = playerName
            ORDER BY
              s._KEY DESC LIMIT 1
          )
          ,gameScore
        );
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE enterScore(
        IN scoreNum smallint, IN gameScore bigint)
      BEGIN
	
        DECLARE numPlayers int(4);
        DECLARE score int(4);
        DECLARE done BOOLEAN DEFAULT 0;

        DECLARE
          scoreInMatch
          CURSOR FOR
            SELECT
              _key
            FROM
              tblscore
            WHERE
              _fk_match = (SELECT _fk_match FROM tblscore WHERE _key = scoreNum LIMIT 1);
          DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;

          DELETE FROM
            tempScore
          WHERE
            session_id = connection_id();

          INSERT INTO tempScore(_key, _fk_player, _fk_match, _fk_scoreset, score, rank, points, session_id)
            SELECT
              s._key
              ,s._fk_player
              ,s._fk_match
              ,s._fk_scoreset
              ,s.score
              ,0
              ,0
              ,connection_id()
            FROM
              tblscore s
            WHERE _fk_match = (SELECT _fk_match FROM tblscore WHERE _key = scoreNum LIMIT 1);
          UPDATE
            tempScore
          SET
            score = gameScore
          WHERE
            _key = scoreNum
            AND session_id = connection_id();

          DROP TEMPORARY TABLE IF EXISTS rank;
          CREATE TEMPORARY TABLE IF NOT EXISTS rank AS
          (SELECT _key, rank FROM
            (SELECT
              _key
              ,score
              ,@curRank:=IF(@prevRank = score, @curRank, @incRank) AS rank
              ,@incRank := @incRank + 1
              ,@prevRank := score
            FROM
              tempScore s
              ,(SELECT @curRank := 0, @prevRank := NULL, @incRank := 1 ) r
            WHERE
              s.score > 0
            ORDER BY
              s.score DESC
            ) t);

          DROP TEMPORARY TABLE IF EXISTS numPlayersTbl;
          CREATE TEMPORARY TABLE numPlayersTbl (ct smallint);
          INSERT INTO numPlayersTbl SELECT COUNT(*) from rank;

          UPDATE tempScore s JOIN rank r ON r._key = s._key SET s.rank = r.rank;

          SET numPlayers = (SELECT * from numPlayersTbl LIMIT 1);
          DROP TEMPORARY TABLE IF EXISTS numPlayersTbl;

          DROP TEMPORARY TABLE IF EXISTS bonusPoints;
          CREATE TEMPORARY TABLE bonusPoints (_key int(4), bonuspoints int(4));
          INSERT INTO bonusPoints
            SELECT
              s._key
              ,0
            FROM
              tempScore s
              JOIN rank r ON r._key = s._key
            WHERE
              s.session_id = connection_id();

          OPEN scoreInMatch;
          REPEAT
            FETCH scoreInMatch INTO score;
            IF(
              SELECT
                count(*)
              FROM
                tempScore s
  	        JOIN tblmatch m ON s._fk_match = m._key
  	        JOIN tblscoring sc ON sc._fk_scoringscheme = m._fk_scoringscheme
  	        JOIN tblbonusscoring bs ON bs._fk_scoring = sc._key
              WHERE
                s._key = score
	          AND sc.rank = s.rank
	          AND sc.numplayers = numPlayers > 0)
	      THEN
   	        CALL getBonusPoints(score, numPlayers);
   	      END IF;
          UNTIL done END REPEAT;
        CLOSE scoreInMatch;

        UPDATE
          tempScore s
          JOIN tblmatch m ON s._fk_match = m._key
          JOIN tblscoring ts ON ts._fk_scoringscheme = m._fk_scoringscheme
          JOIN rank r on r._key = s._key
          JOIN tblplayer p ON s._fk_player = p._key
          JOIN bonusPoints bp ON bp._key = s._key
        SET
          s.points = ts.pointsforrank + bp.bonuspoints
        WHERE
          ts.rank = s.rank
          AND (ts.numplayers = 0 OR ts.numplayers = numPlayers)
          AND session_id = connection_id();

        UPDATE
          tblscore s
          JOIN tempScore ts ON s._key = ts._key
        SET
          s.points = ts.points,
          s.score = ts.score,
          s.rank = ts.rank
        WHERE
          ts.session_id = connection_id()
          AND s._key = ts._key;

        DELETE FROM
          tempScore
        WHERE
          session_id = connection_id();
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE previewFourPlayerScoreEntry(
        IN matchNum smallint, IN player1Name VARCHAR(40), IN player1Score bigint, IN player2Name VARCHAR(40), IN player2Score bigint,
        IN player3Name VARCHAR(40), player3Score bigint, IN player4Name VARCHAR(40), IN player4Score bigint)
      BEGIN

        DECLARE numPlayers int(4);
        DECLARE score int(4);
        DECLARE done BOOLEAN DEFAULT 0;

        DECLARE scoreInMatch
        CURSOR FOR
          SELECT
            _key
          FROM
            tblscore
          WHERE
            _fk_match = matchNum;
        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
	
        DELETE FROM
          tempScore
        WHERE
          session_id = connection_id();

        INSERT INTO tempScore(_key, _fk_player, _fk_match, _fk_scoreset, score, rank, points, session_id)
          SELECT
            _key
            ,_fk_player
            ,_fk_match
            ,_fk_scoreset
            ,score
            ,0
            ,0
            ,connection_id()
          FROM
            tblscore
          WHERE
            _fk_match = matchNum;

        UPDATE
          tempScore ts
          JOIN tblplayer p ON ts._fk_player = p._key
        SET
          ts.score = player1Score
        WHERE
          p.name = player1Name
          AND session_id = connection_id();

        UPDATE
          tempScore ts
          JOIN tblplayer p ON ts._fk_player = p._key
        SET
          ts.score = player2Score
        WHERE
          p.name = player2Name
          AND session_id = connection_id();

        UPDATE
          tempScore ts
          JOIN tblplayer p ON ts._fk_player = p._key
        SET
          ts.score = player3Score
        WHERE
          p.name = player3Name
          AND session_id = connection_id();

        UPDATE
          tempScore ts
          JOIN tblplayer p ON ts._fk_player = p._key
        SET
          ts.score = player4Score
        WHERE
          p.name = player4Name
          AND session_id = connection_id();

        DROP TEMPORARY TABLE IF EXISTS rank;
        CREATE TEMPORARY TABLE IF NOT EXISTS rank AS
          (
            SELECT
              _key
              ,rank
            FROM
              (
                SELECT
                  _key
                  ,score
                  ,@curRank:=IF(@prevRank = score, @curRank, @incRank) AS rank
                  ,@incRank := @incRank + 1
                  ,@prevRank := score
                FROM
                  tempScore s
                  ,(SELECT @curRank := 0, @prevRank := NULL, @incRank := 1 ) r
                WHERE
                  s.score > 0
                ORDER BY
                  s.score DESC
              ) t
          );

        DROP TEMPORARY TABLE IF EXISTS numPlayersTbl;
        CREATE TEMPORARY TABLE numPlayersTbl (ct smallint);
        INSERT INTO numPlayersTbl SELECT COUNT(*) from rank;

        UPDATE
          tempScore s
          JOIN rank r ON r._key = s._key
        SET
          s.rank = r.rank
        WHERE
          session_id = connection_id();

        SET
          numPlayers = (SELECT * from numPlayersTbl LIMIT 1);
        DROP TEMPORARY TABLE IF EXISTS numPlayersTbl;

        DROP TEMPORARY TABLE IF EXISTS bonusPoints;
        CREATE TEMPORARY TABLE bonusPoints (_key int(4), bonuspoints int(4));
        INSERT INTO bonusPoints
          SELECT
            s._key
            ,0
          FROM
            tempScore s
            JOIN rank r ON r._key = s._key;

        OPEN scoreInMatch;
          REPEAT
            FETCH scoreInMatch INTO score;
            IF (
              SELECT
                count(*)
              FROM
                tempScore s
	          JOIN tblmatch m ON s._fk_match = m._key
	          JOIN tblscoring sc ON sc._fk_scoringscheme = m._fk_scoringscheme
	          JOIN tblbonusscoring bs ON bs._fk_scoring = sc._key
              WHERE
                s._key = score
	          AND sc.rank = s.rank
	          AND sc.numplayers = numPlayers > 0)
	      THEN
   	        CALL getBonusPoints(score, numPlayers);
   	      END IF;
          UNTIL done END REPEAT;
        CLOSE scoreInMatch;

        UPDATE
          tempScore s
          JOIN tblmatch m ON s._fk_match = m._key
          JOIN tblscoring ts ON ts._fk_scoringscheme = m._fk_scoringscheme
          JOIN rank r on r._key = s._key
          JOIN tblplayer p ON s._fk_player = p._key
          JOIN bonusPoints bp ON bp._key = s._key
        SET
          s.points = ts.pointsforrank + bp.bonuspoints
        WHERE
          ts.rank = s.rank
          AND (ts.numplayers = 0 OR ts.numplayers = numPlayers)
          AND session_id = connection_id();

        SELECT
          p.name
          ,FORMAT(s.score, 0) as score
          ,s.points
        FROM
          tempScore s
          JOIN tblplayer p ON s._fk_player = p._key
        WHERE
          p.name != 'bye';

        DELETE FROM
          tempScore
        WHERE
          session_id = connection_id();
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE getBonusPoints (
        IN scoreNum int(4), IN numPlayers int(4))
      BEGIN

        DECLARE done BOOLEAN DEFAULT 0;
        DECLARE matchNum int(4);
        DECLARE bonusCheck smallint(6);

        DECLARE bonus
        CURSOR FOR
          SELECT
            bs._key
          FROM
            tempScore s
  	    JOIN tblmatch m ON s._fk_match = m._key
  	    JOIN tblscoring sc ON sc._fk_scoringscheme = m._fk_scoringscheme
  	    JOIN tblbonusscoring bs ON bs._fk_scoring = sc._key
          WHERE
            s._key = scoreNum
  	    AND sc.rank = s.rank
  	    AND sc.numplayers = numPlayers;

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;

        UPDATE
          bonusPoints
        SET
          bonuspoints = 0
        WHERE
          _key = scoreNum;

        SET matchNum = (SELECT _fk_match from tempScore where _key = scoreNum);
        SET SESSION group_concat_max_len = 1000000;

        OPEN bonus;

          REPEAT

            FETCH bonus INTO bonusCheck;

            SET @S =
              (
                SELECT
                  cond
                FROM
                  tblbonusscoring
                WHERE
                  _key = bonusCheck
              );
            SET @ST = CONCAT('SELECT ((SELECT bs.bonuspoints FROM tempScore s JOIN tblmatch m ON s._fk_match = m._key JOIN tblscoring sc ON sc._fk_scoringscheme = m._fk_scoringscheme JOIN tblbonusscoring bs ON bs._fk_scoring = sc._key WHERE bs._key = bonusCheck AND s._key = scoreNum) * (', @S, ')) INTO @OUT');

            SET @ST = REPLACE(@ST, 'bonusCheck', bonusCheck);
            SET @ST = REPLACE(@ST, 'scoreNum', scoreNum);
            SET @ST = REPLACE(@ST, 'matchNum', matchNum);

            PREPARE stmt FROM @ST;
            EXECUTE stmt;

            if (! done) THEN
              UPDATE bonusPoints SET bonuspoints = bonuspoints + @OUT WHERE _key = scoreNum;
            END IF;


          UNTIL done END REPEAT;

        CLOSE bonus;
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION competitionNameExists(
        competitionName VARCHAR(100)) RETURNS tinyint(1)
      BEGIN
        RETURN
          (
            SELECT
              (
                SELECT
                  COUNT(*) AS my_bool
                FROM
                  tblcompetition
                WHERE
                  name = competitionName
              ) = 1 AS competitionNameExists
          );
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION createMatch(
        matchNum smallint, scoringScheme smallint) RETURNS smallint(6)
      BEGIN
        INSERT INTO
          tblmatch(_key, _fk_game, _fk_scoringscheme)
        VALUES (matchNum, getGameNumberForGame('TBD'), scoringScheme);

        RETURN matchNum;
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION createScore(
        matchNum smallint, playerNum smallint) RETURNS smallint(6)
      BEGIN
        INSERT INTO
          tblscore(_fk_match, _fk_player, score, rank, points)
        VALUES (matchNum, playerNum, 0, 0, 0);
        RETURN matchNum;
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION createScoreset(
        playerNum smallint, competitionNumber smallint) RETURNS smallint(6)
      BEGIN
        INSERT INTO
          tblscoreset(_fk_player, _fk_competition)
        VALUES (playerNum, competitionNumber);
        RETURN playerNum;
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION gameNameExists(
        name VARCHAR(40)) RETURNS tinyint(1)
      BEGIN
        RETURN
          (
            SELECT
              (
                SELECT
                  COUNT(*) AS my_bool
                FROM
                  tblgame
                WHERE gamename = name
              ) = 1 AS gameNameExists
          );
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION generateNewCompetition(
        competitionName VARCHAR(100)) RETURNS smallint(6)
      BEGIN
        INSERT INTO
          tblcompetition(name)
        VALUES (CONCAT(competitionName));
        RETURN LAST_INSERT_ID();
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION generateRandomMatchupTournament(
        competitionNumber smallint(6), scoringScheme smallint) RETURNS smallint(6)
      BEGIN
        SET SESSION group_concat_max_len = 1000000;

        DROP TEMPORARY TABLE IF EXISTS playerList;
        CREATE TEMPORARY TABLE IF NOT EXISTS playerList AS
          (
            SELECT
              p.*
            FROM
              tblplayer p
              JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key
            WHERE
              ce.report = 1
              AND ce._fk_competition = competitionNumber
            ORDER BY
              RAND()
          );
        IF (SELECT COUNT(*) FROM playerList) IN ('29', '30', '31', '32')
        THEN

          DROP TEMPORARY TABLE IF EXISTS matchList;

          DROP TEMPORARY TABLE IF EXISTS ab;
          CREATE TEMPORARY TABLE IF NOT EXISTS ab AS
            (
              SELECT
                @row := @row + 1 AS row
                ,(
                  SELECT
                    players.*
                  FROM
                    playerList players
                    JOIN tblcompetitionenrollment ce ON players._key = ce._fk_player
                  WHERE
                    ce._fk_competition = competitionNumber
                    AND ce.report = 1
                  )
                ,(SELECT @row := 0) r
            );
          UPDATE
            ab
          SET
            row = 31
          WHERE
            row = 18
            AND (SELECT COUNT(*) FROM playerList) < 31;

          UPDATE
            ab
          SET
            row = 30
          WHERE
            row = 9
            AND (SELECT COUNT(*) FROM playerList) < 30;

          UPDATE
            ab
          SET
            _key = getNewByePlayer()
          WHERE
            _key = NULL;

          UPDATE
            ab
          SET
            _key = createScoreset(_key, competitionNumber);

          DROP TEMPORARY TABLE IF EXISTS matchup;
          CREATE TEMPORARY TABLE IF NOT EXISTS matchup AS
            SELECT 101 as matchNum, 1 as playerNum UNION SELECT 101, 2 UNION SELECT 101, 3 UNION SELECT 101, 4 UNION SELECT 102, 5 UNION SELECT 102, 6 UNION SELECT 102, 7 UNION SELECT 102, 8 UNION SELECT 103, 9 UNION SELECT 103, 10 UNION SELECT 103, 11 UNION SELECT 103, 12 UNION SELECT 104, 13 UNION SELECT 104, 14 UNION SELECT 104, 15 UNION SELECT 104, 16 UNION SELECT 105, 17 UNION SELECT 105, 18 UNION SELECT 105, 19 UNION SELECT 105, 20 UNION SELECT 106, 21 UNION SELECT 106, 22 UNION SELECT 106, 23 UNION SELECT 106, 24 UNION SELECT 107, 25 UNION SELECT 107, 26 UNION SELECT 107, 27 UNION SELECT 107, 28 UNION SELECT 108, 29 UNION SELECT 108, 30 UNION SELECT 108, 31 UNION SELECT 108, 32 UNION SELECT 201, 1 UNION SELECT 201, 5 UNION SELECT 201, 9 UNION SELECT 201, 13 UNION SELECT 202, 2 UNION SELECT 202, 6 UNION SELECT 202, 10 UNION SELECT 202, 14 UNION SELECT 203, 3 UNION SELECT 203, 7 UNION SELECT 203, 11 UNION SELECT 203, 15 UNION SELECT 204, 4 UNION SELECT 204, 8 UNION SELECT 204, 12 UNION SELECT 204, 16 UNION SELECT 205, 17 UNION SELECT 205, 21 UNION SELECT 205, 25 UNION SELECT 205, 29 UNION SELECT 206, 18 UNION SELECT 206, 22 UNION SELECT 206, 26 UNION SELECT 206, 30 UNION SELECT 207, 19 UNION SELECT 207, 23 UNION SELECT 207, 27 UNION SELECT 207, 31 UNION SELECT 208, 20 UNION SELECT 208, 24 UNION SELECT 208, 28 UNION SELECT 208, 32 UNION SELECT 301, 1 UNION SELECT 301, 6 UNION SELECT 301, 11 UNION SELECT 301, 16 UNION SELECT 302, 2 UNION SELECT 302, 5 UNION SELECT 302, 12 UNION SELECT 302, 15 UNION SELECT 303, 3 UNION SELECT 303, 8 UNION SELECT 303, 9 UNION SELECT 303, 14 UNION SELECT 304, 4 UNION SELECT 304, 7 UNION SELECT 304, 10 UNION SELECT 304, 13 UNION SELECT 305, 17 UNION SELECT 305, 22 UNION SELECT 305, 27 UNION SELECT 305, 32 UNION SELECT 306, 18 UNION SELECT 306, 21 UNION SELECT 306, 28 UNION SELECT 306, 31 UNION SELECT 307, 19 UNION SELECT 307, 24 UNION SELECT 307, 25 UNION SELECT 307, 30 UNION SELECT 308, 20 UNION SELECT 308, 23 UNION SELECT 308, 26 UNION SELECT 308, 29 UNION SELECT 401, 1 UNION SELECT 401, 7 UNION SELECT 401, 17 UNION SELECT 401, 23 UNION SELECT 402, 2 UNION SELECT 402, 8 UNION SELECT 402, 18 UNION SELECT 402, 24 UNION SELECT 403, 3 UNION SELECT 403, 5 UNION SELECT 403, 19 UNION SELECT 403, 21 UNION SELECT 404, 4 UNION SELECT 404, 6 UNION SELECT 404, 20 UNION SELECT 404, 22 UNION SELECT 405, 9 UNION SELECT 405, 15 UNION SELECT 405, 25 UNION SELECT 405, 31 UNION SELECT 406, 10 UNION SELECT 406, 16 UNION SELECT 406, 26 UNION SELECT 406, 32 UNION SELECT 407, 11 UNION SELECT 407, 13 UNION SELECT 407, 27 UNION SELECT 407, 29 UNION SELECT 408, 12 UNION SELECT 408, 14 UNION SELECT 408, 28 UNION SELECT 408, 30 UNION SELECT 501, 1 UNION SELECT 501, 8 UNION SELECT 501, 19 UNION SELECT 501, 22 UNION SELECT 502, 2 UNION SELECT 502, 7 UNION SELECT 502, 20 UNION SELECT 502, 21 UNION SELECT 503, 3 UNION SELECT 503, 6 UNION SELECT 503, 17 UNION SELECT 503, 24 UNION SELECT 504, 4 UNION SELECT 504, 5 UNION SELECT 504, 18 UNION SELECT 504, 23 UNION SELECT 505, 9 UNION SELECT 505, 16 UNION SELECT 505, 27 UNION SELECT 505, 30 UNION SELECT 506, 10 UNION SELECT 506, 15 UNION SELECT 506, 28 UNION SELECT 506, 29 UNION SELECT 507, 11 UNION SELECT 507, 14 UNION SELECT 507, 25 UNION SELECT 507, 32 UNION SELECT 508, 12 UNION SELECT 508, 13 UNION SELECT 508, 26 UNION SELECT 508, 31 UNION SELECT 601, 1 UNION SELECT 601, 10 UNION SELECT 601, 18 UNION SELECT 601, 25 UNION SELECT 602, 2 UNION SELECT 602, 9 UNION SELECT 602, 17 UNION SELECT 602, 26 UNION SELECT 603, 3 UNION SELECT 603, 12 UNION SELECT 603, 20 UNION SELECT 603, 27 UNION SELECT 604, 4 UNION SELECT 604, 11 UNION SELECT 604, 19 UNION SELECT 604, 28 UNION SELECT 605, 5 UNION SELECT 605, 14 UNION SELECT 605, 22 UNION SELECT 605, 29 UNION SELECT 606, 6 UNION SELECT 606, 13 UNION SELECT 606, 21 UNION SELECT 606, 30 UNION SELECT 607, 7 UNION SELECT 607, 16 UNION SELECT 607, 24 UNION SELECT 607, 31 UNION SELECT 608, 8 UNION SELECT 608, 15 UNION SELECT 608, 23 UNION SELECT 608, 32 UNION SELECT 701, 1 UNION SELECT 701, 12 UNION SELECT 701, 21 UNION SELECT 701, 32 UNION SELECT 702, 2 UNION SELECT 702, 11 UNION SELECT 702, 22 UNION SELECT 702, 31 UNION SELECT 703, 3 UNION SELECT 703, 10 UNION SELECT 703, 23 UNION SELECT 703, 30 UNION SELECT 704, 4 UNION SELECT 704, 9 UNION SELECT 704, 24 UNION SELECT 704, 29 UNION SELECT 705, 5 UNION SELECT 705, 16 UNION SELECT 705, 17 UNION SELECT 705, 28 UNION SELECT 706, 6 UNION SELECT 706, 15 UNION SELECT 706, 18 UNION SELECT 706, 27 UNION SELECT 707, 7 UNION SELECT 707, 14 UNION SELECT 707, 19 UNION SELECT 707, 26 UNION SELECT 708, 8 UNION SELECT 708, 13 UNION SELECT 708, 20 UNION SELECT 708, 25 UNION SELECT 801, 1 UNION SELECT 801, 14 UNION SELECT 801, 20 UNION SELECT 801, 31 UNION SELECT 802, 2 UNION SELECT 802, 13 UNION SELECT 802, 19 UNION SELECT 802, 32 UNION SELECT 803, 3 UNION SELECT 803, 16 UNION SELECT 803, 18 UNION SELECT 803, 29 UNION SELECT 804, 4 UNION SELECT 804, 15 UNION SELECT 804, 17 UNION SELECT 804, 30 UNION SELECT 805, 5 UNION SELECT 805, 10 UNION SELECT 805, 24 UNION SELECT 805, 27 UNION SELECT 806, 6 UNION SELECT 806, 9 UNION SELECT 806, 23 UNION SELECT 806, 28 UNION SELECT 807, 7 UNION SELECT 807, 12 UNION SELECT 807, 22 UNION SELECT 807, 25 UNION SELECT 808, 8 UNION SELECT 808, 11 UNION SELECT 808, 21 UNION SELECT 808, 26
            ORDER BY matchNum, RAND();
        END IF;

        IF (SELECT COUNT(*) FROM playerList) IN ('33', '34', '35', '36')
        THEN
          DROP TEMPORARY TABLE IF EXISTS matchList;
          DROP TEMPORARY TABLE IF EXISTS ab;
          CREATE TEMPORARY TABLE IF NOT EXISTS ab AS
            (
              SELECT @row := @row + 1 as row
              ,players.* FROM playerList players
              ,(SELECT @row := 0) r
            );

          UPDATE
            ab
          SET
            row = 35
          WHERE
            row = 17
            AND (SELECT COUNT(*) FROM playerList) < 35;

          UPDATE
            ab
          SET
            row = 34
          WHERE
            row = 16
            AND (SELECT COUNT(*) FROM playerList) < 34;

          UPDATE
            ab
          SET
            _key = getNewByePlayer()
          WHERE
            _key = NULL;

          UPDATE
            ab
          SET
            _key = createScoreset(_key, competitionNumber);

          DROP TEMPORARY TABLE IF EXISTS matchup;
          CREATE TEMPORARY TABLE IF NOT EXISTS matchup AS
            SELECT 101 as matchNum, 1 as playerNum UNION SELECT 101, 2 UNION SELECT 101, 3 UNION SELECT 101, 4 UNION SELECT 102, 5 UNION SELECT 102, 6 UNION SELECT 102, 7 UNION SELECT 102, 8 UNION SELECT 103, 9 UNION SELECT 103, 10 UNION SELECT 103, 11 UNION SELECT 103, 12 UNION SELECT 104, 13 UNION SELECT 104, 14 UNION SELECT 104, 15 UNION SELECT 104, 16 UNION SELECT 105, 17 UNION SELECT 105, 18 UNION SELECT 105, 19 UNION SELECT 105, 20 UNION SELECT 106, 21 UNION SELECT 106, 22 UNION SELECT 106, 23 UNION SELECT 106, 24 UNION SELECT 107, 25 UNION SELECT 107, 26 UNION SELECT 107, 27 UNION SELECT 107, 28 UNION SELECT 108, 29 UNION SELECT 108, 30 UNION SELECT 108, 31 UNION SELECT 108, 32 UNION SELECT 109, 33 UNION SELECT 109, 34 UNION SELECT 109, 35 UNION SELECT 109, 36 UNION SELECT 201, 1 UNION SELECT 201, 5 UNION SELECT 201, 9 UNION SELECT 201, 13 UNION SELECT 202, 2 UNION SELECT 202, 6 UNION SELECT 202, 10 UNION SELECT 202, 17 UNION SELECT 203, 3 UNION SELECT 203, 7 UNION SELECT 203, 11 UNION SELECT 203, 21 UNION SELECT 204, 4 UNION SELECT 204, 8 UNION SELECT 204, 12 UNION SELECT 204, 25 UNION SELECT 205, 14 UNION SELECT 205, 18 UNION SELECT 205, 22 UNION SELECT 205, 29 UNION SELECT 206, 15 UNION SELECT 206, 19 UNION SELECT 206, 23 UNION SELECT 206, 33 UNION SELECT 207, 16 UNION SELECT 207, 26 UNION SELECT 207, 30 UNION SELECT 207, 34 UNION SELECT 208, 20 UNION SELECT 208, 27 UNION SELECT 208, 31 UNION SELECT 208, 35 UNION SELECT 209, 24 UNION SELECT 209, 28 UNION SELECT 209, 32 UNION SELECT 209, 36 UNION SELECT 301, 1 UNION SELECT 301, 6 UNION SELECT 301, 11 UNION SELECT 301, 25 UNION SELECT 302, 2 UNION SELECT 302, 7 UNION SELECT 302, 9 UNION SELECT 302, 16 UNION SELECT 303, 3 UNION SELECT 303, 5 UNION SELECT 303, 10 UNION SELECT 303, 20 UNION SELECT 304, 4 UNION SELECT 304, 14 UNION SELECT 304, 21 UNION SELECT 304, 33 UNION SELECT 305, 8 UNION SELECT 305, 15 UNION SELECT 305, 18 UNION SELECT 305, 32 UNION SELECT 306, 12 UNION SELECT 306, 13 UNION SELECT 306, 17 UNION SELECT 306, 22 UNION SELECT 307, 19 UNION SELECT 307, 27 UNION SELECT 307, 30 UNION SELECT 307, 36 UNION SELECT 308, 23 UNION SELECT 308, 28 UNION SELECT 308, 31 UNION SELECT 308, 34 UNION SELECT 309, 24 UNION SELECT 309, 26 UNION SELECT 309, 29 UNION SELECT 309, 35 UNION SELECT 401, 1 UNION SELECT 401, 10 UNION SELECT 401, 18 UNION SELECT 401, 21 UNION SELECT 402, 2 UNION SELECT 402, 8 UNION SELECT 402, 13 UNION SELECT 402, 29 UNION SELECT 403, 3 UNION SELECT 403, 14 UNION SELECT 403, 31 UNION SELECT 403, 36 UNION SELECT 404, 4 UNION SELECT 404, 9 UNION SELECT 404, 20 UNION SELECT 404, 23 UNION SELECT 405, 5 UNION SELECT 405, 15 UNION SELECT 405, 17 UNION SELECT 405, 28 UNION SELECT 406, 6 UNION SELECT 406, 12 UNION SELECT 406, 16 UNION SELECT 406, 19 UNION SELECT 407, 7 UNION SELECT 407, 26 UNION SELECT 407, 32 UNION SELECT 407, 33 UNION SELECT 408, 11 UNION SELECT 408, 24 UNION SELECT 408, 27 UNION SELECT 408, 34 UNION SELECT 409, 22 UNION SELECT 409, 25 UNION SELECT 409, 30 UNION SELECT 409, 35 UNION SELECT 501, 1 UNION SELECT 501, 14 UNION SELECT 501, 24 UNION SELECT 501, 30 UNION SELECT 502, 2 UNION SELECT 502, 12 UNION SELECT 502, 18 UNION SELECT 502, 34 UNION SELECT 503, 3 UNION SELECT 503, 9 UNION SELECT 503, 17 UNION SELECT 503, 32 UNION SELECT 504, 4 UNION SELECT 504, 6 UNION SELECT 504, 28 UNION SELECT 504, 35 UNION SELECT 505, 5 UNION SELECT 505, 21 UNION SELECT 505, 29 UNION SELECT 505, 36 UNION SELECT 506, 7 UNION SELECT 506, 10 UNION SELECT 506, 19 UNION SELECT 506, 25 UNION SELECT 507, 8 UNION SELECT 507, 16 UNION SELECT 507, 23 UNION SELECT 507, 27 UNION SELECT 508, 11 UNION SELECT 508, 13 UNION SELECT 508, 20 UNION SELECT 508, 33 UNION SELECT 509, 15 UNION SELECT 509, 22 UNION SELECT 509, 26 UNION SELECT 509, 31 UNION SELECT 601, 1 UNION SELECT 601, 12 UNION SELECT 601, 23 UNION SELECT 601, 26 UNION SELECT 602, 2 UNION SELECT 602, 11 UNION SELECT 602, 22 UNION SELECT 602, 36 UNION SELECT 603, 3 UNION SELECT 603, 6 UNION SELECT 603, 13 UNION SELECT 603, 24 UNION SELECT 604, 4 UNION SELECT 604, 10 UNION SELECT 604, 16 UNION SELECT 604, 32 UNION SELECT 605, 5 UNION SELECT 605, 18 UNION SELECT 605, 27 UNION SELECT 605, 33 UNION SELECT 606, 7 UNION SELECT 606, 20 UNION SELECT 606, 28 UNION SELECT 606, 30 UNION SELECT 607, 8 UNION SELECT 607, 14 UNION SELECT 607, 19 UNION SELECT 607, 35 UNION SELECT 608, 9 UNION SELECT 608, 15 UNION SELECT 608, 29 UNION SELECT 608, 34 UNION SELECT 609, 17 UNION SELECT 609, 21 UNION SELECT 609, 25 UNION SELECT 609, 31 UNION SELECT 701, 1 UNION SELECT 701, 19 UNION SELECT 701, 28 UNION SELECT 701, 29 UNION SELECT 702, 2 UNION SELECT 702, 5 UNION SELECT 702, 23 UNION SELECT 702, 30 UNION SELECT 703, 3 UNION SELECT 703, 12 UNION SELECT 703, 15 UNION SELECT 703, 27 UNION SELECT 704, 4 UNION SELECT 704, 11 UNION SELECT 704, 18 UNION SELECT 704, 31 UNION SELECT 705, 6 UNION SELECT 705, 9 UNION SELECT 705, 26 UNION SELECT 705, 36 UNION SELECT 706, 7 UNION SELECT 706, 14 UNION SELECT 706, 17 UNION SELECT 706, 34 UNION SELECT 707, 8 UNION SELECT 707, 10 UNION SELECT 707, 22 UNION SELECT 707, 33 UNION SELECT 708, 13 UNION SELECT 708, 21 UNION SELECT 708, 32 UNION SELECT 708, 35 UNION SELECT 709, 16 UNION SELECT 709, 20 UNION SELECT 709, 24 UNION SELECT 709, 25 UNION SELECT 801, 1 UNION SELECT 801, 7 UNION SELECT 801, 15 UNION SELECT 801, 35 UNION SELECT 802, 2 UNION SELECT 802, 14 UNION SELECT 802, 25 UNION SELECT 802, 32 UNION SELECT 803, 3 UNION SELECT 803, 16 UNION SELECT 803, 18 UNION SELECT 803, 28 UNION SELECT 804, 4 UNION SELECT 804, 17 UNION SELECT 804, 27 UNION SELECT 804, 29 UNION SELECT 805, 5 UNION SELECT 805, 11 UNION SELECT 805, 19 UNION SELECT 805, 26 UNION SELECT 806, 6 UNION SELECT 806, 20 UNION SELECT 806, 22 UNION SELECT 806, 34 UNION SELECT 807, 8 UNION SELECT 807, 9 UNION SELECT 807, 21 UNION SELECT 807, 30 UNION SELECT 808, 10 UNION SELECT 808, 13 UNION SELECT 808, 23 UNION SELECT 808, 36 UNION SELECT 809, 12 UNION SELECT 809, 24 UNION SELECT 809, 31 UNION SELECT 809, 33
            ORDER BY matchNum, RAND();
        END IF;

        IF (SELECT COUNT(*) FROM playerList) IN ('37', '38', '39', '40')
        THEN
          DROP TEMPORARY TABLE IF EXISTS matchList;
          DROP TEMPORARY TABLE IF EXISTS ab;
          CREATE TEMPORARY TABLE IF NOT EXISTS ab AS
            (
              SELECT @row := @row + 1 as row
              ,players.* FROM playerList players
              ,(SELECT @row := 0) r
            );

          UPDATE
            ab
          SET
            row = 39
          WHERE
            row = 34
            AND (SELECT COUNT(*) FROM playerList) < 39;

          UPDATE
            ab
          SET
            row = 38
          WHERE
            row = 16
            AND (SELECT COUNT(*) FROM playerList) < 38;

          UPDATE
            ab
          SET
            _key = getNewByePlayer()
          WHERE
            _key = NULL;

          UPDATE
            ab
          SET
            _key = createScoreset(_key, competitionNumber);

          DROP TEMPORARY TABLE IF EXISTS matchup;
          CREATE TEMPORARY TABLE IF NOT EXISTS matchup AS
            SELECT 101 as matchNum, 1 as playerNum UNION SELECT 101, 2 UNION SELECT 101, 3 UNION SELECT 101, 4 UNION SELECT 102, 5 UNION SELECT 102, 6 UNION SELECT 102, 7 UNION SELECT 102, 8 UNION SELECT 103, 9 UNION SELECT 103, 10 UNION SELECT 103, 11 UNION SELECT 103, 12 UNION SELECT 104, 13 UNION SELECT 104, 14 UNION SELECT 104, 15 UNION SELECT 104, 16 UNION SELECT 105, 17 UNION SELECT 105, 18 UNION SELECT 105, 19 UNION SELECT 105, 20 UNION SELECT 106, 21 UNION SELECT 106, 22 UNION SELECT 106, 23 UNION SELECT 106, 24 UNION SELECT 107, 25 UNION SELECT 107, 26 UNION SELECT 107, 27 UNION SELECT 107, 28 UNION SELECT 108, 29 UNION SELECT 108, 30 UNION SELECT 108, 31 UNION SELECT 108, 32 UNION SELECT 109, 33 UNION SELECT 109, 34 UNION SELECT 109, 35 UNION SELECT 109, 36 UNION SELECT 110, 37 UNION SELECT 110, 38 UNION SELECT 110, 39 UNION SELECT 110, 40 UNION SELECT 201, 1 UNION SELECT 201, 5 UNION SELECT 201, 9 UNION SELECT 201, 13 UNION SELECT 202, 2 UNION SELECT 202, 6 UNION SELECT 202, 10 UNION SELECT 202, 17 UNION SELECT 203, 3 UNION SELECT 203, 7 UNION SELECT 203, 11 UNION SELECT 203, 21 UNION SELECT 204, 4 UNION SELECT 204, 8 UNION SELECT 204, 12 UNION SELECT 204, 25 UNION SELECT 205, 14 UNION SELECT 205, 18 UNION SELECT 205, 22 UNION SELECT 205, 29 UNION SELECT 206, 15 UNION SELECT 206, 19 UNION SELECT 206, 23 UNION SELECT 206, 33 UNION SELECT 207, 16 UNION SELECT 207, 20 UNION SELECT 207, 24 UNION SELECT 207, 37 UNION SELECT 208, 26 UNION SELECT 208, 30 UNION SELECT 208, 34 UNION SELECT 208, 38 UNION SELECT 209, 27 UNION SELECT 209, 31 UNION SELECT 209, 35 UNION SELECT 209, 39 UNION SELECT 210, 28 UNION SELECT 210, 32 UNION SELECT 210, 36 UNION SELECT 210, 40 UNION SELECT 301, 1 UNION SELECT 301, 6 UNION SELECT 301, 11 UNION SELECT 301, 25 UNION SELECT 302, 2 UNION SELECT 302, 7 UNION SELECT 302, 9 UNION SELECT 302, 29 UNION SELECT 303, 3 UNION SELECT 303, 5 UNION SELECT 303, 10 UNION SELECT 303, 15 UNION SELECT 304, 4 UNION SELECT 304, 13 UNION SELECT 304, 17 UNION SELECT 304, 24 UNION SELECT 305, 8 UNION SELECT 305, 14 UNION SELECT 305, 21 UNION SELECT 305, 34 UNION SELECT 306, 12 UNION SELECT 306, 16 UNION SELECT 306, 22 UNION SELECT 306, 39 UNION SELECT 307, 18 UNION SELECT 307, 23 UNION SELECT 307, 28 UNION SELECT 307, 37 UNION SELECT 308, 19 UNION SELECT 308, 26 UNION SELECT 308, 31 UNION SELECT 308, 36 UNION SELECT 309, 20 UNION SELECT 309, 32 UNION SELECT 309, 35 UNION SELECT 309, 38 UNION SELECT 310, 27 UNION SELECT 310, 30 UNION SELECT 310, 33 UNION SELECT 310, 40 UNION SELECT 401, 1 UNION SELECT 401, 12 UNION SELECT 401, 15 UNION SELECT 401, 29 UNION SELECT 402, 2 UNION SELECT 402, 22 UNION SELECT 402, 28 UNION SELECT 402, 34 UNION SELECT 403, 3 UNION SELECT 403, 6 UNION SELECT 403, 30 UNION SELECT 403, 35 UNION SELECT 404, 4 UNION SELECT 404, 9 UNION SELECT 404, 14 UNION SELECT 404, 36 UNION SELECT 405, 5 UNION SELECT 405, 25 UNION SELECT 405, 33 UNION SELECT 405, 37 UNION SELECT 406, 7 UNION SELECT 406, 10 UNION SELECT 406, 24 UNION SELECT 406, 32 UNION SELECT 407, 8 UNION SELECT 407, 13 UNION SELECT 407, 19 UNION SELECT 407, 27 UNION SELECT 408, 11 UNION SELECT 408, 17 UNION SELECT 408, 23 UNION SELECT 408, 40 UNION SELECT 409, 16 UNION SELECT 409, 18 UNION SELECT 409, 31 UNION SELECT 409, 38 UNION SELECT 410, 20 UNION SELECT 410, 21 UNION SELECT 410, 26 UNION SELECT 410, 39 UNION SELECT 501, 1 UNION SELECT 501, 8 UNION SELECT 501, 24 UNION SELECT 501, 28 UNION SELECT 502, 2 UNION SELECT 502, 5 UNION SELECT 502, 11 UNION SELECT 502, 39 UNION SELECT 503, 3 UNION SELECT 503, 19 UNION SELECT 503, 22 UNION SELECT 503, 25 UNION SELECT 504, 4 UNION SELECT 504, 15 UNION SELECT 504, 21 UNION SELECT 504, 38 UNION SELECT 505, 6 UNION SELECT 505, 14 UNION SELECT 505, 26 UNION SELECT 505, 32 UNION SELECT 506, 7 UNION SELECT 506, 18 UNION SELECT 506, 35 UNION SELECT 506, 40 UNION SELECT 507, 9 UNION SELECT 507, 20 UNION SELECT 507, 23 UNION SELECT 507, 27 UNION SELECT 508, 10 UNION SELECT 508, 30 UNION SELECT 508, 36 UNION SELECT 508, 37 UNION SELECT 509, 12 UNION SELECT 509, 13 UNION SELECT 509, 31 UNION SELECT 509, 34 UNION SELECT 510, 16 UNION SELECT 510, 17 UNION SELECT 510, 29 UNION SELECT 510, 33 UNION SELECT 601, 1 UNION SELECT 601, 14 UNION SELECT 601, 17 UNION SELECT 601, 39 UNION SELECT 602, 2 UNION SELECT 602, 8 UNION SELECT 602, 35 UNION SELECT 602, 37 UNION SELECT 603, 3 UNION SELECT 603, 18 UNION SELECT 603, 27 UNION SELECT 603, 32 UNION SELECT 604, 4 UNION SELECT 604, 22 UNION SELECT 604, 31 UNION SELECT 604, 33 UNION SELECT 605, 5 UNION SELECT 605, 16 UNION SELECT 605, 23 UNION SELECT 605, 26 UNION SELECT 606, 6 UNION SELECT 606, 12 UNION SELECT 606, 21 UNION SELECT 606, 36 UNION SELECT 607, 7 UNION SELECT 607, 13 UNION SELECT 607, 28 UNION SELECT 607, 38 UNION SELECT 608, 9 UNION SELECT 608, 15 UNION SELECT 608, 24 UNION SELECT 608, 30 UNION SELECT 609, 10 UNION SELECT 609, 20 UNION SELECT 609, 25 UNION SELECT 609, 40 UNION SELECT 610, 11 UNION SELECT 610, 19 UNION SELECT 610, 29 UNION SELECT 610, 34 UNION SELECT 701, 1 UNION SELECT 701, 22 UNION SELECT 701, 36 UNION SELECT 701, 38 UNION SELECT 702, 2 UNION SELECT 702, 23 UNION SELECT 702, 25 UNION SELECT 702, 32 UNION SELECT 703, 3 UNION SELECT 703, 26 UNION SELECT 703, 29 UNION SELECT 703, 37 UNION SELECT 704, 4 UNION SELECT 704, 5 UNION SELECT 704, 18 UNION SELECT 704, 34 UNION SELECT 705, 6 UNION SELECT 705, 13 UNION SELECT 705, 33 UNION SELECT 705, 39 UNION SELECT 706, 7 UNION SELECT 706, 15 UNION SELECT 706, 17 UNION SELECT 706, 27 UNION SELECT 707, 8 UNION SELECT 707, 11 UNION SELECT 707, 20 UNION SELECT 707, 30 UNION SELECT 708, 9 UNION SELECT 708, 21 UNION SELECT 708, 28 UNION SELECT 708, 31 UNION SELECT 709, 10 UNION SELECT 709, 16 UNION SELECT 709, 19 UNION SELECT 709, 35 UNION SELECT 710, 12 UNION SELECT 710, 14 UNION SELECT 710, 24 UNION SELECT 710, 40 UNION SELECT 801, 1 UNION SELECT 801, 19 UNION SELECT 801, 21 UNION SELECT 801, 40 UNION SELECT 802, 2 UNION SELECT 802, 12 UNION SELECT 802, 18 UNION SELECT 802, 33 UNION SELECT 803, 3 UNION SELECT 803, 8 UNION SELECT 803, 17 UNION SELECT 803, 31 UNION SELECT 804, 4 UNION SELECT 804, 7 UNION SELECT 804, 16 UNION SELECT 804, 30 UNION SELECT 805, 5 UNION SELECT 805, 20 UNION SELECT 805, 28 UNION SELECT 805, 29 UNION SELECT 806, 6 UNION SELECT 806, 24 UNION SELECT 806, 27 UNION SELECT 806, 34 UNION SELECT 807, 9 UNION SELECT 807, 22 UNION SELECT 807, 26 UNION SELECT 807, 35 UNION SELECT 808, 10 UNION SELECT 808, 14 UNION SELECT 808, 23 UNION SELECT 808, 38 UNION SELECT 809, 11 UNION SELECT 809, 13 UNION SELECT 809, 32 UNION SELECT 809, 37 UNION SELECT 810, 15 UNION SELECT 810, 25 UNION SELECT 810, 36 UNION SELECT 810, 39
            ORDER BY matchNum, RAND();
        END IF;

        IF (SELECT COUNT(*) FROM playerList) IN ('49', '50', '51', '52')
        THEN
          DROP TEMPORARY TABLE IF EXISTS matchList;
          DROP TEMPORARY TABLE IF EXISTS ab;
          CREATE TEMPORARY TABLE IF NOT EXISTS ab AS
            (
              SELECT
                @row := @row + 1 as row
                ,players.*
              FROM
                playerList players
                ,(SELECT @row := 0) r
            );

          UPDATE
            ab
          SET
            row = 51
          WHERE
            row = 45
            AND (SELECT COUNT(*) FROM playerList) < 51;

          UPDATE
            ab
          SET
            row = 50
          WHERE
            row = 30
            AND (SELECT COUNT(*) FROM playerList) < 50;

          UPDATE
            ab
          SET
            _key = getNewByePlayer()
          WHERE
            _key = NULL;

          UPDATE
            ab
          SET
            _key = createScoreset(_key, competitionNumber);

          DROP TEMPORARY TABLE IF EXISTS matchup;
          CREATE TEMPORARY TABLE IF NOT EXISTS matchup AS
            SELECT 101 as matchNum, 1 as playerNum UNION SELECT 101, 2 UNION SELECT 101, 3 UNION SELECT 101, 4 UNION SELECT 102, 5 UNION SELECT 102, 6 UNION SELECT 102, 7 UNION SELECT 102, 8 UNION SELECT 103, 9 UNION SELECT 103, 10 UNION SELECT 103, 11 UNION SELECT 103, 12 UNION SELECT 104, 13 UNION SELECT 104, 14 UNION SELECT 104, 15 UNION SELECT 104, 16 UNION SELECT 105, 17 UNION SELECT 105, 18 UNION SELECT 105, 19 UNION SELECT 105, 20 UNION SELECT 106, 21 UNION SELECT 106, 22 UNION SELECT 106, 23 UNION SELECT 106, 24 UNION SELECT 107, 25 UNION SELECT 107, 26 UNION SELECT 107, 27 UNION SELECT 107, 28 UNION SELECT 108, 29 UNION SELECT 108, 30 UNION SELECT 108, 31 UNION SELECT 108, 32 UNION SELECT 109, 33 UNION SELECT 109, 34 UNION SELECT 109, 35 UNION SELECT 109, 36 UNION SELECT 110, 37 UNION SELECT 110, 38 UNION SELECT 110, 39 UNION SELECT 110, 40 UNION SELECT 111, 41 UNION SELECT 111, 42 UNION SELECT 111, 43 UNION SELECT 111, 44 UNION SELECT 112, 45 UNION SELECT 112, 46 UNION SELECT 112, 47 UNION SELECT 112, 48 UNION SELECT 113, 49 UNION SELECT 113, 50 UNION SELECT 113, 51 UNION SELECT 113, 52 UNION SELECT 201, 1 UNION SELECT 201, 6 UNION SELECT 201, 11 UNION SELECT 201, 16 UNION SELECT 202, 5 UNION SELECT 202, 10 UNION SELECT 202, 15 UNION SELECT 202, 20 UNION SELECT 203, 9 UNION SELECT 203, 14 UNION SELECT 203, 19 UNION SELECT 203, 24 UNION SELECT 204, 13 UNION SELECT 204, 18 UNION SELECT 204, 23 UNION SELECT 204, 28 UNION SELECT 205, 17 UNION SELECT 205, 22 UNION SELECT 205, 27 UNION SELECT 205, 32 UNION SELECT 206, 21 UNION SELECT 206, 26 UNION SELECT 206, 31 UNION SELECT 206, 36 UNION SELECT 207, 25 UNION SELECT 207, 30 UNION SELECT 207, 35 UNION SELECT 207, 40 UNION SELECT 208, 29 UNION SELECT 208, 34 UNION SELECT 208, 39 UNION SELECT 208, 44 UNION SELECT 209, 33 UNION SELECT 209, 38 UNION SELECT 209, 43 UNION SELECT 209, 48 UNION SELECT 210, 37 UNION SELECT 210, 42 UNION SELECT 210, 47 UNION SELECT 210, 52 UNION SELECT 211, 41 UNION SELECT 211, 46 UNION SELECT 211, 51 UNION SELECT 211, 4 UNION SELECT 212, 45 UNION SELECT 212, 50 UNION SELECT 212, 3 UNION SELECT 212, 8 UNION SELECT 213, 49 UNION SELECT 213, 2 UNION SELECT 213, 7 UNION SELECT 213, 12 UNION SELECT 301, 1 UNION SELECT 301, 10 UNION SELECT 301, 7 UNION SELECT 301, 24 UNION SELECT 302, 5 UNION SELECT 302, 14 UNION SELECT 302, 11 UNION SELECT 302, 28 UNION SELECT 303, 9 UNION SELECT 303, 18 UNION SELECT 303, 15 UNION SELECT 303, 32 UNION SELECT 304, 13 UNION SELECT 304, 22 UNION SELECT 304, 19 UNION SELECT 304, 36 UNION SELECT 305, 17 UNION SELECT 305, 26 UNION SELECT 305, 23 UNION SELECT 305, 40 UNION SELECT 306, 21 UNION SELECT 306, 30 UNION SELECT 306, 27 UNION SELECT 306, 44 UNION SELECT 307, 25 UNION SELECT 307, 34 UNION SELECT 307, 31 UNION SELECT 307, 48 UNION SELECT 308, 29 UNION SELECT 308, 38 UNION SELECT 308, 35 UNION SELECT 308, 52 UNION SELECT 309, 33 UNION SELECT 309, 42 UNION SELECT 309, 39 UNION SELECT 309, 4 UNION SELECT 310, 37 UNION SELECT 310, 46 UNION SELECT 310, 43 UNION SELECT 310, 8 UNION SELECT 311, 41 UNION SELECT 311, 50 UNION SELECT 311, 47 UNION SELECT 311, 12 UNION SELECT 312, 45 UNION SELECT 312, 2 UNION SELECT 312, 51 UNION SELECT 312, 16 UNION SELECT 313, 49 UNION SELECT 313, 6 UNION SELECT 313, 3 UNION SELECT 313, 20 UNION SELECT 401, 1 UNION SELECT 401, 18 UNION SELECT 401, 39 UNION SELECT 401, 12 UNION SELECT 402, 5 UNION SELECT 402, 22 UNION SELECT 402, 43 UNION SELECT 402, 16 UNION SELECT 403, 9 UNION SELECT 403, 26 UNION SELECT 403, 47 UNION SELECT 403, 20 UNION SELECT 404, 13 UNION SELECT 404, 30 UNION SELECT 404, 51 UNION SELECT 404, 24 UNION SELECT 405, 17 UNION SELECT 405, 34 UNION SELECT 405, 3 UNION SELECT 405, 28 UNION SELECT 406, 21 UNION SELECT 406, 38 UNION SELECT 406, 7 UNION SELECT 406, 32 UNION SELECT 407, 25 UNION SELECT 407, 42 UNION SELECT 407, 11 UNION SELECT 407, 36 UNION SELECT 408, 29 UNION SELECT 408, 46 UNION SELECT 408, 15 UNION SELECT 408, 40 UNION SELECT 409, 33 UNION SELECT 409, 50 UNION SELECT 409, 19 UNION SELECT 409, 44 UNION SELECT 410, 37 UNION SELECT 410, 2 UNION SELECT 410, 23 UNION SELECT 410, 48 UNION SELECT 411, 41 UNION SELECT 411, 6 UNION SELECT 411, 27 UNION SELECT 411, 52 UNION SELECT 412, 45 UNION SELECT 412, 10 UNION SELECT 412, 31 UNION SELECT 412, 4 UNION SELECT 413, 49 UNION SELECT 413, 14 UNION SELECT 413, 35 UNION SELECT 413, 8 UNION SELECT 501, 1 UNION SELECT 501, 22 UNION SELECT 501, 47 UNION SELECT 501, 40 UNION SELECT 502, 5 UNION SELECT 502, 26 UNION SELECT 502, 51 UNION SELECT 502, 44 UNION SELECT 503, 9 UNION SELECT 503, 30 UNION SELECT 503, 3 UNION SELECT 503, 48 UNION SELECT 504, 13 UNION SELECT 504, 34 UNION SELECT 504, 7 UNION SELECT 504, 52 UNION SELECT 505, 17 UNION SELECT 505, 38 UNION SELECT 505, 11 UNION SELECT 505, 4 UNION SELECT 506, 21 UNION SELECT 506, 42 UNION SELECT 506, 15 UNION SELECT 506, 8 UNION SELECT 507, 25 UNION SELECT 507, 46 UNION SELECT 507, 19 UNION SELECT 507, 12 UNION SELECT 508, 29 UNION SELECT 508, 50 UNION SELECT 508, 23 UNION SELECT 508, 16 UNION SELECT 509, 33 UNION SELECT 509, 2 UNION SELECT 509, 27 UNION SELECT 509, 20 UNION SELECT 510, 37 UNION SELECT 510, 6 UNION SELECT 510, 31 UNION SELECT 510, 24 UNION SELECT 511, 41 UNION SELECT 511, 10 UNION SELECT 511, 35 UNION SELECT 511, 28 UNION SELECT 512, 45 UNION SELECT 512, 14 UNION SELECT 512, 39 UNION SELECT 512, 32 UNION SELECT 513, 49 UNION SELECT 513, 18 UNION SELECT 513, 43 UNION SELECT 513, 36 UNION SELECT 601, 1 UNION SELECT 601, 26 UNION SELECT 601, 15 UNION SELECT 601, 52 UNION SELECT 602, 5 UNION SELECT 602, 30 UNION SELECT 602, 19 UNION SELECT 602, 4 UNION SELECT 603, 9 UNION SELECT 603, 34 UNION SELECT 603, 23 UNION SELECT 603, 8 UNION SELECT 604, 13 UNION SELECT 604, 38 UNION SELECT 604, 27 UNION SELECT 604, 12 UNION SELECT 605, 17 UNION SELECT 605, 42 UNION SELECT 605, 31 UNION SELECT 605, 16 UNION SELECT 606, 21 UNION SELECT 606, 46 UNION SELECT 606, 35 UNION SELECT 606, 20 UNION SELECT 607, 25 UNION SELECT 607, 50 UNION SELECT 607, 39 UNION SELECT 607, 24 UNION SELECT 608, 29 UNION SELECT 608, 2 UNION SELECT 608, 43 UNION SELECT 608, 28 UNION SELECT 609, 33 UNION SELECT 609, 6 UNION SELECT 609, 47 UNION SELECT 609, 32 UNION SELECT 610, 37 UNION SELECT 610, 10 UNION SELECT 610, 51 UNION SELECT 610, 36 UNION SELECT 611, 41 UNION SELECT 611, 14 UNION SELECT 611, 3 UNION SELECT 611, 40 UNION SELECT 612, 45 UNION SELECT 612, 18 UNION SELECT 612, 7 UNION SELECT 612, 44 UNION SELECT 613, 49 UNION SELECT 613, 22 UNION SELECT 613, 11 UNION SELECT 613, 48 UNION SELECT 701, 1 UNION SELECT 701, 30 UNION SELECT 701, 43 UNION SELECT 701, 20 UNION SELECT 702, 5 UNION SELECT 702, 34 UNION SELECT 702, 47 UNION SELECT 702, 24 UNION SELECT 703, 9 UNION SELECT 703, 38 UNION SELECT 703, 51 UNION SELECT 703, 28 UNION SELECT 704, 13 UNION SELECT 704, 42 UNION SELECT 704, 3 UNION SELECT 704, 32 UNION SELECT 705, 17 UNION SELECT 705, 46 UNION SELECT 705, 7 UNION SELECT 705, 36 UNION SELECT 706, 21 UNION SELECT 706, 50 UNION SELECT 706, 11 UNION SELECT 706, 40 UNION SELECT 707, 25 UNION SELECT 707, 2 UNION SELECT 707, 15 UNION SELECT 707, 44 UNION SELECT 708, 29 UNION SELECT 708, 6 UNION SELECT 708, 19 UNION SELECT 708, 48 UNION SELECT 709, 33 UNION SELECT 709, 10 UNION SELECT 709, 23 UNION SELECT 709, 52 UNION SELECT 710, 37 UNION SELECT 710, 14 UNION SELECT 710, 27 UNION SELECT 710, 4 UNION SELECT 711, 41 UNION SELECT 711, 18 UNION SELECT 711, 31 UNION SELECT 711, 8 UNION SELECT 712, 45 UNION SELECT 712, 22 UNION SELECT 712, 35 UNION SELECT 712, 12 UNION SELECT 713, 49 UNION SELECT 713, 26 UNION SELECT 713, 39 UNION SELECT 713, 16 UNION SELECT 801, 1 UNION SELECT 801, 34 UNION SELECT 801, 51 UNION SELECT 801, 32 UNION SELECT 802, 5 UNION SELECT 802, 38 UNION SELECT 802, 3 UNION SELECT 802, 36 UNION SELECT 803, 9 UNION SELECT 803, 42 UNION SELECT 803, 7 UNION SELECT 803, 40 UNION SELECT 804, 13 UNION SELECT 804, 46 UNION SELECT 804, 11 UNION SELECT 804, 44 UNION SELECT 805, 17 UNION SELECT 805, 50 UNION SELECT 805, 15 UNION SELECT 805, 48 UNION SELECT 806, 21 UNION SELECT 806, 2 UNION SELECT 806, 19 UNION SELECT 806, 52 UNION SELECT 807, 25 UNION SELECT 807, 6 UNION SELECT 807, 23 UNION SELECT 807, 4 UNION SELECT 808, 29 UNION SELECT 808, 10 UNION SELECT 808, 27 UNION SELECT 808, 8 UNION SELECT 809, 33 UNION SELECT 809, 14 UNION SELECT 809, 31 UNION SELECT 809, 12 UNION SELECT 810, 37 UNION SELECT 810, 18 UNION SELECT 810, 35 UNION SELECT 810, 16 UNION SELECT 811, 41 UNION SELECT 811, 22 UNION SELECT 811, 39 UNION SELECT 811, 20 UNION SELECT 812, 45 UNION SELECT 812, 26 UNION SELECT 812, 43 UNION SELECT 812, 24 UNION SELECT 813, 49 UNION SELECT 813, 30 UNION SELECT 813, 47 UNION SELECT 813, 28
            ORDER BY matchNum, RAND();
        END IF;

        CALL createTBDGame();

        DROP TEMPORARY TABLE IF EXISTS ac;
        CREATE TEMPORARY TABLE IF NOT EXISTS ac AS
          SELECT
            DISTINCT matchup.playerNum AS row
            ,ab._key AS _key
          FROM
            matchup
            LEFT JOIN ab ON matchup.playerNum = ab.row
          ORDER BY
            row;

        UPDATE
          ac
        SET
          _key = getNewByePlayer()
        WHERE
          _key IS NULL;

        DROP TEMPORARY TABLE IF EXISTS scores;
        CREATE TEMPORARY TABLE IF NOT EXISTS scores AS
          SELECT
            DISTINCT matchup.matchNum AS matchNum
            ,ac._key AS playerNum
          FROM
            matchup
            JOIN ac ON matchup.playerNum = ac.row;

        DROP TEMPORARY TABLE IF EXISTS matches;
        CREATE TEMPORARY TABLE IF NOT EXISTS matches AS
          SELECT
            DISTINCT
              matchNum AS matchNum
            FROM
              matchup;

        UPDATE
          matches
        SET
          matchNum = createMatch(10000 * competitionNumber + matchNum, scoringScheme);

        UPDATE
          scores
        SET
          matchNum = createScore((10000 * competitionNumber + matchNum), playerNum);

        UPDATE
          tblscore s
        SET
          _fk_scoreset =
            (
              SELECT
                _key
              FROM
                tblscoreset ss
              WHERE
                ss._fk_player = s._fk_player
                AND ss._fk_competition = competitionNumber LIMIT 1
            )
        WHERE
          inCompetitionSpan(s._fk_match, competitionNumber);

        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r1.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #1\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #1,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 1 round,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 200), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 100), ' AND m._key < ', (SELECT 10000 * competitionNumber + 200), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\nRound 1\\n<a href=\\"r2.html\\">Round 2</a>\\n<a href=\\"r3.html\\">Round 3</a>\\n<a href=\\"r4.html\\">Round 4</a>\\n<a href=\\"r5.html\\">Round 5</a>\\n<a href=\\"r6.html\\">Round 6</a>\\n<a href=\\"r7.html\\">Round 7</a>\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r2.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #2\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #2,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 2 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 300), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 200), ' AND m._key < ', (SELECT 10000 * competitionNumber + 300), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\nRound 2\\n<a href=\\"r3.html\\">Round 3</a>\\n<a href=\\"r4.html\\">Round 4</a>\\n<a href=\\"r5.html\\">Round 5</a>\\n<a href=\\"r6.html\\">Round 6</a>\\n<a href=\\"r7.html\\">Round 7</a>\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r3.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #3\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #3,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 3 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 400), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 300), ' AND m._key < ', (SELECT 10000 * competitionNumber + 400), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\n<a href=\\"r2.html\\">Round 2</a>\\nRound 3\\n<a href=\\"r4.html\\">Round 4</a>\\n<a href=\\"r5.html\\">Round 5</a>\\n<a href=\\"r6.html\\">Round 6</a>\\n<a href=\\"r7.html\\">Round 7</a>\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r4.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #4\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #4,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 4 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 500), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 400), ' AND m._key < ', (SELECT 10000 * competitionNumber + 500), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\n<a href=\\"r2.html\\">Round 2</a>\\n<a href=\\"r3.html\\">Round 3</a>\\nRound 4\\n<a href=\\"r5.html\\">Round 5</a>\\n<a href=\\"r6.html\\">Round 6</a>\\n<a href=\\"r7.html\\">Round 7</a>\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r5.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #5\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #5,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 5 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 600), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 500), ' AND m._key < ', (SELECT 10000 * competitionNumber + 600), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\n<a href=\\"r2.html\\">Round 2</a>\\n<a href=\\"r3.html\\">Round 3</a>\\n<a href=\\"r4.html\\">Round 4</a>\\nRound 5\\n<a href=\\"r6.html\\">Round 6</a>\\n<a href=\\"r7.html\\">Round 7</a>\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r6.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #6\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #6,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 6 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 700), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 600), ' AND m._key < ', (SELECT 10000 * competitionNumber + 700), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\n<a href=\\"r2.html\\">Round 2</a>\\n<a href=\\"r3.html\\">Round 3</a>\\n<a href=\\"r4.html\\">Round 4</a>\\n<a href=\\"r5.html\\">Round 5</a>\\nRound 6\\n<a href=\\"r7.html\\">Round 7</a>\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r7.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #7\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #7,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 7 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 800), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 700), ' AND m._key < ', (SELECT 10000 * competitionNumber + 800), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\n<a href=\\"r2.html\\">Round 2</a>\\n<a href=\\"r3.html\\">Round 3</a>\\n<a href=\\"r4.html\\">Round 4</a>\\n<a href=\\"r5.html\\">Round 5</a>\\n<a href=\\"r6.html\\">Round 6</a>\\nRound 7\\n<a href=\\"r8.html\\">Round 8</a>\\n</pre><hr><p>\\n</body>\\n</html>\\')'));
        INSERT INTO tblwebsitegenerator (_fk_competition, filename, filedef) VALUES (competitionNumber, 'r8.html', CONCAT ('SELECT CONCAT(\\'<html><head><html><head><title>Tournament Results for Round #8\\n</title>\\n</head><body bgcolor=#f0f0f0><center><h3>Tournament Results for Round #8,</h3></center>\\n<hr>\\n<pre>Overall Standings as of 8 rounds,</h3></center>\\n\\nPos Player Name          POINTS\\n--- -------------------- ------\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\') FROM (SELECT CONCAT(LPAD(rank, 3, \\' \\'), \\' \\', RPAD(name, 20, \\' \\'), \\'  \\', LPAD(total, 3, \\' \\'), \\'\\n\\') AS line FROM (SELECT totals.pn, total, CASE WHEN @l=total THEN @r ELSE @r:=@row + 1 END as rank, @l:=total, @row:=@row + 1 FROM (SELECT s._fk_player AS pn, SUM(points) AS total FROM tblscore s JOIN tblplayer p on s._fk_player = p._key JOIN tblcompetitionenrollment ce ON ce._fk_player = p._key WHERE p._key IN (select _fk_player from tblcompetitionenrollment where _fk_competition = ', competitionNumber, ') AND _fk_match < ', (SELECT 10000 * competitionNumber + 900), ' AND _fk_match > ', (SELECT 10000 * competitionNumber + 100) ,' AND ce.report = 1 GROUP BY p._key ORDER BY total DESC) totals, (SELECT @r:=0, @row:=0, @l:=NULL) rank) summary JOIN tblplayer on tblplayer._key = summary.pn) a), \\'\\nSummary of all Matches in Round\\n\\', (SELECT GROUP_CONCAT(line SEPARATOR \\'\\n\\') FROM (SELECT CONCAT(\\'Match \\',  m._key , \\'         \\', g.gamename, \\'\\n\\', GROUP_CONCAT(CONCAT(CAST(RPAD(p.name, 20, \\' \\') AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(FORMAT(score, 0), 14, \\' \\')AS CHAR CHARACTER SET utf8), \\' \\', CAST(LPAD(s.points, 2, \\' \\') AS CHAR CHARACTER SET utf8)) SEPARATOR \\'\\n\\')) AS line FROM tblmatch m JOIN tblscore s on s._fk_match = m._key JOIN tblgame g ON m._fk_game = g._key JOIN tblplayer p on p._key = s._fk_player WHERE m._key > ', (SELECT 10000 * competitionNumber + 800), ' AND m._key < ', (SELECT 10000 * competitionNumber + 900), ' AND p.name != \\'bye\\' GROUP BY m._key) a), \\'\\n\\n<a href=\\"r1.html\\">Round 1</a>\\n<a href=\\"r2.html\\">Round 2</a>\\n<a href=\\"r3.html\\">Round 3</a>\\n<a href=\\"r4.html\\">Round 4</a>\\n<a href=\\"r5.html\\">Round 5</a>\\n<a href=\\"r6.html\\">Round 6</a>\\n<a href=\\"r7.html\\">Round 7</a>\\nRound 8\\n</pre><hr><p>\\n</body>\\n</html>\\')'));

        RETURN competitionNumber;
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION getCompetitionNumberForCompetition(
        competitionName VARCHAR(100)) RETURNS smallint(6)
      BEGIN
        RETURN (SELECT _key FROM tblcompetition WHERE name = competitionName LIMIT 1);
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION getGameNumberForGame(
        name VARCHAR(40)) RETURNS smallint(6)
      BEGIN
        RETURN (SELECT _key FROM tblgame WHERE gamename = name LIMIT 1);
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION getNewByePlayer() RETURNS int(11)
      BEGIN
        INSERT INTO
          tblplayer(name, report)
        VALUES ('bye', 0);
        RETURN (SELECT LAST_INSERT_ID());
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION getScoreRegex(
        matchNum int) RETURNS VARCHAR(100)
      BEGIN
        SET @OnesRegex = '([1-9][0-9]{0,2},[0-9]{3})';
        SET @NoOnesRegex = '([1-9],([0-9]{3},){2}[0-9]{2}0)|([1-9][0-9]{0,2},([0-9]{3},){0,1}[0-9]{2}0)';
        SET @Ones =
          (
            SELECT
              g.ones
            FROM
              tblgame g
              JOIN tblmatch m ON m._fk_game = g._key
            WHERE
              m._key = matchNum
          );

        RETURN (SELECT
          IF(@Ones = 1, @OnesRegex, @NoOnesRegex) AS regex);
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION inCompetitionSpan(
        matchNum smallint, competitionNumber smallint) RETURNS tinyint(1)
      BEGIN
        RETURN (SELECT (SELECT matchNum > competitionNumber * 10000) AND (SELECT matchNum < competitionNumber * 10000 + 10000));
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION matchNumExists(
        matchNum int) RETURNS tinyint(1)
      BEGIN
        RETURN (SELECT (SELECT COUNT(*) AS my_bool FROM tblmatch WHERE _key = matchNum) = 1 AS matchNumExists);
      END
    SQL
    execute <<-SQL
      CREATE FUNCTION playerNameExists(
        playerName VARCHAR(40)) RETURNS tinyint(1)
      BEGIN
        RETURN (SELECT (SELECT COUNT(*) AS my_bool FROM tblplayer WHERE name = playerName) = 1 as competitionNameExists);
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE enrollPlayerToCompetition(
        IN playerName VARCHAR(40),
        IN competitionNum int(6),
        IN seed int(6))
      BEGIN
        DECLARE playerNum int(6);
        IF (playerNameExists(playerName) = 0)
        THEN
          INSERT INTO tblplayer(name, report)
            SELECT playerName, 1;
        END IF;
        SET playerNum = (SELECT _key FROM tblplayer WHERE name = playerName LIMIT 1);
        INSERT INTO tblcompetitionenrollment (_fk_competition, _fk_player, seed, report)
          VALUES (competitionNum, playerNum, seed, 1);
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE assignGameToMatch(
        IN matchNum int,
        IN name VARCHAR(40))
      BEGIN
        UPDATE
          tblmatch
        SET
          _fk_game = getGameNumberForGame(name)
        WHERE
          _key = matchNum;
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE createTBDGame()
      BEGIN
        INSERT INTO
          tblgame (_key, gamename, ones)
            SELECT
              *
            FROM
              (SELECT
                -1
                ,'TBD'
                , 0
              ) as tmp
        WHERE NOT EXISTS
          (
            SELECT
              -1
              ,'TBD'
              ,0
              from tblgame);

      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE getFullWebsite(
        IN competitionNumber smallint)
      BEGIN
        DECLARE done BOOLEAN DEFAULT 0;
        DECLARE o INT;

        DECLARE webgen
        CURSOR
        FOR
          SELECT
            _key
          FROM
            tblwebsitegenerator
          WHERE
            _fk_competition = competitionNumber;

        DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;

        SET SESSION group_concat_max_len = 1000000;

        DROP TEMPORARY TABLE IF EXISTS site;
        CREATE TEMPORARY TABLE site (filename VARCHAR(40), filetext VARCHAR(10000));

        OPEN webgen;

          REPEAT

            FETCH webgen INTO o;

            SET @S = (SELECT filedef FROM tblwebsitegenerator WHERE _key = o);
            SET @ST = CONCAT(@S, ' INTO @OUT');

            PREPARE stmt FROM @ST;
            EXECUTE stmt;

            INSERT INTO
              site (filename, filetext)
            VALUES (
              (
                SELECT
                  filename
                FROM
                  tblwebsitegenerator
                WHERE
                  _key = o
              )
              ,@OUT);

            SET @OUT = NULL;

          UNTIL done END REPEAT;

        CLOSE webgen;

        SELECT DISTINCT * from site;

        DROP TEMPORARY TABLE IF EXISTS site;
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE getMatchNumbersInCompetition(
        IN competitionNumber smallint)
      BEGIN
        SELECT DISTINCT
          m._key
        FROM
          tblmatch m
          JOIN tblscore s on s._fk_match = m._key
          JOIN tblscoreset ss on s._fk_scoreset = ss._key
        WHERE
          ss._fk_competition = competitionNumber
        ORDER BY
          m._key;
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE getPlayerNamesInCompetition(
        IN competitionNumber smallint)
      BEGIN
        SELECT
          DISTINCT name
        FROM
          tblplayer p
          JOIN tblscoreset ss ON ss._fk_player = p._key
        WHERE
          p.report = 1
          AND ss._fk_competition = competitionNumber;
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE getPlayerNamesInMatch(
        IN matchNum smallint)
      BEGIN
        SELECT
          p.name AS name
          ,s._key AS scoreNum
        FROM
          tblplayer p
          JOIN tblscore s ON s._fk_player = p._key
          JOIN tblmatch m ON s._fk_match = m._key
        WHERE
          m._key = matchNum
          AND p.name != 'bye'
        ORDER BY
          s._key;
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE makeMatch(
        IN matchNum smallint,
        IN scoringScheme smallint)
      BEGIN
        CALL createTBDGame();
        SELECT @TBD = (SELECT _key FROM tblgame where gamename = 'TBD');
        INSERT INTO
          tblmatch (_key, _fk_game, _fk_scoringScheme)
        VALUES (matchNum, @TBD, scoringScheme);
      END
    SQL
    execute <<-SQL
      CREATE PROCEDURE removeGame(
        IN name VARCHAR(40))
      BEGIN
        DELETE FROM
          tblgame
        WHERE
          gamename = name;
      END
    SQL
  end

  def down
    execute "DROP PROCEDURE removeGame"
    execute "DROP PROCEDURE makeMatch"
    execute "DROP PROCEDURE getPlayerNamesInMatch"
    execute "DROP PROCEDURE getPlayerNamesInCompetition"
    execute "DROP PROCEDURE getMatchNumbersInCompetition"
    execute "DROP PROCEDURE getFullWebsite"
    execute "DROP PROCEDURE createTBDGame"
    execute "DROP PROCEDURE assignGameToMatch"
    execute "DROP PROCEDURE enrollPlayerToCompetition"
    execute "DROP FUNCTION playerNameExists"
    execute "DROP FUNCTION matchNumExists"
    execute "DROP FUNCTION inCompetitionSpan"
    execute "DROP FUNCTION getScoreRegex"
    execute "DROP FUNCTION getNewByePlayer"
    execute "DROP FUNCTION getGameNumberForGame"
    execute "DROP FUNCTION getCompetitionNumberForCompetition"
    execute "DROP FUNCTION generateRandomMatchupTournament"
    execute "DROP FUNCTION generateNewCompetition"
    execute "DROP FUNCTION gameNameExists"
    execute "DROP FUNCTION createScoreset"
    execute "DROP FUNCTION createScore"
    execute "DROP FUNCTION createMatch"
    execute "DROP FUNCTION competitionNameExists"
    execute "DROP PROCEDURE getBonusPoints"
    execute "DROP PROCEDURE previewFourPlayerScoreEntry"
    execute "DROP PROCEDURE enterScore"
    execute "DROP PROCEDURE enterScoreByMatchNumberAndName"
    execute "DROP TRIGGER guardAttributeValueInserts"
    execute "DROP TRIGGER updateAttributeValues"
    execute "DROP TRIGGER forAlteredGames"
    execute "DROP TRIGGER forNewGames"
    execute "DROP TRIGGER forAlteredPlayers"
    execute "DROP TRIGGER forNewPlayers"
    execute "DROP PROCEDURE getGameNamesInCompetition"
    execute "DROP PROCEDURE addGame"
    execute "DROP PROCEDURE removePlayer"
    execute "DROP PROCEDURE addPlayer"
    drop_table :tempattributevalue
    drop_table :tempScore
    drop_table :tblattributevalue
    drop_table :tblattributename
    drop_table :tblcompetitionadvancementscript
    drop_table :tblcompetitionenrollment
    drop_table :tblwebsitegenerator
    drop_table :tblbonusscoring
    drop_table :tblscoring
    drop_table :tblscore
    drop_table :tblscoreset
    drop_table :tblplayer
    drop_table :tblmatch
    drop_table :tblscoringscheme
    drop_table :tblgame
    drop_table :tblcompetition
  end
end
