class DocumentsController < ApplicationController

  def show
    @item = Item.find(params[:item_id])
    @company = Company.find(params[:company_id])
    @documents = Document.where(item_id: params[:item_id]).where(company_id: params[:company_id])
  end
  
  def destroy
    document = Document.find(params[:id])
    document.destroy
    redirect_to documents_path(item_id: params[:item_id], company_id: params[:company_id])
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    document = Document.find(params[:id])
    if document.update(document_edit_params)
      redirect_to documents_path(company_id: document.company_id, item_id: document.item_id)
    else
      render :edit
    end
  end

  def new
    @document = Document.new
  end

  def create
    document = Document.new(document_new_params)
    if document.save
      redirect_to documents_path(company_id: document.company_id, item_id: document.item_id)
    else
      redirect_to new_document_path(company_id: params[:company_id], item_id: params[:item_id])
      flash[:alert] = '登録内容が誤っています'
    end
  end

  private

  def document_edit_params
    params.require(:document).permit(:note)
  end

  def document_new_params
    params.require(:document).permit(:date, :author, :image, :note, :item_id, :company_id).merge(user_id: current_user.id)
  end

end
