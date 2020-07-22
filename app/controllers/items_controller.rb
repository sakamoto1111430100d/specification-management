class ItemsController < ApplicationController
  def index
    if @item = Item.find(params[:item_id])
      @documents = Document.where(item_id: params[:item_id]).order("date ASC")
    end
  end
end
