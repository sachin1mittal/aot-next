module Concerns::Errors
  extend ::ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActiveRecord::RecordNotSaved, with: :render_unprocessable_entity
    rescue_from ActiveRecord::DeleteRestrictionError, with: :render_not_acceptable
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from AbstractController::ActionNotFound, with: :render_not_found
    rescue_from ActionController::ActionControllerError, with: :render_bad_request
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
    rescue_from RailsParam::Param::InvalidParameterError, with: :render_invalid_params
    rescue_from Unauthorized, with: :render_unauthorized
  end
end
