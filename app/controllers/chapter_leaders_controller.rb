class ChapterLeadersController < ApplicationController
  load_and_authorize_resource
  # GET /chapter_leaders
  # GET /chapter_leaders.json
  def index
    @chapter_leaders = ChapterLeader.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chapter_leaders }
    end
  end

  # GET /chapter_leaders/1
  # GET /chapter_leaders/1.json
  def show
    @chapter_leader = ChapterLeader.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chapter_leader }
    end
  end

  # GET /chapter_leaders/new
  # GET /chapter_leaders/new.json
  def new
    @chapter_leader = ChapterLeader.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chapter_leader }
    end
  end

  # GET /chapter_leaders/1/edit
  def edit
    @chapter_leader = ChapterLeader.find(params[:id])
  end

  # POST /chapter_leaders
  # POST /chapter_leaders.json
  def create
    @chapter_leader = ChapterLeader.new(params[:chapter_leader])

    respond_to do |format|
      if @chapter_leader.save
        format.html { redirect_to @chapter_leader, notice: 'Chapter leader was successfully created.' }
        format.json { render json: @chapter_leader, status: :created, location: @chapter_leader }
      else
        format.html { render action: "new" }
        format.json { render json: @chapter_leader.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chapter_leaders/1
  # PUT /chapter_leaders/1.json
  def update
    @chapter_leader = ChapterLeader.find(params[:id])

    respond_to do |format|
      if @chapter_leader.update_attributes(params[:chapter_leader])
        format.html { redirect_to @chapter_leader, notice: 'Chapter leader was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chapter_leader.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapter_leaders/1
  # DELETE /chapter_leaders/1.json
  def destroy
    @chapter_leader = ChapterLeader.find(params[:id])
    @chapter_leader.destroy

    respond_to do |format|
      format.html { redirect_to chapter_leaders_url }
      format.json { head :no_content }
    end
  end
end
