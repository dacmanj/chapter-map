class AssetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, :except => [:index, :edit]
  before_filter :chapter_leader?, :except => [:index, :new, :show]

  # GET /Assets
  # GET /Assets.json
  def index
    @assets = Asset.order(:chapter_id)
    if admin_user? && params[:search].blank?
        @assets = Asset.all
#      @assets = Assets.all.reject {|asset| }

    elsif !params[:search].blank?
      @assets = Asset.search(params)
    else
      @assets = Asset.find(:all, :conditions => ["chapter_id in (?)", current_user.chapter_ids])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assets.map{|asset| asset.to_jq } }
    end
  end

  # GET /Assets/1
  # GET /Assets/1.json
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /Assets/new
  # GET /Assets/new.json
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /Assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /Assets
  # POST /Assets.json
  def create
    @asset = Asset.new(params[:Asset])

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

  # PUT /Assets/1
  # PUT /Assets/1.json
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @Asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /Assets/1
  # DELETE /Assets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
