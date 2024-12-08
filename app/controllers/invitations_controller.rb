class InvitationsController < ApplicationController
  before_action :get_event
  before_action :get_invite

  def edit
  end

  def update
    if @invite.update(invite_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def get_event
    @event = Event.last
  end

  def get_invite
    @invite = Current.user.invitation
  end

  def invite_params
    params.require(:invitation).permit(:rsvp_answer, :rsvp_count)
  end
end
