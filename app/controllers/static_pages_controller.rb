class StaticPagesController < ApplicationController
  def home
    @committees = Committee.all
    @meetings = Meeting.upcoming
  end

  def help
  end

  def about
  end

  def contact
  end
end
