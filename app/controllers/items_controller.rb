class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]
  before_action :must_logined, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user?, only: [:edit, :update, :destroy]

  def index
    @category = Category.all
  end

  def show
    @category = Category.all
    @images = @item.images
    @comments = @item.comments
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params.merge(user_id: current_user.id))
    @item.brand_id = get_brand_id
    if @item.save
      redirect_to item_path(@item)
    else
      @item.images.build if @item.images.length == 0
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      flash[:notice] = "エラーが発生しました。削除できません。"
      @images = @item.images
      redirect_to item_path(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :discription, :size, :condition, :delivary, :area, :preparation_day, :price, images_attributes: [:photo])
  end

  def brand_params
    params.require(:item).permit(:brand).values.first
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def admin_user?#出品者以外は詳細ページへリダイレクト
    set_item
    redirect_to item_path(@item) unless @item.user == current_user
  end

  def get_brand_id
    return nil unless brand_params
    if brand = Brand.find_by(name: brand_params)
      return brand.id
    else
      return Brand.create(name: brand_params).id
    end
  end
end
