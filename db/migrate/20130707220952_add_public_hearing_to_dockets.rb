class AddPublicHearingToDockets < ActiveRecord::Migration
  def change
    add_column :dockets, :public_hearing, :boolean
  end
end
