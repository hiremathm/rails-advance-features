class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token#, only: [:import]
  # GET /products
  # GET /products.json
  $otp = ""

  def index
    @product = Product.new
    products = Rails.cache.read('products')
    if products
      @q = products.ransack(params[:q])
      @products = @q.result.page params[:page]
    else 
      Rails.cache.write('products', Product.all)
      products = Rails.cache.read('products')
      @q = products.ransack(params[:q])
      @products = @q.result.page params[:page]
    end

    respond_to do |format|
      format.html
      format.csv {send_data @products.export_to_csv}
      format.xls {export_excel(@products)}
      # format.xlsx {send_data @products.export_excelx, filename: "sample.xlsx"}
      format.xlsx {export_excelx(@products)}
    end
  end

  #Export Data to excel spreadsheet
  def export_excel(products)
    Spreadsheet.client_encoding = 'UTF-8'
    spreadsheet = Spreadsheet::Workbook.new
    sheet1 = spreadsheet.create_worksheet :name => "product-2"
    sheet1.row(0).concat %w(Id Name Price Category Stock Description Cod Date)
    products.each_with_index do |product, index|
      sheet1.row(index + 1).push product.id, product.name,product.price,product.category_id,product.stock,product.description,product.cod_eligible,product.release_date 
    end 
    spreadsheet.write "file.xls"
    send_file 'file.xls', :type=>"application/xls", :x_sendfile=>true, :dispoition => 'attachment'
  end

  #Export Data to excelx spreadsheet
  def export_excelx(products)
    p = Axlsx::Package.new
    p.workbook.add_worksheet(:name => "products") do |sheet|
      sheet.add_row ["id", "name", "price", "category_id", "stock", "description", "cod_eligible", "release_date"]
      products.each do |product|
         sheet.add_row [product.id, product.name, product.price, product.category_id, product.stock, product.description, product.cod_eligible, product.release_date]
       end
    end
    p.use_shared_strings = true 
    p.serialize('simple.xlsx')
    send_file 'simple.xlsx', :type=>"application/xlsx", :x_sendfile=>true
  end

  #Import
  def import
    file = params["file"]
    if file.present?    
      Product.import_file(file, current_user)
      redirect_to products_path, notice: 'Your file has been uploaded successfully and Products are imported successfully'
    else
      redirect_to import_or_export_path, notice: 'Please Upload CSV File'
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    # render json: @produt
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        res = Product.create_at_ott(product_params)
        if res.options[:return_code] == :ok
          format.html { redirect_to @product, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { redirect_to @product, notice: 'Product was not successfully created.' }
        end
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

  def generate_otp
    $otp = SecureRandom.urlsafe_base64(6)
    Mailer.send_otp(params[:user_id], $otp).deliver_now!
    redirect_to verify_otp_path
  end

  def verify
    if params["otp"] == $otp
      redirect_to products_path
    else
      redirect_to root_path
    end
  end

  def all_products
    render json: Product.all
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :file, :price, :image ,:category_id, :stock, :description, :cod_eligible, :release_date)
    end
end
