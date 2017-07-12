class BrandController < ApplicationController

  def new
    @brand = Brand.new
  end

end