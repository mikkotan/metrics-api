class ApplicationController < ActionController::API
  include ResultHandler

  private

  def hash_params
    params.to_unsafe_h
  end
end
