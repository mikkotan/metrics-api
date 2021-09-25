module ErrorHandlers
  def handle_bad_request(result)
    render_error(result.failure)
  end

  def handle_not_found(message)
    render_error(message, :not_found)
  end

  def handle_invalid_params(error_messages)
    render_error(error_messages, :unprocessable_entity)
  end

  private

  def render_error(payload, status = :bad_request)
    render json: { error: payload }, status: status
  end
end