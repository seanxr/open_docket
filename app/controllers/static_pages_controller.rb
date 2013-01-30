class StaticPagesController < ApplicationController
  def home
    @committees = Committee.all
  end

  def help
  end

  def about
  end

  def contact
  end
end
