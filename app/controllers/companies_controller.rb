class CompaniesController < ApplicationController
  def index
    @company = Company.find(params[:company_id])
    @documents = Document.where(company_id: params[:company_id])
    @items = Item.find(@documents[0][:item_id])
  end

  # def document(documents)
  #   documents.each do |document|
  #     return document.items
  #   end
  # end

end
