# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:3001"

    resource "*",
             headers: :any,
             same_site: :none,
             methods: %i[get post put patch delete options head],
             credentials: true
  end

  allow do
    origins "https://knsound.netlify.app/"

    resource "*",
             headers: :any,
             same_site: :none,
             methods: %i[get post put patch delete options head],
             credentials: true

  end
end
