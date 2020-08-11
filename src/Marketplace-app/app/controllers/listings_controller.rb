class ListingsController < ApplicationController
  before_action :set_listing, only: [ :show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [ :index, :show ]

  # GET /listings
  # GET /listings.json
  def index
    @brands = Brand.all
    @styles = Style.all
    @sizes = Size.all
    @states = State.all
    @listings = Listing.all
    filtering_params(params).each do |key, value|
      @listings = @listings.public_send("filter_by_#{key}", value) if value.present?
    end
  end

  def dashboard
    @listings = Listing.where(user_id: current_user.id)
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @brands = Brand.all
    @styles = Style.all
    @sizes = Size.all
    @states = State.all
    @postcodes = Postcode.all
    @cities = City.all
    @users = User.all
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @styles = Style.all
    @brands = Brand.all
    @sizes = Size.all
    @states = State.all
    @postcodes = Postcode.all
    @cities = City.all
  end

  # GET /listings/1/edit
  def edit
    @styles = Style.all
    @brands = Brand.all
    @sizes = Size.all
    @states = State.all
    @postcodes = Postcode.all
    @cities = City.all
  end

  # POST /listings
  # POST /listings.json
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

    def filtering_params(params)
      params.slice(:brand_id, :style_id, :size_id, :state_id)
    end
end
