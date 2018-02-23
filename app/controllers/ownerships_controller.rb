class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])

    unless @item.persisted?
      # @item が保存されていない場合、先に @item を保存する
      results = RakutenWebService::Books::Book.search(isbn: @item.code)

      @item = Item.new(read(results.first))
      @item.save
    end

    # Want として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '購入考え中に登録しました。'
    end
    
    # Reco として保存
    if params[:type] == 'Reco'
      current_user.reco(@item)
      flash[:success] = 'オススメに登録しました。'
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])

    if params[:type] == 'Want'
      current_user.unwant(@item) 
      flash[:success] = '購入考え中 を解除しました。'
    end
    
    if params[:type] == 'Reco'
      current_user.unreco(@item) 
      flash[:success] = 'オススメを解除しました。'
    end

    redirect_back(fallback_location: root_path)
  end
end
