class Session < ActiveRecord::Base

    validates :user_id, :session_token, presence: true

      before_validation :ensure_session_token

    belongs_to(:user,
        :class_name => "User",
        :foreign_key => :user_id,
        :primary_key => :id
    )

    def ensure_session_token
      token = SecureRandom::urlsafe_base64
      self.session_token ||= token
    end


end
