class IndividualsController < ApplicationController
  skip_before_action :require_sign_in_individual!, only: [:new, :create]

  def index
    @params_id = params[:id]
    @individual = Individual.find(params[:individual_id])
    if params[:id] == "1"
      @documents = Document.where(individual_id: params[:individual_id])
    else
    end
    
  end

  def new
    @individual = Individual.new
  end

  def create
    individual = Individual.new(individual_params)
     if individual.save
      redirect_to new_sessions_path
     else
      render 'new'
     end
  end

  def edit
    individual = Individual.find(params[:id])
    individual.company = params[:company]
    individual.office = params[:office]
    individual.department = params[:department]
    individual.name = params[:name]
    if individual.save
      redirect_to individual_searches_path
      flash[:notice] = '登録されました'
    else
      redirect_to individual_searches_path
      flash[:alert] = '登録内容が間違っています'
    end
  end
  
  def edit_form
    @individual = Individual.find(params[:id])
    respond_to do |format|
      format.json { render json: @individual }
    end
  end

  private
  
  def individual_params
    params.require(:individual).permit(:email, :company, :office, :department, :name).merge(user_id: current_user.id)
  end
end
