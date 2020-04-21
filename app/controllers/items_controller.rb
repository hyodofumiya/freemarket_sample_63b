class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :must_logined, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user?, only: [:edit, :update, :destroy]
  before_action :set_size, only: [:new, :create, :edit, :update, :destroy]
  INDEX_ROW_COUNT = 5

  def index
    @items = Item.all.order(created_at: :DESC).includes(:comments, :favorites, :images)
    @category_items = array_items_by_category
  end

  def show
    @images = @item.images
    @comments = @item.comments
  end

  def new
    @item = Item.new
    gon.roots = @category.roots
    @item.images.build
  end

  def create
    @item = Item.new(item_params.merge(user_id: current_user.id, category_id: category_params))
    @item.brand_id = get_brand_id
    @item.delete_empty_image
    @item.delete_images(item_params[:images_attributes])
    if @item.save
      redirect_to user_item_path(user_id: current_user.id, id: @item.id)
    else
      gon.roots = @category.roots
      @item.images.build
      render :new
    end
  end

  def edit
    gon.roots = @category.roots
    gon.p_category = @item.category.parent.siblings
    @item.images.build
  end

  def update
    @item.delete_empty_image
    # @item.delete_images(item_params[:images_attributes])
    @item.replace_image(item_params[:images_attributes])
    if @item.update(update_params.merge(brand_id: get_brand_id, category_id: category_params))
      redirect_to item_path(@item)
    else
      gon.roots = @category.roots
      @item.images.build
      render :edit
    end
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

  def exhibit_items
    @card = CreditCard.where(user_id: current_user.id)
    @user = User.find(params[:user_id])
    @items = @user.items
  end

  def sale_items
    @card = CreditCard.where(user_id: current_user.id)
    @user = User.find(params[:user_id])
    @items = @user.items.where(status: true)
  end

  private

  def item_params
    params.require(:item).permit(:name, :discription, :size, :condition, :delivary, :area, :preparation_day, :price, images_attributes: [:photo, :photo_cache, :id])
  end
  
  def update_params
    params.require(:item).permit(:name, :discription, :size, :condition, :delivary, :area, :preparation_day, :price)
  end

  def category_params
    category_id = params.require(:item).permit(:category_id)[:category_id].to_i
    category_id == 0 ? nil : category_id
  end

  def brand_params
    params.require(:item).permit(:brand_name).values.first
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

  def array_items_by_category
    item_array = []
    Category::DISPLAY_TOP_PAGE.each do |num|
      item_array << { id: num.to_s, items: Item.category_items(num)}
    end
    return item_array
  end
  
  def set_size
    @size = [['---選択してください---', ''], ['XS', '0'], ['S', '5'], ['M', '10'], ['L', '15'], ['XL', '20']]
  end


end
