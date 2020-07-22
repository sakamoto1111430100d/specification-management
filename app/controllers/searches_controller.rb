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

end




