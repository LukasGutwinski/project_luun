class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  def index
    params[:max_price] == "" ? @max_price = 999999 : @max_price = params[:max_price].to_i
    params[:min_price] == "" ? @min_price = 0 : @min_price = params[:min_price].to_i
    if params[:brand] == "" && params[:model] == ""
      @search_term = "*"
    else
      @search_term = "#{params[:brand]} #{params[:model]}"
    end
    @listings = Listing.search @search_term, fields: [:brand, :model]
    @listings = @listings.select{ |listing| @min_price <= listing.price && listing.price <= @max_price }

    session[:query_string] = request.query_parameters.to_query
    # @listings = Listing.search "#{params[:brand]} #{params[:model]}", fields: [:brand, :model]
    # @listings = Listing.search "#{params[:brand]} #{params[:model]}", fields: [:brand, :model], query: {query_string: {query: price_range}}
    # @listings = Listing.search "#{params[:brand]} #{params[:model]}", fields: [:brand, :model], where("price < ?", params[:max_price])
  end

  def show
    @request = Request.new
    @query_string = session[:query_string]
  end

  def new
    @listing = Listing.new
    @brands = ["Abarth", "AC", "Acura", "Aixam", "Asia Motors", "Aston Martin", "Audi", "Austin", "Austin Healey", "Bentley", "BMW", "Borgward", "Brilliance", "Bugatti", "Buick", "Cadillac", "Casalini", "Caterham", "Chatenet", "Chevrolet", "Chrysler", "Citroën", "Cobra", "Corvette", "Dacia", "Daewoo", "Daihatsu", "DeTomaso", "Dodge", "Donkervoort", "DS Automobiles", "Ferrari", "Fiat", "Fisker", "Ford", "GAC Gonow", "Gemballa", "GMC", "Grecav", "Hamann", "Holden", "Honda", "Hummer", "Hyundai", "Infiniti", "Isuzu", "Iveco", "Jaguar", "Jeep", "Kia", "Koenigsegg", "KTM", "Lada", "Lamborghini", "Lancia", "Land Rover", "Landwind", "Lexus", "Ligier", "Lincoln", "Lotus", "Mahindra", "Maserati", "Maybach", "Mazda", "McLaren", "Mercedes-Benz", "MG", "Microcar", "MINI", "Mitsubishi", "Morgan", "Nissan", "NSU", "Oldsmobile", "Opel", "Pagani", "Peugeot", "Piaggio", "Plymouth", "Pontiac", "Porsche", "Proton", "Renault", "Rolls-Royce", "Rover", "Ruf", "Saab", "Santana", "Seat", "Skoda", "Smart", "speedART", "Spyker", "Ssangyong", "Subaru", "Suzuki", "Talbot", "Tata", "TECHART", "Tesla", "Toyota", "Trabant", "Triumph", "TVR", "Volkswagen", "Volvo", "Wartburg", "Westfield", "Wiesman"]
    @conditions = ["Brand new", "Used", "Not roadworthy"]
  end

  def edit
    @brands = ["Abarth", "AC", "Acura", "Aixam", "Asia Motors", "Aston Martin", "Audi", "Austin", "Austin Healey", "Bentley", "BMW", "Borgward", "Brilliance", "Bugatti", "Buick", "Cadillac", "Casalini", "Caterham", "Chatenet", "Chevrolet", "Chrysler", "Citroën", "Cobra", "Corvette", "Dacia", "Daewoo", "Daihatsu", "DeTomaso", "Dodge", "Donkervoort", "DS Automobiles", "Ferrari", "Fiat", "Fisker", "Ford", "GAC Gonow", "Gemballa", "GMC", "Grecav", "Hamann", "Holden", "Honda", "Hummer", "Hyundai", "Infiniti", "Isuzu", "Iveco", "Jaguar", "Jeep", "Kia", "Koenigsegg", "KTM", "Lada", "Lamborghini", "Lancia", "Land Rover", "Landwind", "Lexus", "Ligier", "Lincoln", "Lotus", "Mahindra", "Maserati", "Maybach", "Mazda", "McLaren", "Mercedes-Benz", "MG", "Microcar", "MINI", "Mitsubishi", "Morgan", "Nissan", "NSU", "Oldsmobile", "Opel", "Pagani", "Peugeot", "Piaggio", "Plymouth", "Pontiac", "Porsche", "Proton", "Renault", "Rolls-Royce", "Rover", "Ruf", "Saab", "Santana", "Seat", "Skoda", "Smart", "speedART", "Spyker", "Ssangyong", "Subaru", "Suzuki", "Talbot", "Tata", "TECHART", "Tesla", "Toyota", "Trabant", "Triumph", "TVR", "Volkswagen", "Volvo", "Wartburg", "Westfield", "Wiesman"]
    @conditions = ["Brand new", "Used", "Not roadworthy"]
  end

  def create
    @listing = Listing.new(listing_params)

    #doing this for testing purposes until the login module is added
    # @listing.user = User.find(1)
    @listing.user = current_user
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

  private

  def listing_params
    params.require(:listing).permit(:brand, :model, :title, :mileage, :description, :price, :year, :condition, :origin, :city, photos: [])
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end

