class AddRequiresPublicHearingToItems < ActiveRecord::Migration
  def change
    add_column :items, :requires_public_hearing, :boolean
  end
end
