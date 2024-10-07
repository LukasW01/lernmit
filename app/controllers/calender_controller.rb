class CalenderController < ApplicationController
  before_action :authenticate_user!

  def index
    load_tasks
    load_tasks_limit
  end

  def month
    load_tasks('month')
    load_tasks_limit
  end

  def week
    load_tasks('week')
  end

  private

  def load_tasks_limit
    @load_tasks_limit ||= Task.where(types: 'Exam', user_id: current_user.id).order(created_at: :desc).limit(10)
  end

  def load_tasks(view = 'month')
    @load_tasks ||= Task.where(due_date: date_range(view), types: 'Exam', user_id: current_user.id).order(created_at: :desc)
  end

  def date_range(view)
    if %w[month all].include?(view)
      start_date = params[:start_date].present? ? params[:start_date].to_date.beginning_of_month : Date.today.beginning_of_month
      end_date = start_date.end_of_month
    elsif view == 'week'
      start_date = params[:start_date].present? ? params[:start_date].to_date.beginning_of_week : Date.today.beginning_of_week
      end_date = start_date.end_of_week
    end

    start_date..end_date
  end
end
