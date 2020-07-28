class StocksController < ApplicationController

  def create
    stock = Stock.new(document_id: params[:document_id], individual_id: params[:individual_id])
    stock.save
    @document = Document.find(params[:document_id])
    respond_to do |format|
      format.json { render json: @document }
    end
  end

  def destroy
    stock = Stock.find_by(document_id: params[:document_id], individual_id: params[:individual_id])
    stock.destroy
    @document = Document.find(params[:document_id])
    respond_to do |format|
      format.json { render json: @document }
    end
  end
 
end
