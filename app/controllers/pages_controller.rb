class PagesController < ApplicationController
  before_action :resume_session, only: [ :home ]

  def home
  end
end
