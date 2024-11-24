class RegistrationsController < ApplicationController
  optionally_authenticate
  before_action :set_invite_by_code, only: %i[ new create ]
  rate_limit to: 10, within: 1.minutes, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
    @user = User.new(email_address: @invite.email_address)
  end

  def create
    @user = User.new(user_params)

    @user.full_name = @invite.full_name

    ActiveRecord::Base.transaction do
      @user.save
      @invite.update!(user_id: @user.id)
    end

    if @user.id.present?
      start_new_session_for(@user)
      redirect_to root_path, notice: "Signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :email_address, :password, :password_confirmation ])
  end

  def set_invite_by_code
    if Current.user.present?
      redirect_to root_path
    end

    @invite = Invitation.find_by!(invite_code: params[:code], user_id: nil)
  rescue ActiveRecord::RecordNotFound
    redirect_to new_session_path, alert: "Invitation code has already been used... please login below."
  end
end
