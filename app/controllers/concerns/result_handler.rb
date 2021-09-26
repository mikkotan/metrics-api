module ResultHandler
  include Dry::Monads[:result]

  def handle_result(result, success_status = :ok)
    case result
    in Success(payload)
      render json: payload, status: success_status
    in Failure[:not_found, e]
      handle_not_found(e)
    in Failure[:invalid_params, e]
      handle_invalid_params(e)
    else
      handle_bad_request(result)
    end
  end

  private

  def handle_bad_request(result)
    render_error(result.failure)
  end

  def handle_not_found(message)
    render_error(message, :not_found)
  end

  def handle_invalid_params(error_messages)
    render_error(error_messages, :unprocessable_entity)
  end

  def render_error(payload, status = :bad_request)
    render json: { error: payload }, status: status
  end
end