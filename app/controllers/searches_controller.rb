class SearchesController < ApplicationController
  include SearchesHelper

  def index
    @companies = []
    @companyLists = Company.includes(:users).where(users: {id: current_user}).order("companies.updated_at DESC")
    @itemLists = Item.includes(:users).where(users: {id: current_user}).order("items.updated_at DESC")
  end

  def new
    @company = Company.new
    @item = Item.new
    @document = Document.new
  end





  def create
    company_create = Company.new(company_params)
    item_create = Item.new(item_params)
    if company_check(company_create) == nil
      if company_create.save
        @company_id = company_create.id
        if item_check(item_create) == nil
          if item_create.save
            @item_id = item_create.id
            document_create = Document.new(document_params)
            if document_create.save
              redirect_to action: :new
              flash[:notice] = '登録されました'
            else
              company_create.destroy
              item_create.destroy
              redirect_to action: :new
              flash[:alert] = '納入仕様書の登録内容が誤っています'
            end
          else
            company_create.destroy
            redirect_to action: :new
            flash[:alert] = '製品の登録内容以下が誤っています'
          end
        else
          @item_id = item_check(item_create).id
          document_create = Document.new(document_params)
          if document_create.save
            redirect_to action: :new
            flash[:notice] = '登録されました'
          else
            company_create.destroy
            redirect_to action: :new
            flash[:alert] = '納入仕様書の登録内容が誤っています'
          end
        end
      else
        redirect_to action: :new
        flash[:alert] = '会社の登録内容以下が誤っています'
      end
    else
      @company_id = company_check(company_create).id
      if item_check(item_create) == nil
        if item_create.save
          @item_id = item_create.id
          document_create = Document.new(document_params)
          if document_create.save
            redirect_to action: :new
            flash[:notice] = '登録されました'
          else
            item_create.destroy
            redirect_to action: :new
            flash[:alert] = '納入仕様書の登録内容が誤っています'
          end
        else
          redirect_to action: :new
          flash[:alert] = '製品の登録内容以下が誤っています'
        end
      else
        @item_id = item_check(item_create).id
        document_create = Document.new(document_params)
        if document_create.save
          redirect_to action: :new
          flash[:notice] = '登録されました'
        else
          redirect_to action: :new
          flash[:alert] = '納入仕様書の登録内容が誤っています'
        end
      end
    end
  end





  # def create
  #   company = Company.new(company_params)
  #   company_name = company[:name]
  #   company_office = company[:office]
  #   company_name_office = Company.find_by(name: "#{company_name}", office: "#{company_office}")
  #   if company_name_office == nil
  #     company.save
  #     @company_id = company.id
  #   else
  #     @company_id = company_name_office.id
  #   end
  #   item = Item.new(item_params)
  #   item_name = item[:name]
  #   item_code = item[:code]
  #   item_name_code = Item.find_by(name: "#{item_name}", code: "#{item_code}")
  #   if item_name_code == nil
  #     item.save
  #     @item_id = item.id
  #   else
  #     @item_id = item_name_code.id
  #   end
  #   document = Document.new(document_params)
  #   document.save
  #   redirect_to action: :new
  # end


  def search
    return nil if params[:keyword] == ""
    companyLists = Company.includes(:users).where(users: {id: current_user})
    itemsLists = Item.includes(:users).where(users: {id: current_user})

    @companies = companyLists.where("name LIKE ?", "%#{params[:keyword]}%").order("companies.id").limit(5)
    @items = itemsLists.where("name LIKE ?", "%#{params[:keyword]}%").order("items.id").limit(5)

    @user_id = current_user.id
    
    respond_to do |format|
      format.json
    end
  end


  private

  def company_params
    params.require(:company).permit(:name, :office)
  end

  def item_params
    params.require(:item).permit(:name, :code)
  end

  def document_params
    params.require(:document).permit(:date, :author, :image, :note).merge(company_id: @company_id, item_id: @item_id, user_id: current_user.id)
  end

  # def create_params
  #   params.require(:company).permit(:date, :author, :image, companies_attributes: [:name, :office], items_attributes: [:name, :code])
  # end

end







# class SearchesController < ApplicationController

#   def index
#     @companies = []
#     @companyLists = Company.includes(:users).where(users: {id: current_user}).order("companies.updated_at DESC").limit(5)
#     @itemLists = Item.includes(:users).where(users: {id: current_user}).order("items.updated_at DESC").limit(5)
#   end

#   def new
#     @company = Company.new
#     @item = Item.new
#     @document = Document.new
#   end

#   def create
#     company = Company.new(company_params)
#     company_name = company[:name]
#     company_office = company[:office]
#     company_name_office = Company.find_by(name: "#{company_name}", office: "#{company_office}")
#     if company_name_office == nil
#       binding.pry
#       company.save
#       @companyId = company.id
#     else
#       @companyId = company_name_office.id
#     end

#     item = Item.new(item_params)
#     item_name = item[:name]
#     item_code = item[:code]
#     item_name_code = Item.find_by(name: "#{item_name}", code: "#{item_code}")
#     if item_name_code == nil
#       binding.pry
#       item.save
#       @itemId = item.id
#     else
#       @itemId = item_name_code.id
#     end
    
#     document = Document.new(document_params)
#     binding.pry
#     document.save

#     redirect_to searches_path
#   end

#   def search
#     return nil if params[:keyword] == ""
#     companyLists = Company.includes(:users).where(users: {id: current_user})
#     itemsLists = Item.includes(:users).where(users: {id: current_user})

#     @companies = companyLists.where("name LIKE ?", "%#{params[:keyword]}%").order("companies.id").limit(5)
#     @items = itemsLists.where("name LIKE ?", "%#{params[:keyword]}%").order("items.id").limit(5)

#     @user_id = current_user.id
    
#     respond_to do |format|
#       format.html
#       format.json
#     end
#   end

#   private

#   def company_params
#     params.require(:company).permit(:name, :office)
#   end

#   def item_params
#     params.require(:item).permit(:name, :code)
#   end

#   def document_params
#     params.require(:document).permit(:date, :author, :image).merge(company_id: @companyId, item_id: @itemId, user_id: current_user.id)
#   end

# end
