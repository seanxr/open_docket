class RenamePublicHearingsToNotices < ActiveRecord::Migration
     def self.up
        rename_table :public_hearings, :notices
      end
     def self.down
        rename_table :notices, :public_hearings
     end
end
