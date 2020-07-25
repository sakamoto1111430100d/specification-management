class CompaniesController < ApplicationController
  def index
    if @company = Company.find(params[:company_id])
      @documents = Document.where(company_id: params[:company_id]).order("item_id ASC")
    end
  end

  def edit
    company = Company.find(params[:id])
    company.name = params[:name]
    company.office = params[:office]
    if company.save
      redirect_to companies_path(company_id: params[:company_id])
    else
      redirect_to companies_path(company_id: params[:company_id])
      flash[:alert] = '登録内容が間違っています'
    end
  end

  def edit_form
    @company = Company.find(params[:id])
    respond_to do |format|
      format.json { render json: @company }
    end
  end

end
