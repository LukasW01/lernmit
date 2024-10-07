class AchievementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_achievements, @achievements = load_achievements
    @streak_daily, @streak_weekly = load_streak
  end

  private

  def load_achievements
    [AchievementUser.where(user_id: current_user.id), Achievement.all]
  end

  def load_streak
    [streak_daily, streak_weekly]
  end

  def streak_daily
    dates = Streak.where(user_id: current_user.id).order(:created_at).pluck(:created_at).map(&:to_date)
    return 0 if dates.empty?

    dates.chunk_while { |i, j| i + 1 == j }.map(&:size).max
  end

  def streak_weekly
    dates = Streak.where(user_id: current_user.id).order(:created_at).pluck(:created_at).map(&:to_date)
    return 0 if dates.empty?

    dates.chunk_while { |i, j| i + 1 == j }.map(&:first).map(&:beginning_of_week).uniq.size
  end
end
