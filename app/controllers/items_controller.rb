class ItemsController < ApplicationController
  def index
    @item = Item.find(params[:items_id])
    @documents = Document.where(item_id: params[:items_id]).order("date ASC")
  end
end
