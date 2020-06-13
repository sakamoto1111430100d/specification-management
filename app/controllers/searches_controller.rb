class SearchesController < ApplicationController

  def index
    @companies = []
    @companyLists = Company.all
    @itemsLists = Item.all

    # where(user_id: current_user.id)    

      
    # @companyList = []
    # @companyLists.each do |companyList|
    #   @companyList << companyList.date
    # end


  
    # @documents = @companyLists.map {|company| company.users.ids }   外部キー制約がcurrent_user.idの場合をしたい




    @itemLists = Item.all.includes(:documents).includes(:users)
    @documents
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

    redirect_to user_searches_path
  end

  def search
    return nil if params[:keyword] == ""
    @companies = Company.where("name LIKE ?", "%#{params[:keyword]}%")
    @items = Item.where("name LIKE ?", "%#{params[:keyword]}%")

    @user_id = current_user.id
    
    respond_to do |format|
      format.html
      format.json
    end
  end

    # @items = Item.where("name LIKE ?", "%#{params[:keyword]}%")
    # @companies = Company.joins(:items).all

    # modelにメソッドを持ったらエラーになる
    # keyword = params[:keyword]
    # @companies = Company.search(params[:keyword])


  private

  def company_params
    params.require(:company).permit(:name, :office)
  end

  def item_params
    params.require(:item).permit(:name, :code)
  end

  def document_params
    params.require(:document).permit(:date, :author, :image, :image_cache, :remove_image).merge(company_id: @companyId, item_id: @itemId, user_id: current_user.id)
  end

end