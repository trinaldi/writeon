class DebugController < ApplicationController
  def index
    render json: {
      rails_master_key: ENV['RAILS_MASTER_KEY'].present? ? "✓ present" : "✗ missing",
      mongo_uri_preview: Rails.application.credentials.mongoid[:mongo_uri]&.split('@')&.first + "@..."
    }
  end
end
