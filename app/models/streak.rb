class Streak < ApplicationRecord
  belongs_to :user

  def self.create(type)
    Streak.find_or_create_by(user_id: current_user.id, created_at: Date.today, types: type)
  end
end
