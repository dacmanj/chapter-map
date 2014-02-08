class AttachmentsController < ApplicationController
  load_and_authorize_resource

  # GET /attachments
  # GET /attachments.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attachments.map{|attachment| attachment.to_jq } }
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.json
  def new
    @attachment = Attachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
  end

  # POST /attachments
  # POST /attachments.json
  def create
    @attachment = Attachment.new(params[:attachment])

    respond_to do |format|
      if @attachment.save
        format.html {
          render :json => [@attachment.to_jq].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@attachment.to_jq]}, status: :created, location: @attachment }
      else
        format.html { render action: "new" }
        flash[:error] = @attachment.errors.full_messages.to_sentence
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1
  # PUT /attachments/1.json
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        format.html { redirect_to attachments_url, notice: 'Attachment was successfully updated.' }
        format.json { render json: {files: [@attachment.to_jq]}, status: :created, location: @attachment  }
      else
        format.html { render action: "edit" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /ssets/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.json { head :no_content }
    end
  end
end
