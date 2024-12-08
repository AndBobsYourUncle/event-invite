class InvitationsMailer < ApplicationMailer
  def rsvp(invite)
    @invite = invite

    subject = "#{@invite.full_name} RSVP'd #{@invite.rsvp_answer_yes? ? "Yes" : "No"}"

    admin_emails = User.where(admin: true).collect(&:email_address).join(",")

    mail subject: subject, to: admin_emails
  end
end
