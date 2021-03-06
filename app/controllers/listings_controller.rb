class ListingsController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:new]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :find_favorite, only: [:index]
  def index
    params[:max_price] == "" ? @max_price = 999999 : @max_price = params[:max_price].to_i
    params[:min_price] == "" ? @min_price = 0 : @min_price = params[:min_price].to_i
    if params[:brand] == "" || params[:brand].nil?
      @search_term_brand = "*"
    else
      @search_term_brand = "#{params[:brand]}"
    end

    if params[:model] == "" || params[:model].nil?
      @search_term_model = "*"
    else
      @search_term_model = "#{params[:model]}"
    end

    @listings_brand = Listing.search @search_term_brand, fields: [{search_brand: :exact}]
    @listings_model = Listing.search @search_term_model, fields: [{search_model: :exact}]
    @listings = @listings_brand.to_a & @listings_model.to_a
    @listings = @listings.select{ |listing| @min_price <= listing.price && listing.price <= @max_price }
    session[:query_string] = request.query_parameters.to_query
    # @listings = Listing.search "#{params[:brand]} #{params[:model]}", fields: [:brand, :model]
    # @listings = Listing.search "#{params[:brand]} #{params[:model]}", fields: [:brand, :model], query: {query_string: {query: price_range}}
    # @listings = Listing.search "#{params[:brand]} #{params[:model]}", fields: [:brand, :model], where("price < ?", params[:max_price])
    @brands = Brand.all
    @car_hash = create_hash_cars(@brands)
  end

  def show
    @query_string = session[:query_string]
    @requested = false
    unless current_user.nil?
      current_user.requests.each do |request|
        @requested = true if request.listing == @listing
      end
    end
    if @requested == false
      @request = Request.new
    end
  end

  def new
    @listing = Listing.new
    @brands = Brand.all
    @brand_hash = create_hash_cars(@brands)
    @conditions = ["Brand new", "Used", "Not roadworthy"]
  end

  def edit
    @brands = ["Abarth", "AC", "Acura", "Aixam", "Asia Motors", "Aston Martin", "Audi", "Austin", "Austin Healey", "Bentley", "BMW", "Borgward", "Brilliance", "Bugatti", "Buick", "Cadillac", "Casalini", "Caterham", "Chatenet", "Chevrolet", "Chrysler", "Citroën", "Cobra", "Corvette", "Dacia", "Daewoo", "Daihatsu", "DeTomaso", "Dodge", "Donkervoort", "DS Automobiles", "Ferrari", "Fiat", "Fisker", "Ford", "GAC Gonow", "Gemballa", "GMC", "Grecav", "Hamann", "Holden", "Honda", "Hummer", "Hyundai", "Infiniti", "Isuzu", "Iveco", "Jaguar", "Jeep", "Kia", "Koenigsegg", "KTM", "Lada", "Lamborghini", "Lancia", "Land Rover", "Landwind", "Lexus", "Ligier", "Lincoln", "Lotus", "Mahindra", "Maserati", "Maybach", "Mazda", "McLaren", "Mercedes-Benz", "MG", "Microcar", "MINI", "Mitsubishi", "Morgan", "Nissan", "NSU", "Oldsmobile", "Opel", "Pagani", "Peugeot", "Piaggio", "Plymouth", "Pontiac", "Porsche", "Proton", "Renault", "Rolls-Royce", "Rover", "Ruf", "Saab", "Santana", "Seat", "Skoda", "Smart", "speedART", "Spyker", "Ssangyong", "Subaru", "Suzuki", "Talbot", "Tata", "TECHART", "Tesla", "Toyota", "Trabant", "Triumph", "TVR", "Volkswagen", "Volvo", "Wartburg", "Westfield", "Wiesman"]
    @conditions = ["Brand new", "Used", "Not roadworthy"]
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.brand = Brand.where(name: params[:listing][:brand][:name]).first
    @brand_model = BrandModel.where(name: params[:listing][:brand_model][:name]).first
    @listing.brand_model = @brand_model
    #doing this for testing purposes until the login module is added
    # @listing.user = User.find(1)
    @listing.user = current_user
    @listing.search_brand = @listing.brand.name
    @listing.search_model = @listing.brand_model.name
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def update
    @listing.update(listing_params)
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  def favorites
    @listings = current_user.best_listings
  end

  private

  def find_favorite
    unless current_user.nil?
      @favorite = Favorite.where("user_id" == current_user.id, "listing_id" == params[:listing_id])
    end
  end

  def listing_params
    params.require(:listing).permit(:brand, :model, :title, :mileage, :description, :price, :year, :condition, :origin, :city, photos: [])
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def create_hash_cars(brands)
    hash = {}
    brands.each do |brand|
      brand.brand_models.each do |model|
        if hash[brand.name]
          hash[brand.name] << model.name
        else
          hash[brand.name] = [model.name]
        end
      end
    end
    return hash
  end
end

