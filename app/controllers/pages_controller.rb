class PagesController < ApplicationController
  before_action :resume_session, only: [ :home ]
  before_action :get_event

  def home
  end

  private

  def get_event
    @event = Event.last
  end
end
