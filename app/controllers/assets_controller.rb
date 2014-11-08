class AssetsController < ApplicationController
  load_and_authorize_resource
  # GET /assets
  # GET /assets.json
  def index
    @assets = current_user.assets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets.map{|asset| asset.to_jq } }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html {
          render :json => [@asset.to_jq].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@asset.to_jq]}, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @asset = Asset.find(params[:id].permit(Asset.allowed_attributes))

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to assets_url, notice: 'Asset was successfully updated.' }
        format.json { render json: {files: [@asset.to_jq]}, status: :created, location: @asset  }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /ssets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
