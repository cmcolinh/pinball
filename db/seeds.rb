# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
query = ["INSERT INTO tblattributename(attrname, description, playernotnull) VALUES ('playerName', 'Name of Player', 1) ON DUPLICATE KEY UPDATE `playernotnull` = VALUES(`playernotnull`)",
  "INSERT INTO tblattributename(attrname, description, playernotnull, regex) VALUES ('playerActive', 'Player active in database', 1, 'Y|N') ON DUPLICATE KEY UPDATE `regex` = VALUES(`regex`)",
  "INSERT INTO tblattributename(attrname, description, gamenotnull) VALUES ('gameName', 'Name of Game', 1) ON DUPLICATE KEY UPDATE `gamenotnull` = VALUES(`gamenotnull`)",
  "INSERT INTO tblattributename(attrname, description, gamenotnull, competitionnotnull, regex) VALUES ('gameInCompetition', 'Game is being used in the competition', 1, 1, 'Y|N') ON DUPLICATE KEY UPDATE `regex` = VALUES(`regex`)",
  "INSERT INTO tblscoringscheme (description) VALUES ('10-6-3-1 Scoring') ON DUPLICATE KEY UPDATE `description` = VALUES(`description`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 3, 1, 10) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 3, 2, 5) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 3, 3, 1) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 1, 10) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 2, 6) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 3, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = '10-6-3-1 Scoring' LIMIT 1), 4, 4, 1) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoringscheme (description) VALUES ('FSPA Scoring') ON DUPLICATE KEY UPDATE `description` = VALUES(`description`)",
  "INSERT INTO tblscoringscheme (description) VALUES ('FSPA Scoring Bonus Game') ON DUPLICATE KEY UPDATE `description` = VALUES(`description`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 1, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 2, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 2, 2, 0) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 3, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 3, 2, 2) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 3, 3, 0) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 2, 2) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 3, 1) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1), 4, 4, 0) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 1, 1, 2) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 2, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 2, 2, 0) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 3, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 3, 2, 2) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 3, 3, 0) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 1, 3) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 2, 2) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 3, 1) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblscoring (_fk_scoringscheme, numplayers, rank, pointsforrank) VALUES ((SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1), 4, 4, 0) ON DUPLICATE KEY UPDATE `pointsforrank` = VALUES(`pointsforrank`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 2 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > 3 * (SELECT score FROM tempScore WHERE rank = 2)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 2 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= 3 * (SELECT score FROM tempScore WHERE rank = 2)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 3 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 3 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 2) > (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring' LIMIT 1) and numplayers = 4 and rank = 4), 1, '(SELECT score FROM tempScore WHERE rank = 2) <= (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 2 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > 3 * (SELECT score FROM tempScore WHERE rank = 2)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 2 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= 3 * (SELECT score FROM tempScore WHERE rank = 2)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 3 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) > (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 3 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) <= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 1), 1, '(SELECT score FROM tempScore WHERE rank = 1) >= (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 2), 1, '(SELECT score FROM tempScore WHERE rank = 2) >= (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 3), 1, '(SELECT score FROM tempScore WHERE rank = 1) < (SELECT score FROM tempScore WHERE rank = 2) + (SELECT score FROM tempScore WHERE rank = 3)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",
  "INSERT INTO tblbonusscoring (_fk_scoring, bonuspoints, cond) VALUES ((SELECT _key from tblscoring where _fk_scoringscheme = (SELECT _key from tblscoringscheme where description = 'FSPA Scoring Bonus Game' LIMIT 1) and numplayers = 4 and rank = 4), 1, '(SELECT score FROM tempScore WHERE rank = 2) < (SELECT score FROM tempScore WHERE rank = 3) + (SELECT score FROM tempScore WHERE rank = 4)') ON DUPLICATE KEY UPDATE `cond` = VALUES(`cond`)",


  "INSERT INTO `randomtournamentmatchup` (`matchNum`, `playerNum`, `numPlayers`, `numRounds`) VALUES (101, 1, 32, 10), (101, 5, 32, 10), (101, 13, 32, 10), (101, 26, 32, 10), (102, 2, 32, 10), (102, 9, 32, 10), (102, 31, 32, 10), (102, 8, 32, 10), (103, 3, 32, 10), (103, 10, 32, 10), (103, 30, 32, 10), (103, 7, 32, 10), (104, 4, 32, 10), (104, 6, 32, 10), (104, 15, 32, 10), (104, 28, 32, 10), (105, 17, 32, 10), (105, 22, 32, 10), (105, 25, 32, 10), (105, 16, 32, 10), (106, 18, 32, 10), (106, 23, 32, 10), (106, 32, 32, 10), (106, 12, 32, 10), (107, 19, 32, 10), (107, 14, 32, 10), (107, 27, 32, 10), (107, 24, 32, 10), (108, 21, 32, 10), (108, 29, 32, 10), (108, 11, 32, 10), (108, 20, 32, 10), (201, 1, 32, 10), (201, 19, 32, 10), (201, 25, 32, 10), (201, 12, 32, 10), (202, 2, 32, 10), (202, 10, 32, 10), (202, 18, 32, 10), (202, 26, 32, 10), (203, 3, 32, 10), (203, 23, 32, 10), (203, 11, 32, 10), (203, 14, 32, 10), (204, 4, 32, 10), (204, 22, 32, 10), (204, 7, 32, 10), (204, 20, 32, 10), (205, 5, 32, 10), (205, 17, 32, 10), (205, 31, 32, 10), (205, 28, 32, 10), (206, 6, 32, 10), (206, 29, 32, 10), (206, 16, 32, 10), (206, 24, 32, 10), (207, 9, 32, 10), (207, 13, 32, 10), (207, 32, 32, 10), (207, 27, 32, 10), (208, 21, 32, 10), (208, 30, 32, 10), (208, 8, 32, 10), (208, 15, 32, 10), (301, 1, 32, 10), (301, 31, 32, 10), (301, 20, 32, 10), (301, 16, 32, 10), (302, 2, 32, 10), (302, 17, 32, 10), (302, 32, 32, 10), (302, 15, 32, 10), (303, 3, 32, 10), (303, 13, 32, 10), (303, 19, 32, 10), (303, 29, 32, 10), (304, 4, 32, 10), (304, 18, 32, 10), (304, 30, 32, 10), (304, 14, 32, 10), (305, 5, 32, 10), (305, 10, 32, 10), (305, 21, 32, 10), (305, 27, 32, 10), (306, 6, 32, 10), (306, 9, 32, 10), (306, 25, 32, 10), (306, 23, 32, 10), (307, 22, 32, 10), (307, 11, 32, 10), (307, 8, 32, 10), (307, 26, 32, 10), (308, 12, 32, 10), (308, 7, 32, 10), (308, 24, 32, 10), (308, 28, 32, 10), (401, 1, 32, 10), (401, 9, 32, 10), (401, 22, 32, 10), (401, 15, 32, 10), (402, 2, 32, 10), (402, 5, 32, 10), (402, 19, 32, 10), (402, 23, 32, 10), (403, 3, 32, 10), (403, 17, 32, 10), (403, 12, 32, 10), (403, 26, 32, 10), (404, 4, 32, 10), (404, 13, 32, 10), (404, 25, 32, 10), (404, 8, 32, 10), (405, 6, 32, 10), (405, 21, 32, 10), (405, 31, 32, 10), (405, 14, 32, 10), (406, 10, 32, 10), (406, 32, 32, 10), (406, 20, 32, 10), (406, 24, 32, 10), (407, 18, 32, 10), (407, 29, 32, 10), (407, 7, 32, 10), (407, 27, 32, 10), (408, 30, 32, 10), (408, 11, 32, 10), (408, 16, 32, 10), (408, 28, 32, 10), (501, 1, 32, 10), (501, 10, 32, 10), (501, 14, 32, 10), (501, 28, 32, 10), (502, 2, 32, 10), (502, 6, 32, 10), (502, 20, 32, 10), (502, 27, 32, 10), (503, 3, 32, 10), (503, 21, 32, 10), (503, 25, 32, 10), (503, 32, 32, 10), (504, 4, 32, 10), (504, 31, 32, 10), (504, 26, 32, 10), (504, 24, 32, 10), (505, 5, 32, 10), (505, 9, 32, 10), (505, 18, 32, 10), (505, 16, 32, 10), (506, 13, 32, 10), (506, 22, 32, 10), (506, 30, 32, 10), (506, 12, 32, 10), (507, 17, 32, 10), (507, 23, 32, 10), (507, 29, 32, 10), (507, 8, 32, 10), (508, 19, 32, 10), (508, 11, 32, 10), (508, 7, 32, 10), (508, 15, 32, 10), (601, 1, 32, 10), (601, 6, 32, 10), (601, 32, 32, 10), (601, 11, 32, 10), (602, 2, 32, 10), (602, 25, 32, 10), (602, 7, 32, 10), (602, 14, 32, 10), (603, 3, 32, 10), (603, 8, 32, 10), (603, 16, 32, 10), (603, 27, 32, 10), (604, 4, 32, 10), (604, 5, 32, 10), (604, 29, 32, 10), (604, 12, 32, 10), (605, 9, 32, 10), (605, 17, 32, 10), (605, 30, 32, 10), (605, 24, 32, 10), (606, 10, 32, 10), (606, 19, 32, 10), (606, 22, 32, 10), (606, 31, 32, 10), (607, 13, 32, 10), (607, 18, 32, 10), (607, 21, 32, 10), (607, 28, 32, 10), (608, 23, 32, 10), (608, 20, 32, 10), (608, 15, 32, 10), (608, 26, 32, 10), (701, 1, 32, 10), (701, 23, 32, 10), (701, 30, 32, 10), (701, 27, 32, 10), (702, 2, 32, 10), (702, 22, 32, 10), (702, 29, 32, 10), (702, 28, 32, 10), (703, 3, 32, 10), (703, 5, 32, 10), (703, 15, 32, 10), (703, 24, 32, 10), (704, 4, 32, 10), (704, 9, 32, 10), (704, 19, 32, 10), (704, 21, 32, 10), (705, 6, 32, 10), (705, 10, 32, 10), (705, 13, 32, 10), (705, 17, 32, 10), (706, 18, 32, 10), (706, 25, 32, 10), (706, 31, 32, 10), (706, 11, 32, 10), (707, 32, 32, 10), (707, 7, 32, 10), (707, 16, 32, 10), (707, 26, 32, 10), (708, 12, 32, 10), (708, 8, 32, 10), (708, 20, 32, 10), (708, 14, 32, 10), (801, 1, 32, 10), (801, 17, 32, 10), (801, 21, 32, 10), (801, 7, 32, 10), (802, 2, 32, 10), (802, 13, 32, 10), (802, 11, 32, 10), (802, 24, 32, 10), (803, 3, 32, 10), (803, 6, 32, 10), (803, 18, 32, 10), (803, 22, 32, 10), (804, 4, 32, 10), (804, 10, 32, 10), (804, 23, 32, 10), (804, 16, 32, 10), (805, 5, 32, 10), (805, 25, 32, 10), (805, 30, 32, 10), (805, 20, 32, 10), (806, 9, 32, 10), (806, 29, 32, 10), (806, 14, 32, 10), (806, 26, 32, 10), (807, 19, 32, 10), (807, 32, 32, 10), (807, 8, 32, 10), (807, 28, 32, 10), (808, 31, 32, 10), (808, 12, 32, 10), (808, 15, 32, 10), (808, 27, 32, 10), (901, 1, 32, 10), (901, 18, 32, 10), (901, 8, 32, 10), (901, 24, 32, 10), (902, 2, 32, 10), (902, 21, 32, 10), (902, 12, 32, 10), (902, 16, 32, 10), (903, 3, 32, 10), (903, 9, 32, 10), (903, 20, 32, 10), (903, 28, 32, 10), (904, 4, 32, 10), (904, 17, 32, 10), (904, 11, 32, 10), (904, 27, 32, 10), (905, 5, 32, 10), (905, 22, 32, 10), (905, 32, 32, 10), (905, 14, 32, 10), (906, 6, 32, 10), (906, 19, 32, 10), (906, 30, 32, 10), (906, 26, 32, 10), (907, 10, 32, 10), (907, 25, 32, 10), (907, 29, 32, 10), (907, 15, 32, 10), (908, 13, 32, 10), (908, 23, 32, 10), (908, 31, 32, 10), (908, 7, 32, 10), (1001, 1, 32, 10), (1001, 2, 32, 10), (1001, 3, 32, 10), (1001, 4, 32, 10), (1002, 5, 32, 10), (1002, 6, 32, 10), (1002, 7, 32, 10), (1002, 8, 32, 10), (1003, 9, 32, 10), (1003, 10, 32, 10), (1003, 11, 32, 10), (1003, 12, 32, 10), (1004, 13, 32, 10), (1004, 14, 32, 10), (1004, 15, 32, 10), (1004, 16, 32, 10), (1005, 17, 32, 10), (1005, 18, 32, 10), (1005, 19, 32, 10), (1005, 20, 32, 10), (1006, 21, 32, 10), (1006, 22, 32, 10), (1006, 23, 32, 10), (1006, 24, 32, 10), (1007, 25, 32, 10), (1007, 26, 32, 10), (1007, 27, 32, 10), (1007, 28, 32, 10), (1008, 29, 32, 10), (1008, 30, 32, 10), (1008, 31, 32, 10), (1008, 32, 32, 10) ON DUPLICATE KEY UPDATE `playerNum` = VALUES(`playerNum`)",
  "INSERT INTO `randomtournamentmatchup` (`matchNum`, `playerNum`, `numPlayers`, `numRounds`) (SELECT tm.`matchNum`, tm.`playerNum`, 30, 9 FROM `randomtournamentmatchup` tm WHERE `numPlayers` = 32 AND `numRounds` = 10 AND `matchNum` < 1000) ON DUPLICATE KEY UPDATE `playerNum` = VALUES(`playerNum`)",
  "INSERT INTO `randomtournamentmatchup` (`matchNum`, `playerNum`, `numPlayers`, `numRounds`) VALUES (101, 1, 28, 9), (101, 5, 28, 9), (101, 9, 28, 9), (101, 13, 28, 9), (102, 14, 28, 9), (102, 10, 28, 9), (102, 17, 28, 9), (102, 21, 28, 9), (103, 6, 28, 9), (103, 2, 28, 9), (103, 18, 28, 9), (103, 22, 28, 9), (104, 3, 28, 9), (104, 19, 28, 9), (104, 25, 28, 9), (104, 15, 28, 9), (105, 16, 28, 9), (105, 26, 28, 9), (105, 23, 28, 9), (105, 7, 28, 9), (106, 20, 28, 9), (106, 8, 28, 9), (106, 11, 28, 9), (106, 27, 28, 9), (107, 28, 28, 9), (107, 12, 28, 9), (107, 4, 28, 9), (107, 24, 28, 9), (201, 1, 28, 9), (201, 14, 28, 9), (201, 20, 28, 9), (201, 28, 28, 9), (202, 5, 28, 9), (202, 10, 28, 9), (202, 3, 28, 9), (202, 16, 28, 9), (203, 19, 28, 9), (203, 26, 28, 9), (203, 8, 28, 9), (203, 12, 28, 9), (204, 17, 28, 9), (204, 6, 28, 9), (204, 23, 28, 9), (204, 4, 28, 9), (205, 21, 28, 9), (205, 2, 28, 9), (205, 25, 28, 9), (205, 11, 28, 9), (206, 9, 28, 9), (206, 18, 28, 9), (206, 15, 28, 9), (206, 24, 28, 9), (207, 13, 28, 9), (207, 22, 28, 9), (207, 7, 28, 9), (207, 27, 28, 9), (301, 1, 28, 9), (301, 10, 28, 9), (301, 27, 28, 9), (301, 24, 28, 9), (302, 5, 28, 9), (302, 14, 28, 9), (302, 25, 28, 9), (302, 23, 28, 9), (303, 15, 28, 9), (303, 7, 28, 9), (303, 11, 28, 9), (303, 4, 28, 9), (304, 21, 28, 9), (304, 18, 28, 9), (304, 16, 28, 9), (304, 12, 28, 9), (305, 17, 28, 9), (305, 22, 28, 9), (305, 3, 28, 9), (305, 8, 28, 9), (306, 9, 28, 9), (306, 6, 28, 9), (306, 19, 28, 9), (306, 28, 28, 9), (307, 13, 28, 9), (307, 2, 28, 9), (307, 26, 28, 9), (307, 20, 28, 9), (401, 1, 28, 9), (401, 6, 28, 9), (401, 16, 28, 9), (401, 11, 28, 9), (402, 5, 28, 9), (402, 2, 28, 9), (402, 19, 28, 9), (402, 24, 28, 9), (403, 14, 28, 9), (403, 18, 28, 9), (403, 3, 28, 9), (403, 27, 28, 9), (404, 10, 28, 9), (404, 22, 28, 9), (404, 26, 28, 9), (404, 4, 28, 9), (405, 15, 28, 9), (405, 23, 28, 9), (405, 20, 28, 9), (405, 12, 28, 9), (406, 9, 28, 9), (406, 17, 28, 9), (406, 25, 28, 9), (406, 7, 28, 9), (407, 13, 28, 9), (407, 21, 28, 9), (407, 8, 28, 9), (407, 28, 28, 9), (501, 1, 28, 9), (501, 17, 28, 9), (501, 15, 28, 9), (501, 26, 28, 9), (502, 5, 28, 9), (502, 21, 28, 9), (502, 20, 28, 9), (502, 4, 28, 9), (503, 14, 28, 9), (503, 22, 28, 9), (503, 19, 28, 9), (503, 11, 28, 9), (504, 25, 28, 9), (504, 16, 28, 9), (504, 8, 28, 9), (504, 24, 28, 9), (505, 10, 28, 9), (505, 18, 28, 9), (505, 7, 28, 9), (505, 28, 28, 9), (506, 9, 28, 9), (506, 2, 28, 9), (506, 23, 28, 9), (506, 27, 28, 9), (507, 13, 28, 9), (507, 6, 28, 9), (507, 3, 28, 9), (507, 12, 28, 9), (601, 1, 28, 9), (601, 18, 28, 9), (601, 23, 28, 9), (601, 8, 28, 9), (602, 5, 28, 9), (602, 22, 28, 9), (602, 15, 28, 9), (602, 28, 28, 9), (603, 10, 28, 9), (603, 6, 28, 9), (603, 25, 28, 9), (603, 20, 28, 9), (604, 14, 28, 9), (604, 2, 28, 9), (604, 7, 28, 9), (604, 12, 28, 9), (605, 19, 28, 9), (605, 16, 28, 9), (605, 27, 28, 9), (605, 4, 28, 9), (606, 9, 28, 9), (606, 21, 28, 9), (606, 3, 28, 9), (606, 26, 28, 9), (607, 13, 28, 9), (607, 17, 28, 9), (607, 11, 28, 9), (607, 24, 28, 9), (701, 1, 28, 9), (701, 21, 28, 9), (701, 19, 28, 9), (701, 7, 28, 9), (702, 5, 28, 9), (702, 17, 28, 9), (702, 27, 28, 9), (702, 12, 28, 9), (703, 10, 28, 9), (703, 2, 28, 9), (703, 15, 28, 9), (703, 8, 28, 9), (704, 3, 28, 9), (704, 23, 28, 9), (704, 11, 28, 9), (704, 28, 28, 9), (705, 14, 28, 9), (705, 6, 28, 9), (705, 26, 28, 9), (705, 24, 28, 9), (706, 9, 28, 9), (706, 22, 28, 9), (706, 16, 28, 9), (706, 20, 28, 9), (707, 13, 28, 9), (707, 18, 28, 9), (707, 25, 28, 9), (707, 4, 28, 9), (801, 1, 28, 9), (801, 22, 28, 9), (801, 25, 28, 9), (801, 12, 28, 9), (802, 5, 28, 9), (802, 18, 28, 9), (802, 26, 28, 9), (802, 11, 28, 9), (803, 17, 28, 9), (803, 2, 28, 9), (803, 16, 28, 9), (803, 28, 28, 9), (804, 3, 28, 9), (804, 7, 28, 9), (804, 20, 28, 9), (804, 24, 28, 9), (805, 21, 28, 9), (805, 6, 28, 9), (805, 15, 28, 9), (805, 27, 28, 9), (806, 9, 28, 9), (806, 14, 28, 9), (806, 8, 28, 9), (806, 4, 28, 9), (807, 13, 28, 9), (807, 10, 28, 9), (807, 19, 28, 9), (807, 23, 28, 9), (901, 1, 28, 9), (901, 2, 28, 9), (901, 3, 28, 9), (901, 4, 28, 9), (902, 5, 28, 9), (902, 6, 28, 9), (902, 7, 28, 9), (902, 8, 28, 9), (903, 9, 28, 9), (903, 10, 28, 9), (903, 11, 28, 9), (903, 12, 28, 9), (904, 13, 28, 9), (904, 14, 28, 9), (904, 15, 28, 9), (904, 16, 28, 9), (905, 17, 28, 9), (905, 18, 28, 9), (905, 19, 28, 9), (905, 20, 28, 9), (906, 21, 28, 9), (906, 22, 28, 9), (906, 23, 28, 9), (906, 24, 28, 9), (907, 25, 28, 9), (907, 26, 28, 9), (907, 27, 28, 9), (907, 28, 28, 9) ON DUPLICATE KEY UPDATE `playerNum` = VALUES(`playerNum`)",
  "INSERT INTO `randomtournamentmatchup` (`matchNum`, `playerNum`, `numPlayers`, `numRounds`) (SELECT tm.`matchNum`, tm.`playerNum`, 26, 8 FROM `randomtournamentmatchup` tm WHERE `numPlayers` = 28 AND `numRounds` = 9 AND `matchNum` < 900) ON DUPLICATE KEY UPDATE `playerNum` = VALUES(`playerNum`)",
  "INSERT INTO `randomtournamentmatchup` (`matchNum`, `playerNum`, `numPlayers`, `numRounds`) VALUES (101, 10, 18, 8), (101, 13, 18, 8), (101, 16, 18, 8), (102, 2, 18, 8), (102, 5, 18, 8), (102, 8, 18, 8), (103, 15, 18, 8), (103, 18, 18, 8), (103, 12, 18, 8), (104, 1, 18, 8), (104, 6, 18, 8), (104, 14, 18, 8), (105, 17, 18, 8), (105, 4, 18, 8), (105, 9, 18, 8), (106, 3, 18, 8), (106, 11, 18, 8), (106, 7, 18, 8), (201, 10, 18, 8), (201, 4, 18, 8), (201, 7, 18, 8), (202, 2, 18, 8), (202, 11, 18, 8), (202, 14, 18, 8), (203, 15, 18, 8), (203, 6, 18, 8), (203, 9, 18, 8), (204, 1, 18, 8), (204, 18, 18, 8), (204, 8, 18, 8), (205, 17, 18, 8), (205, 13, 18, 8), (205, 12, 18, 8), (206, 3, 18, 8), (206, 5, 18, 8), (206, 16, 18, 8), (301, 1, 18, 8), (301, 4, 18, 8), (301, 16, 18, 8), (302, 17, 18, 8), (302, 11, 18, 8), (302, 8, 18, 8), (303, 3, 18, 8), (303, 6, 18, 8), (303, 12, 18, 8), (304, 10, 18, 8), (304, 18, 18, 8), (304, 14, 18, 8), (305, 2, 18, 8), (305, 13, 18, 8), (305, 9, 18, 8), (306, 15, 18, 8), (306, 5, 18, 8), (306, 7, 18, 8), (401, 1, 18, 8), (401, 13, 18, 8), (401, 7, 18, 8), (402, 17, 18, 8), (402, 5, 18, 8), (402, 14, 18, 8), (403, 3, 18, 8), (403, 18, 18, 8), (403, 9, 18, 8), (404, 10, 18, 8), (404, 6, 18, 8), (404, 8, 18, 8), (405, 2, 18, 8), (405, 4, 18, 8), (405, 12, 18, 8), (406, 15, 18, 8), (406, 11, 18, 8), (406, 16, 18, 8), (501, 10, 18, 8), (501, 2, 18, 8), (501, 15, 18, 8), (502, 13, 18, 8), (502, 5, 18, 8), (502, 18, 18, 8), (503, 16, 18, 8), (503, 8, 18, 8), (503, 12, 18, 8), (504, 1, 18, 8), (504, 11, 18, 8), (504, 9, 18, 8), (505, 4, 18, 8), (505, 14, 18, 8), (505, 3, 18, 8), (506, 7, 18, 8), (506, 17, 18, 8), (506, 6, 18, 8), (601, 10, 18, 8), (601, 17, 18, 8), (601, 3, 18, 8), (602, 13, 18, 8), (602, 11, 18, 8), (602, 6, 18, 8), (603, 16, 18, 8), (603, 14, 18, 8), (603, 9, 18, 8), (604, 1, 18, 8), (604, 5, 18, 8), (604, 12, 18, 8), (605, 4, 18, 8), (605, 8, 18, 8), (605, 15, 18, 8), (606, 7, 18, 8), (606, 2, 18, 8), (606, 18, 18, 8), (701, 1, 18, 8), (701, 17, 18, 8), (701, 15, 18, 8), (702, 4, 18, 8), (702, 11, 18, 8), (702, 18, 18, 8), (703, 7, 18, 8), (703, 14, 18, 8), (703, 12, 18, 8), (704, 10, 18, 8), (704, 5, 18, 8), (704, 9, 18, 8), (705, 13, 18, 8), (705, 8, 18, 8), (705, 3, 18, 8), (706, 16, 18, 8) ON DUPLICATE KEY UPDATE `playerNum` = VALUES(`playerNum`)"
]



ActiveRecord::Base.transaction do
  query.each do |q|
    ActiveRecord::Base.connection.execute(q)
  end
end
