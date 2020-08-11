class ListingsController < ApplicationController
  before_action :set_listing, only: [ :show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :model_instances, only: [ :index, :show, :new, :create, :edit ]

  # GET /listings
  # GET /listings.json
  # Queries database for all listing instances to display in the view.
  # These instances are filtered using the scope provided in the model, if they exist
  # to be left with all of the instances of listings which match the filtered search, if any.
  def index
    @listings = Listing.all
    filtering_params(params).each do |key, value|
      @listings = @listings.public_send("filter_by_#{key}", value) if value.present?
    end
  end
  # Queries the database for all listings that belong to the current user.
  def dashboard
    @listings = Listing.where(user_id: current_user.id)
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @users = User.all
  end

  # GET /listings/new
  # assigns a new instance to of the Listings to @variable for use in the view
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  # redirects any user who
  # redirects users to root path unless the listing belongs to them
  def edit
    redirect_to root_path unless current_user.id == @listing.user_id
  end

  # POST /listings
  # POST /listings.json
  # Takes the params from the form and creates a new listing
  # assigns the User_id data value to the current users id. 
  # Listing is saved and then user is redirected to the listing they just created.
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
    
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  # works in the same was as the create method basically, except the database updates/modifies the 
  # data stored in that instance, not create a new modified instance. 
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(:title, :description, :price, :brand_id, :style_id, :size_id, :state_id, :city_id, :postcode_id, :picture)
    end
    # filters the params hash so only the necessary params are filtered. 
    def filtering_params(params)
      params.slice(:brand_id, :style_id, :size_id, :state_id)
    end
    # Database queried to find all the instances in these models so that the names of data can be 
    # displayed to the user, rather than the foreign key stored in the Listings database table
    def model_instances
      @styles = Style.all
      @brands = Brand.all
      @sizes = Size.all
      @states = State.all
      @postcodes = Postcode.all
      @cities = City.all
    end
end
