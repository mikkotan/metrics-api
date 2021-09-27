module ResultHandler
  include Dry::Monads[:result]

  STATEMENT_INVALID_MSG = 'Unable to save record due to database constraints.'.freeze

  def handle_result(result, success_status = :ok)
    case result
    in Success(payload)
      render json: payload, status: success_status
    in Failure[:not_found, e]
      handle_not_found(e)
    in Failure[:invalid_params, e]
      handle_unprocessable_entity(e)
    in Failure[:statement_invalid]
      handle_unprocessable_entity(STATEMENT_INVALID_MSG)
    else
      handle_bad_request
    end
  end

  private

  def handle_bad_request
    render_error('Something went wrong')
  end

  def handle_not_found(message)
    render_error(message, :not_found)
  end

  def handle_unprocessable_entity(error_messages)
    render_error(error_messages, :unprocessable_entity)
  end

  def render_error(payload, status = :bad_request)
    render json: { error: payload }, status: status
  end
end