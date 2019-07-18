class User < ApplicationRecord
  enum role: [:user, :admin]
  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end
  before_create :confirmation_token
  has_secure_password
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
