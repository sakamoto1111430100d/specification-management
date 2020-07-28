class SessionsController < ApplicationController
  skip_before_action :require_sign_in_individual!, only: [:new, :select]


  def new
    @individuals = Individual.where(user_id: current_user.id)
  end

  def select
    if @individual = Individual.find_by(session_params)
      sign_in_individual(@individual)
      redirect_to root_path(@individual.id)
    else
      redirect_to action: :new
    end
    # if @individual.authenticate(session_params[:password])
    #   sign_in_individual(@individual)
    #   redirect_to root_path
    # else
    #   flash.now[:danger] = t('.flash.invalid_password')
    #   render 'new'
    # end
  end

  def destroy
    sign_out_individual
    redirect_to new_sessions_path
  end

  private

  # def set_individual
  #   @individual = Individual.find_by!(mail: session_params[:mail])
  # rescue
  #   flash.now[:danger] = t('.flash.invalid_mail')
  #   render action: 'new'
  # end

  def session_params
    params.require(:individual).permit(:email)
  end

end
