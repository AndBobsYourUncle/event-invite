class InvitationsMailer < ApplicationMailer
  def rsvp(invite)
    @invite = invite

    subject = "#{@invite.full_name} RSVP'd #{@invite.rsvp_answer_yes? ? "Yes" : "No"}"

    admin_emails = User.where(admin: true).map(&:email_address)

    admin_emails.each do |admin_email|
      mail subject: subject, to: admin_email
    end
  end
end
