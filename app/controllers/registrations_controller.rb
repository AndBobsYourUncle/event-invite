class RegistrationsController < ApplicationController
  layout "event_design"
  optionally_authenticate
  before_action :set_invite_by_code, only: %i[ new create ]
  rate_limit to: 10, within: 1.minutes, with: -> { redirect_to new_session_url, alert: "Try again later." }
  before_action :get_event

  def new
    @invite.build_user(email_address: @invite.email_address, full_name: @invite.full_name)
  end

  def create
    injected_params = invite_params

    generated_password = SecureRandom.hex(32)

    injected_params[:user_attributes][:password] = generated_password
    injected_params[:user_attributes][:password_confirmation] = generated_password

    if @invite.update(injected_params)
      start_new_session_for(@invite.user)

      InvitationsMailer.rsvp(@invite).deliver_later

      redirect_to root_path, notice: "Signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def get_event
    @event = Event.last
  end

  def invite_params
    params.require(:invitation).permit(:rsvp_answer, :rsvp_count,
      user_attributes: [ :full_name, :email_address, :password, :password_confirmation ])
  end

  def set_invite_by_code
    if Current.user.present?
      redirect_to root_path

      nil
    else
      begin
        @invite = Invitation.find_by!(invite_code: params[:code], user_id: nil)
      rescue ActiveRecord::RecordNotFound
        redirect_to new_session_path, alert: "Invitation code has already been used... please login below."
      end
    end
  end
end
