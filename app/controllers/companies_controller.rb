class CompaniesController < ApplicationController
  def index
    if @company = Company.find(params[:company_id])
      @documents = Document.where(company_id: params[:company_id]).order("item_id ASC")
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    company = Company.find(params[:id])
    if company.update(company_params)
      redirect_to companies_path(company_id: params[:company_id])
    else
      redirect_to action: :edit
      flash[:alert] = '登録内容が間違っています'
    end
  end

  private
  def company_params
    params.require(:company).permit(:name, :office)
  end
end
