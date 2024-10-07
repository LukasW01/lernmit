class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :tasks, dependent: :destroy
  has_many :achievement_users, dependent: :destroy
  has_many :achievements, through: :achievement_users
  has_many :learnsets, dependent: :destroy

  enum roles: %w[user admin]

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at email encrypted_password id id_value remember_created_at reset_password_sent_at reset_password_token roles updated_at]
  end
end
