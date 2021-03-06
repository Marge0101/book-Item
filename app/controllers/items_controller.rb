class ItemsController < ApplicationController
  
  before_action :require_user_logged_in
  
 def new
    @items = []

    @keyword = params[:title]
    if @keyword.present? # 
      results = RakutenWebService::Books::Book.search({
        title: @keyword,
        imageFlag: 1,
        hits: 21,
      })

      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
    end
 end
 
 def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @reco_users = @item.reco_users
 end
 
end
