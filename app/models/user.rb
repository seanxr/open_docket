# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_many :committees_as_creator, :class_name => 'Committee', :foreign_key => 'creator_id' 
  has_many :committees_as_updater, :class_name => 'Committee', :foreign_key => 'updater_id'
  has_many :items_as_creator, :class_name => 'Item', :foreign_key => 'creator_id' 
  has_many :items_as_updater, :class_name => 'Item', :foreign_key => 'updater_id'
  has_many :sites_as_creator, :class_name => 'Site', :foreign_key => 'creator_id' 
  has_many :sites_as_updater, :class_name => 'Site', :foreign_key => 'updater_id'
  has_many :rooms_as_creator, :class_name => 'Site', :foreign_key => 'creator_id' 
  has_many :rooms_as_updater, :class_name => 'Site', :foreign_key => 'updater_id'
  has_many :meetings_as_creator, :class_name => 'Site', :foreign_key => 'creator_id' 
  has_many :meetings_as_updater, :class_name => 'Site', :foreign_key => 'updater_id'




  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
