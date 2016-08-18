class UsersController < ApplicationController

  has_many :listings, :dependent => :destroy
  has_many :requests, :dependent => :destroy

end
