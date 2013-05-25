class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :committee_id
      t.integer :person_id
      t.date :term_start
      t.date :term_end
      t.string :display_as
      t.integer :position

      t.timestamps
    end
  end
end
