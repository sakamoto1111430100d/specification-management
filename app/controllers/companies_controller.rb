class CompaniesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @documents = Document.where(company_id: params[:company_id]).order("item_id ASC")
  end

  def edit
    @company = Company.find(params[:company_id])
    @company_id = params[:company_id]
  end

  def update
    company = Company.where(id: params[:id])
    company.update(company_params)
    redirect_to companies_path(company_id: params[:id], user_id: current_user.id)
  end

  private
  def company_params
    params.require(:company).permit(:name, :office, :id)
  end
end
