class Api::PropertyListingsController < ApplicationController
  before_action :authenticate_agent!, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :update]
  before_action :set_property_listing, only:  [:show, :update, :destroy]



end
