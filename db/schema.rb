# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180217232523) do

  create_table "tblattributename", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "attrname", limit: 40, null: false
    t.string "description", limit: 40, null: false
    t.integer "playernotnull", limit: 1, null: false
    t.integer "gamenotnull", limit: 1, null: false
    t.integer "competitionnotnull", limit: 1, null: false
    t.string "regex", limit: 10000, default: ".{1,40}", null: false
    t.index ["attrname", "playernotnull", "gamenotnull", "competitionnotnull"], name: "attributevalue_player_game_competition_notnull_uk", unique: true
  end

  create_table "tblattributevalue", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_player"
    t.integer "_fk_game"
    t.integer "_fk_competition"
    t.integer "_fk_attributename"
    t.string "attrvalue", limit: 40, null: false
    t.datetime "startdate", null: false
    t.datetime "enddate", default: "9999-12-31 23:59:59", null: false
    t.index ["_fk_attributename"], name: "attributevalue_to_attributename_fk"
    t.index ["_fk_competition"], name: "attribute_value_to_competition_fk"
    t.index ["_fk_game"], name: "attributevalue_to_game_fk"
    t.index ["_fk_player"], name: "attributevalue_to_player_fk"
  end

  create_table "tblbonusscoring", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_scoring", null: false
    t.integer "bonuspoints", null: false
    t.string "cond", limit: 10000, null: false
    t.index ["_fk_scoring"], name: "bonusscoring_to_scoring_fk"
  end

  create_table "tblcompetition", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 100, null: false
    t.string "basepath", limit: 100
    t.index ["name"], name: "index_tblcompetition_on_name", unique: true
  end

  create_table "tblcompetitionadvancementscript", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_competition", null: false
    t.integer "step", null: false
    t.string "command", limit: 10000, null: false
    t.integer "active", limit: 1, null: false
    t.index ["_fk_competition", "step"], name: "competionadvancementscript_competition_step_uk", unique: true
  end

  create_table "tblcompetitionenrollment", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_competition", null: false
    t.integer "_fk_player", null: false
    t.integer "seed"
    t.integer "report", null: false
    t.index ["_fk_competition", "_fk_player"], name: "competitionenrollment_competition_player_uk", unique: true
    t.index ["_fk_player"], name: "competitionenrollment_to_player_fk"
  end

  create_table "tblgame", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "gamename", limit: 40, null: false
    t.integer "ones", null: false
    t.index ["gamename"], name: "index_tblgame_on_gamename", unique: true
  end

  create_table "tblmatch", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_game", null: false
    t.integer "_fk_scoringscheme", null: false
    t.index ["_fk_game"], name: "match_to_game_fk"
    t.index ["_fk_scoringscheme"], name: "scoringscheme_to_match_fk"
  end

  create_table "tblplayer", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 40, null: false
    t.integer "report", null: false
  end

  create_table "tblscore", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_player", null: false
    t.integer "_fk_match", null: false
    t.integer "_fk_scoreset", null: false
    t.integer "score", null: false
    t.bigint "rank"
    t.integer "points"
    t.index ["_fk_match"], name: "score_to_match_fk"
    t.index ["_fk_player"], name: "score_to_player_fk"
    t.index ["_fk_scoreset"], name: "score_to_scoreset_fk"
  end

  create_table "tblscoreset", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_player", null: false
    t.integer "_fk_competition", null: false
    t.index ["_fk_competition"], name: "scoreset_to_competition_fk"
    t.index ["_fk_player"], name: "scoreset_to_player_fk"
  end

  create_table "tblscoring", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_scoringscheme", null: false
    t.integer "numplayers", null: false
    t.integer "rank", null: false
    t.integer "pointsforrank", null: false
    t.index ["_fk_scoringscheme"], name: "scoring_to_scoringscheme_fk"
  end

  create_table "tblscoringscheme", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "description", limit: 40, null: false
  end

  create_table "tblwebsitegenerator", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_competition", null: false
    t.string "filename", limit: 40, null: false
    t.string "filedef", limit: 10000, null: false
    t.index ["_fk_competition"], name: "websitegenerator_to_competition_fk"
  end

  create_table "tempScore", primary_key: "_key", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_player"
    t.integer "_fk_match"
    t.integer "_fk_scoreset"
    t.bigint "score"
    t.integer "rank"
    t.integer "points"
    t.integer "session_id", null: false
    t.index ["_fk_match"], name: "tempscore_to_match_fk"
    t.index ["_fk_player"], name: "tempscore_to_player_fk"
    t.index ["_fk_scoreset"], name: "tempscore_to_scoreset_fk"
  end

  create_table "tempattributevalue", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "_fk_player"
    t.integer "_fk_game"
    t.integer "_fk_competition"
    t.integer "_fk_attributename", null: false
    t.string "attrvalue", limit: 41, null: false
    t.datetime "startdate", null: false
    t.datetime "enddate", default: "9999-12-31 23:59:59", null: false
    t.integer "session_id", null: false
    t.index ["_fk_attributename"], name: "tempattributevalue_to_attributename_fk"
    t.index ["_fk_competition"], name: "tampattributevalue_to_competition_fk"
    t.index ["_fk_game"], name: "tempattributevalue_to_game_fk"
    t.index ["_fk_player"], name: "tempattributevalue_to_player_fk"
  end

  add_foreign_key "tblattributevalue", "tblattributename", column: "_fk_attributename", primary_key: "_key", name: "attributevalue_to_attributename_fk"
  add_foreign_key "tblattributevalue", "tblcompetition", column: "_fk_competition", primary_key: "_key", name: "attribute_value_to_competition_fk"
  add_foreign_key "tblattributevalue", "tblgame", column: "_fk_game", primary_key: "_key", name: "attributevalue_to_game_fk"
  add_foreign_key "tblattributevalue", "tblplayer", column: "_fk_player", primary_key: "_key", name: "attributevalue_to_player_fk"
  add_foreign_key "tblbonusscoring", "tblscoring", column: "_fk_scoring", primary_key: "_key", name: "bonusscoring_to_scoring_fk"
  add_foreign_key "tblcompetitionadvancementscript", "tblcompetition", column: "_fk_competition", primary_key: "_key", name: "competitionadvancementscript_to_competition_fk"
  add_foreign_key "tblcompetitionenrollment", "tblcompetition", column: "_fk_competition", primary_key: "_key", name: "competitionenrollment_to_competition_fk"
  add_foreign_key "tblcompetitionenrollment", "tblplayer", column: "_fk_player", primary_key: "_key", name: "competitionenrollment_to_player_fk"
  add_foreign_key "tblmatch", "tblgame", column: "_fk_game", primary_key: "_key", name: "match_to_game_fk"
  add_foreign_key "tblmatch", "tblscoringscheme", column: "_fk_scoringscheme", primary_key: "_key", name: "scoringscheme_to_match_fk"
  add_foreign_key "tblscore", "tblmatch", column: "_fk_match", primary_key: "_key", name: "score_to_match_fk"
  add_foreign_key "tblscore", "tblplayer", column: "_fk_player", primary_key: "_key", name: "score_to_player_fk"
  add_foreign_key "tblscore", "tblscoreset", column: "_fk_scoreset", primary_key: "_key", name: "score_to_scoreset_fk"
  add_foreign_key "tblscoreset", "tblcompetition", column: "_fk_competition", primary_key: "_key", name: "scoreset_to_competition_fk"
  add_foreign_key "tblscoreset", "tblplayer", column: "_fk_player", primary_key: "_key", name: "scoreset_to_player_fk"
  add_foreign_key "tblscoring", "tblscoringscheme", column: "_fk_scoringscheme", primary_key: "_key", name: "scoring_to_scoringscheme_fk"
  add_foreign_key "tblwebsitegenerator", "tblcompetition", column: "_fk_competition", primary_key: "_key", name: "websitegenerator_to_competition_fk"
  add_foreign_key "tempScore", "tblmatch", column: "_fk_match", primary_key: "_key", name: "tempscore_to_match_fk"
  add_foreign_key "tempScore", "tblplayer", column: "_fk_player", primary_key: "_key", name: "tempscore_to_player_fk"
  add_foreign_key "tempScore", "tblscoreset", column: "_fk_scoreset", primary_key: "_key", name: "tempscore_to_scoreset_fk"
  add_foreign_key "tempattributevalue", "tblattributename", column: "_fk_attributename", primary_key: "_key", name: "tempattributevalue_to_attributename_fk"
  add_foreign_key "tempattributevalue", "tblcompetition", column: "_fk_competition", primary_key: "_key", name: "tampattributevalue_to_competition_fk"
  add_foreign_key "tempattributevalue", "tblgame", column: "_fk_game", primary_key: "_key", name: "tempattributevalue_to_game_fk"
  add_foreign_key "tempattributevalue", "tblplayer", column: "_fk_player", primary_key: "_key", name: "tempattributevalue_to_player_fk"
end
