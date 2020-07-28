class DocumentsController < ApplicationController

  def show
    @item = Item.find(params[:item_id])
    @company = Company.find(params[:company_id])
    @documents = Document.where(item_id: params[:item_id]).where(company_id: params[:company_id]).order("documents.date DESC")
  end
  
  def destroy
    document = Document.find(params[:id])
    document.destroy
    redirect_to individual_documents_path(item_id: params[:item_id], company_id: params[:company_id])
  end

  def edit
    document = Document.find(params[:id])
    document.note = params[:note]
    if document.save
      redirect_to individual_documents_path(item_id: params[:item_id], company_id: params[:company_id])
    else
      redirect_to individual_documents_path(item_id: params[:item_id], company_id: params[:company_id])
      flash[:alert] = '登録内容が間違っています'
    end
  end

  def edit_form
    @document = Document.find(params[:id])
    respond_to do |format|
      format.json { render json: @document }
    end
  end

  def new
    @document = Document.new
  end

  def create
    document = Document.new(document_new_params)
    if document.save
      redirect_to individual_documents_path(company_id: document.company_id, item_id: document.item_id)
    else
      redirect_to new_individual_document_path(company_id: params[:company_id], item_id: params[:item_id])
      flash[:alert] = '登録内容が誤っています'
    end
  end

  private

  def document_new_params
    params.require(:document).permit(:date, :author, :image, :note, :item_id, :company_id).merge(user_id: current_user.id)
  end

end
