class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:q]
      search_term = params[:q]
      logger.debug "request.original_url is #{request.original_url}"
      @products = Product.search(request.original_url, search_term)
    else
      @products = Product.all
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @comments = @product.comments.order("created_at DESC").page(params[:page]).per_page(3)
  end

  # GET /products/new
  def new
    if (signed_in? && current_user.admin?)
      @product = Product.new
    else
      redirect_to products_url, alert: 'Unauthorized access' 
    end
  end

  # GET /products/1/edit
  def edit
    if (!signed_in? || !current_user.admin?)
      redirect_to products_url, alert: 'Unauthorized access'
    end
  end

  # POST /products
  # POST /products.json
  def create
    if (signed_in? && current_user.admin?)
      @product = Product.new(product_params)
  
      respond_to do |format|
        if @product.save
          format.html { redirect_to @product, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to products_url, alert: 'Unauthorized access' 
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if (signed_in? && current_user.admin?)
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to @product, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to products_url, alert: 'Unauthorized access' 
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if (signed_in? && current_user.admin?)
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to products_url, alert: 'Unauthorized access' 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :image_url, :price)
    end
end
