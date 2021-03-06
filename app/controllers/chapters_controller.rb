class ChaptersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:index]
  skip_load_resource :only => [:show]
  # GET /chapters
  # GET /chapters.json
  def index
    if index_json?
      authorize! :json, Chapter
      @chapters = Chapter.active
    else
      authorize! :index, Chapter
      if params[:commit] == "Search"
        @chapters = @chapters.search(params[:chapter])
      else
        @chapters = @chapters.active
      end
    end

    @chapters = @chapters.paginate(:page => params[:page]) unless index_csv? or index_json?

    if params[:database_identifier].present?
      json_fields = [:database_identifier, :name,:website,:street,:city,:state,:zip,:latitude,:longitude,:ein]
      if params[:sort] == "name"
        @chapters = @chapters.order(:name)
      else
        @chapters = @chapters.order(:database_identifier)
      end
    else
      @chapters = @chapters.order(:name)
      json_fields = [:name,:website,:street,:city,:state,:zip,:latitude,:longitude]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chapters, :only => json_fields, :callback => params['callback'], content_type: (params['callback'].present? ? "application/javascript" : "application/json") }
      format.csv { send_data Chapter.to_csv(@chapters) }
    end
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    if params[:id] == 'import'
      render 'import'
    else
      @chapter = Chapter.find(params[:id])
      redirect_to :action => 'edit'
    end
  end

  # GET /chapters/new
  # GET /chapters/new.json
  def new
    @chapter = Chapter.new
    @chapter.latitude = "38.9036656"
    @chapter.longitude = "-77.0429285"
    @chapter.name = "PFLAG "
    @chapter.id = -1
    @hash = Gmaps4rails.build_markers(@chapter) do |chapter, marker|
      marker.lat chapter.latitude
      marker.lng chapter.longitude
      marker.title   "#{chapter.name}"
      marker.infowindow render_to_string(:partial => "/chapters/infowindow",  :formats => [:html], :locals => { :chapter => chapter})
      marker.picture(chapter.gmaps_marker_params)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    @hash = Gmaps4rails.build_markers(@chapter) do |chapter, marker|
      marker.lat chapter.latitude
      marker.lng chapter.longitude
      marker.title   "#{chapter.name}"
      marker.infowindow render_to_string(:partial => "/chapters/infowindow",  :formats => [:html], :locals => { :chapter => chapter})
      marker.picture(chapter.gmaps_marker_params)
    end
    respond_to do |format|
      flash.now
      format.html
      format.json { render json: @chapter }
    end
  end

  # POST /chapters
  # POST /chapters.json
  def create
    respond_to do |format|
      if @chapter.save
        format.html { render action: "edit", notice: 'Chapter was successfully created.' }
        format.json { render json: @chapter, status: :created, location: @chapter }
      else
        format.html { render action: "new" }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    errors = Chapter.import(params[:file])
    message =  (errors.length > 0) ? errors.join("<br>") : "Chapters imported."
    redirect_to chapters_path, notice: message.html_safe
  end

  # PUT /chapters/1
  # PUT /chapters/1.json
  def update
    if @chapter.update_attributes(chapter_params)
      if request.format.json?
        @infowindow = render_to_string :partial => 'chapters/infowindow', locals: { :chapter => @chapter}
        @chapter_hash = @chapter.attributes
        @chapter_hash[:infowindow] = @infowindow
        respond_to do |format|
          flash[:notice] = 'Chapter was successfully updated'
          format.json { render json: @chapter_hash.to_json }
        end
      else
        redirect_to edit_chapter_url, notice: 'Chapter was successfully updated.'
      end
    else
      respond_to do |format|
        @chapter.errors.each do |type,msg|
          flash[:error] = "Error: #{type}: #{msg}"
        end
        format.html { redirect_to edit_chapter_path }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to chapters_url }
      format.json { head :no_content }
    end
  end

  def delete_multiple
    @chapters = Chapter.find(params[:chapter_ids])
    @chapters.each do |chapter|
      chapter.destroy
    end
    flash[:notice] = "Deleted chapters!"
    redirect_to chapters_path
  end

  private

  def index_json?
      @_action_name ==  "index" and @_request.format.json?
  end


  def index_csv?
      @_action_name ==  "index" and @_request.format.csv?
  end




  def chapter_params
    params.require(:chapter).permit(:city, :ein, :email_1, :email_2, :email_3, :helpline, :latitude, :longitude, :name, :phone_1, :phone_2, :state, :street, :website, :meetings_multiple, :meetings_trans, :meetings_poc, :meetings_url, :zip, :radius, :category, :inactive, :separate_exemption, :users_attributes, :database_identifier, :attachment_ids, :bylaws, :attachments_attributes,:website_import_id, :facebook_url, :facebook_url_import_id, :twitter_url, :twitter_url_import_id, :email_1_import_id, :email_2_import_id, :email_3_import_id, :helpline_import_id, :phone_1_import_id, :phone_2_import_id, :address_import_id, :independent_import_id, :ein_import_id,:meetings_multiple_import_id, :meetings_trans_import_id, :meetings_poc_import_id, :meetings_url_import_id, :revoked, :revocation_date, :position_lock,
     :ambiguate_address, :pending, :pending_reason)
  end

end
