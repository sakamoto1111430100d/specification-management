class SearchesController < ApplicationController


  def index
  end

  def new
    @company = Company.new
    @item = Item.new
    @document = Document.new
  end

  def create
    company = Company.new(company_params)
    company_name = company[:name]
    company_office = company[:office]
    company_name_office = Company.find_by(name: "#{company_name}", office: "#{company_office}")
    if company_name_office == nil
      company.save
      @companyId = company.id
    else
      @companyId = company_name_office.id
    end

    item = Item.new(item_params)
    item_name = item[:name]
    item_code = item[:code]
    item_name_code = Item.find_by(name: "#{item_name}", code: "#{item_code}")
    if item_name_code == nil
      item.save
      @itemId = item.id
    else
      @itemId = item_name_code.id
    end
    
    document = Document.new(document_params)
    document.save

    redirect_to searches_path
  end



  private

  def company_params
    params.require(:company).permit(:name, :office).merge(user_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :code).merge(user_id: current_user.id)
  end

  def document_params
    params.require(:document).permit(:date, :author, :image).merge(company_id: @companyId, item_id: @itemId)
  end

end