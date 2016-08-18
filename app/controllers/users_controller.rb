class UsersController < ApplicationController

  has_many :listings, :dependent => :destroy

end
