class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :current_individual
  before_action :require_sign_in_individual!
  helper_method :signed_in_individual?
  skip_before_action :require_sign_in_individual!, if: :devise_controller?

  def sign_in_individual(individual)
    # remember_token = Individual.new_remember_token
    cookies.permanent[:individual_id] = individual.id
    # individual.update!(remember_token: Individual.encrypt(remember_token))
    @current_individual = individual
  end

  def sign_out_individual
    cookies.delete(:individual_id)
  end

  def signed_in_individual?
    @current_individual.present?
  end

  def default_url_options
    if @current_individual
      { individual_id: @current_individual.id }
    else
      { individual_id: params[:individual_id] }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    if resource
      new_sessions_path
    else
      user_session_path
    end
  end

  def require_sign_in_individual!
    redirect_to new_sessions_path unless signed_in_individual?
  end

  def current_individual
    individual_id = cookies[:individual_id]
    @current_individual ||= Individual.find_by(id: individual_id)
  end

end
