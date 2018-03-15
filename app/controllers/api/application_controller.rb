class Api::ApplicationController < ApplicationController
  # When making POST requests to our controllers Rails
  # will require an authenticity token in the params
  # to verify that POST originated from one of its
  # forms. This doesn't make for a JSON Web API therefore
  # we'll skip that code.
  skip_before_action :verify_authenticity_token

  rescue_from StandardError, with: :standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def not_found
      render(
        json: {
          errors: [{
            type: "NotFound"
          }]
        },
        status: :not_found # :not_found is alias for 404 in rails
      )
    end

  private

  def current_user
    token = request.headers["AUTHORIZATION"]

    # The decoded token will be array containing
    # the payload and the JWT header in that order.
    begin
      payload = JWT.decode(
        token,
        Rails.application.secrets.secret_key_base
      )&.first

      # To get a value from payload, make sure to use
      # strings to access the keys. The payload's hash's
      # keys are all strings and not symbols.
      @user ||= User.find_by(id: payload["id"])
    rescue JWT::DecodeError => error
      nil
    end
  end
  helper_method :current_usere

  def authenticate_user!
    head :unauthorized unless current_user.present?
  end

  protected

  def record_not_found(error)
    render(
      json: {
        errors: [{
          type: error.class.to_s,
          message: error.message
        }]
      },
      status: :not_found
    )
  end

  def standard_error(error)
    logger.error "#{error.class} #{error.message}"
    logger.error error.backtrace.join("\n")


    render(
      json: {
        errors: [{
          type: error.class.to_s,
          message: error.message
        }]
      },
      status: :internal_server_error
    )
  end

  def record_invalid(error)
    record = error.record
    errors = record.errors.map do |field,message|
      {
        type: error.class.to_s,
        record_type: record.class.to_s,
        field: field,
        message: message
      }
    end

    render(
      json: {
        errors: errors
      },
      status: :unprocessable_entity
    )
  end

end
