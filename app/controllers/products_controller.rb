class ProductsController < ApplicationController

  def index
    @products = Product.includes(:user).all
    
    respond_to do |format|
      format.html # show default view
      format.json {render :json => @products}
    end
  end

  def create
    @product = Product.new(params[:product])

    respond_to do |format| 
      if @product.save
        format.html { render :action => "create" }
        format.json { render :json => @product }
      else 
        format.html { render :action => "new" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.where(:id => params[:id]).first
  end

  def edit
    @product = Product.where(:id => params[:id]).first
  end

  def update
    @product = Product.where(:id => params[:id]).first

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, :notice => 'Product was successfully updated.' }
        format.json { head :no_content }
      else 
        format.html { render action: "edit" }
        format.json { render json: @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.where(:id => params[:id]).first
    @product.destroy!

    respond_to do |format| 
      format.html { redirect_to products_url }
      format.json { head :no_content}
    end
  end


# Alernative method to discover what's going wrong. 

#  def destroy
#   @product = Product.find(params[:id])
#     Rails.logger.info ">>>> Product: #{@product.inspect}"
#     Rails.logger.info ">>>> You have #{Product.count} products before destroy."
#       if @product.destroy
#         Rails.logger.info ">>>> You now have #{Product.count} products. Destroying success? #{success}."
#         flash[:notice] = "The product was destroyed."
#       else
#         Rails.logger.info ">>>> Whoops! Product not destroyed!"
#         flash[:error] = "Product couldn't be destroyed!"
#       end

#       respond_to do |format| 
#         format.html { redirect_to products_url }
#         format.json { head :no_content}
#     end
#   end


end
