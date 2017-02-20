module Concerns::ErrorHandlers
  extend ::ActiveSupport::Concern

  def render_bad_request(e)
    handle_error(e.message)
  end

  def render_not_found(e)
    handle_error(e.message)
  end

  def render_unprocessable_entity(e)
    handle_error(e.message)
  end

  def render_not_acceptable(e)
    handle_error(e.message)
  end

  def render_invalid_params(e)
    message = e.message
    if e.param.present?
      message += + ': ' + e.param.to_s
    end
    handle_error(message)
  end

  def render_unauthorized(e)
    handle_error(e.message)
  end

  private

  def handle_error(message)
    respond_to do |format|

      format.js do
        @error_message = message
        render 'templates/ajax_error_handler'
      end

      format.html do
        flash[:danger] = message
        if request.referrer.present?
          redirect_to :back
        else
          redirect_to root_path
        end
      end

    end
  end

end
