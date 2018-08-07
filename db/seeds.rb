# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
query = ["INSERT INTO tblattributename(attrname, description, playernotnull) VALUES ('playerName', 'Name of Player', 1)",
  "INSERT INTO tblattributename(attrname, description, playernotnull, regex) VALUES ('playerActive', 'Player active in database', 1, 'Y|N')",
  "INSERT INTO tblattributename(attrname, description, gamenotnull) VALUES ('gameName', 'Name of Game', 1)",
  "INSERT INTO tblattributename(attrname, description, gamenotnull, competitionnotnull, regex) VALUES ('gameInCompetition', 'Game is being used in the competition', 1, 1, 'Y|N')",
  "INSERT INTO tblscoringscheme (description) VALUES ('10-6-3-1 Scoring')",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 3, 1, 10)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 3, 2, 5)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 3, 3, 1)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 1, 10)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 2, 6)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 3, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 4, 1)",
  "INSERT INTO tblscoringscheme (description) VALUES ('FSPA Scoring')",
  "INSERT INTO tblscoringscheme (description) VALUES ('FSPA Scoring Bonus Game')",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 1, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 2, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 2, 2, 0)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 3, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 3, 2, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 3, 3, 0)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 2, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 3, 1)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 4, 0)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 1, 1, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 2, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 2, 2, 0)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 3, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 3, 2, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 3, 3, 0)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 1, 3)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 2, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 3, 1)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 4, 0)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 2 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > 3 * (SELECT score FROM tempScore WHERE rank = 2)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 2 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= 3 * (SELECT score FROM tempScore WHERE rank = 2)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 3 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 3 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 2) > (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 4), 1, '(SELECT score FROM tempScore WHERE rank = 2) <= (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 2 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > 3 * (SELECT score FROM tempScore WHERE rank = 2)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 2 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= 3 * (SELECT score FROM tempScore WHERE rank = 2)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 3 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 3 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) >= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 2) >= (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) < (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)')",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 4), 1, '(SELECT score FROM tempScore WHERE rank = 2) < (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)')",
  "INSERT INTO tblscoringscheme (description) VALUES ('4-2-1-0 Scoring'')",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 3, 1, 4)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 3, 2, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 3, 3, 0)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 4, 1, 10)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 4, 2, 2)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 4, 3, 1)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '4-2-1-0 Scoring' LIMIT 1), 4, 4, 0)"]

ActiveRecord::Base.transaction do
  query.each do |q|
    ActiveRecord::Base.connection.execute(q)
  end
end
