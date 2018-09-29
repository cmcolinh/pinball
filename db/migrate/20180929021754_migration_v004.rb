class MigrationV004 < ActiveRecord::Migration[5.1]
  def up
    add_index :tblscoringscheme, :description,
      unique: true,
      name:   :scoringscheme_description_uk
    add_index :tblscoring, [:_fk_scoringscheme, :numplayers, :rank],
      unique: true,
      name:   :scoring_scoringscheme_numplayers_rank_uk
    add_index :tblbonusscoring, [:_fk_scoring, :bonuspoints],
      unique: true,
      name:   :bonusscoring_scoring_bonuspoints_uk
  end

  def down
    remove_index :tblbonusscoring,  name: :bonusscoring_scoring_bonuspoints_uk
    remove_index :tblscoring,       name: :scoring_scoringscheme_numplayers_rank_uk
    remove_index :tblscoringscheme, name: :scoringscheme_description_uk
  end
end
