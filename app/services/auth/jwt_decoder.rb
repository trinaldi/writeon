module Auth
  class JwtDecoder
    def self.call(auth_header)
      new(auth_header).call
    end

    def initialize(auth_header)
      @auth_header = auth_header
    end

    def call
      return nil if token.blank?

      payload = decode_token
      return nil unless payload

      find_user(payload)
    end

    private

    def token
      return nil if @auth_header.blank?

      @auth_header.split.last
    end

    def decode_token
      JWT.decode(token, secret_key, true, algorithm: 'HS256').first
    rescue JWT::ExpiredSignature, JWT::DecodeError
      nil
    end

    def secret_key
      Rails.application.credentials.dig(:jwt, :secret).to_s
    end

    def find_user(payload)
      User.where(_id: BSON::ObjectId.from_string(payload['user_id'])).first
    end
  end
end
