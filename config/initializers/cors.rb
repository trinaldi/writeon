if Rails.env.production?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '/graphql',
               headers: :any,
               methods: %i[post options]
    end
  end
end
