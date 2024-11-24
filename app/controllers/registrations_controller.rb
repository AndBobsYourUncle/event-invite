class RegistrationsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_invite_by_code, only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      start_new_session_for(@user)
      redirect_to root_path, notice: "Signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:email_address, :password, :password_confirmation])
  end

  def set_invite_by_code
    @invite = Invitation.find_by_invite_code!(params[:code])
  rescue ActiveRecord::RecordNotFound
    redirect_to new_session_path, alert: "Invitation code has already been used... please login below."
  end
end
