class List::Invitation
  include ActiveModel::Model

  attr_accessor :list, :email, :inviter, :membership

  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}

  def create
    return self unless valid?

    user = User.find_by(email:) || User.invite!(email, by: inviter)

    if user.list_memberships.exists?(list:)
      errors.add(:base, I18n.translate("list.invitation.user_already_a_member"))
      return self
    end

    @membership = List::Membership.create(list:, user:, role: List::Membership::PARTICIPANT_ROLE)

    unless @membership.valid?
      errors.add(:base, I18n.translate("list.invitation.could_not_add_user_to_the_list"))
      return self
    end

    self
  end
end
