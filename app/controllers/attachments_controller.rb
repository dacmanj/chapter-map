class AttachmentsController < ApplicationController
  load_and_authorize_resource

  # GET /attachments
  # GET /attachments.json
  def index
    #load chapter for dropdown attachment selector
    @chapters =  Chapter.accessible_by(current_ability).active.order(:name)
    @attachments = @attachments.where(chapter_id: params[:chapter_id]) if params[:chapter_id].present?
    @attachments = @attachments.paginate(:page => params[:page]) unless params[:format] == "json"

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
  end

  # POST /attachments
  # POST /attachments.json
  def create
    respond_to do |format|
      if @attachment.save
        format.html {
          render :json => [@attachment.to_jq].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        flash[:notice] = "File uploaded successfully."
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
    respond_to do |format|
      if @attachment.rename(params[:attachment][:name]) || @attachment.update_attributes(attachment_params)
        format.html { redirect_to attachments_url, notice: 'File was successfully updated.' }
          flash[:notice] = 'File was successfully updated'
          format.json { render json: @attachment.to_json(:methods => :url) }
      else
        format.html { render action: "edit" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /ssets/1.json
  def destroy
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachments_url }
      flash[:notice] = 'File was successfully deleted'
      format.json { render json: flash }
    end
  end

  private
  def attachment_params
    params.require(:attachment).permit(:attachment, :tag, :chapter_id, :user_id)
  end
end
