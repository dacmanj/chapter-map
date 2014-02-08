class ChaptersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => [:index]
  # GET /chapters
  # GET /chapters.json
  def index
    if index_json?
      authorize! :json, Chapter
      @chapters = Chapter.active
    else
      authorize! :index, Chapter
      if params[:commit] == "Search"
        @chapters = current_user.search(params[:chapter][:search],params[:chapter][:inactive])
      else
        @chapters = current_user.chapters.select{|h| !h.inactive? }
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chapters, :only => [:name,:website,:street,:city,:state,:zip,:latitude,:longitude] }
#        format.json { render json: @chapters }
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

      respond_to do |format|
        format.html { redirect_to :action => 'edit' }
        format.json { render json: @chapter }
      end

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
      case chapter.category
        when "Representative"
          marker.picture({
                    :url => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        end
      end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    @chapter = Chapter.find(params[:id])
    @hash = Gmaps4rails.build_markers(@chapter) do |chapter, marker|
      marker.lat chapter.latitude
      marker.lng chapter.longitude
      marker.title   "#{chapter.name}"
      marker.infowindow render_to_string(:partial => "/chapters/infowindow",  :formats => [:html], :locals => { :chapter => chapter})
      case chapter.category
        when "Representative"
          marker.picture({
                    :url => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        end
      end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(params[:chapter])

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
    message =  (errors.length > 0) ? errors.join(", ") : "Chapters imported."
    redirect_to chapters_path, notice: message
  end

  # PUT /chapters/1
  # PUT /chapters/1.json
  def update
    @chapter = Chapter.find(params[:id])

    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        flash[:notice] = 'Chapter was successfully updated'
        format.html { render action: "edit", notice: 'Chapter was successfully updated.' }
        format.json { render :json => { notice: 'Chapter was successfully updated'} }
      else
        @chapter.errors.each do |type,msg|
          flash[:error] = "Error: #{type}: #{msg}"
        end
        format.html { render action: "edit" }
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

end