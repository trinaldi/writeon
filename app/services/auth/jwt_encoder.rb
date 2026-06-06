module Auth
  class JwtEncoder
    def self.call(user)
      new(user).call
    end

    def initialize(user)
      @user = user
    end

    def call
      JWT.encode(payload, secret_key, 'HS256')
    end

    private

    def payload
      {
        user_id: @user.id.to_s,
        exp: 24.hours.from_now.to_i
      }
    end

    def secret_key
      Rails.application.credentials.dig(:jwt, :secret).to_s
    end
  end
end
