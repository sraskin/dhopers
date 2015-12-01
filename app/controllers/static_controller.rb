class StaticController < ApplicationController
  def home

  end

  def about

  end

  def contact

  end

  def terms

  end

  def team

  end

  def how

  end

  def pricing
    @prices = Price.all
  end

  def downloads

  end

  def coverages

  end

  def faq

  end

  def press

  end

  def policy

  end
end
