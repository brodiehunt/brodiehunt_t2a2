class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :initialize_session, only: [:add_to_cart, :show, :cart]
  before_action :cart_items, only: [ :cart, :show ]
  before_action :model_instances, only: [ :search, :show, :new, :edit, :cart]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all    
  end

    # This is the same filtering method used in listings, it is described there.
  def search  
    @products = Product.all 
      filtering_params(params).each do |key, value|
        @products = @products.public_send("filter_by_#{key}", value) if value.present?
      end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  # Will not let a user go to this path unless they are me, the admin user. 
  # if that user is me, A new product instance is allocated
  def new
    redirect_to root_path unless current_user.id == 1
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    redirect_to root_path unless current_user.id == 1
  end

  # POST /products
  # POST /products.json
  # Creates a new product using the params passed in the create product form
  # if it is saved to the database, user is redirect to that products page
  def create
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
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def cart 
  end

  # Converts the params id into and integer
  # pushes the id into the session array unless that id already exists in the array
  # user redirected to the the products page
  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to product_path(id)
  end
  # deletes the id from the session cart, redirects to product just deleted
  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to product_path(id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description, :brand_id, :style_id, :size_id, :price, :picture)
    end
    # Obtains the neccessary params from the params hash for filtered search
    def filtering_params(params)
      params.slice(:brand_id, :style_id, :size_id)
    end
    # intitialises cart session if it hasnt already been initialised. 
    # This is done whenever someone has the potential to interact with the cart.
    def initialize_session
      session[:cart] ||= []
    end
    # queries the products table with the array of ids within the session.
    # returns all the instances of products that belong to these ids
    # used to display all items added to the cart session in the cart page
    def cart_items
      @cart = Product.find(session[:cart])
    end
    # database queried for all instances so that the names can be displayed in the view rather than ids.
    def model_instances
      @brands = Brand.all
      @styles = Style.all
      @sizes = Size.all
    end

end
