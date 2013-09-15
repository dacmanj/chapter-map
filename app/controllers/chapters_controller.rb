class ChaptersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only, :except => [:index, :edit]
  before_filter :chapter_leader?, :except => [:index, :new, :show]
  
  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = current_user.chapters

    respond_to do |format|
      format.html # index.html.erb
      format.csv { send_data Chapter.to_csv(@chapters) }

      format.json { render json: @chapters }
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter }
    end
  end

  # GET /chapters/1/edit
  def edit
    @chapter = Chapter.find(params[:id])
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
    Chapter.import(params[:file]) 
    redirect_to root_url, notice: "Chapters imported."
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

end