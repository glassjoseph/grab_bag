class Users::Folders::Invites::InviterMailer < ApplicationMailer
  def invite(inviter, folder, invitee)
    @folder = folder
    @inviter = inviter

    mail(to: invitee, subject: "#{inviter.name} wants to share #{folder.name} with you on Grab Bag")
  end
end
