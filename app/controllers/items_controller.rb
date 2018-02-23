class ItemsController < ApplicationController
  
  before_action :require_user_logged_in
  
 def new
    @items = []

    @keyword = params[:title]
    if @keyword.present? # 
      results = RakutenWebService::Books::Book.search({
        title: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
        end
    end
 end

  private

  def read(result)
    code = result['isbn']
    name = result['title']
    url = result['itemUrl']
    image_url = result['largeImageUrl']

    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
