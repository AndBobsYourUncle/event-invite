class Admin::InvitationsController < ApplicationController
  layout 'admin'
  before_action :verify_admin

  def index
    @invites = Invitation.all
  end

  def new
    @invite = Invitation.new
  end

  def create
    @invite = Invitation.new(invite_params)

    @invite.invite_code = SecureRandom.hex(10)

    if @invite.save
      redirect_to admin_invitations_path, notice: "Invite created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @invite = Invitation.find(params[:id])

    if @invite.destroy
      redirect_to admin_invitations_path, notice: "Invite deleted"
    else
      error_messages = @invite.errors.full_messages.map { |e| e }.join(", ")

      redirect_to admin_invitations_path, alert: error_messages
    end
  end

  private

  def invite_params
    params.expect(invitation: [ :email_address, :full_name ])
  end

  def verify_admin
    redirect_to root_path unless Current.user.admin?
  end
end
