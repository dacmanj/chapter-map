class HomeController < ApplicationController
    skip_authorization_check
    
    def index
    if !params[:state].blank?
      @chapters = Chapter.active.where(:state => params[:state]).order("name ASC")
    elsif !params[:latitude].blank? and !params[:longitude].blank?
      distance = params[:distance] unless params[:distance].blank? || params[:distance].to_f == 0 
      @chapters = Chapter.active.near([params[:latitude],params[:longitude]], distance || 100)
    elsif !params[:zip].blank?
      if !!(params[:zip] =~ /^[-+]?[0-9]+$/) and params[:zip].length == 5
        zip = params[:zip] + ", USA"
      else
        zip = params[:zip]
      end
      distance = params[:distance] unless params[:distance].blank? || params[:distance].to_f == 0 
      @chapters = Chapter.active.near(zip, distance || 100)
    else
      @chapters = Chapter.active.order("state ASC, name ASC").all
      @chapters_by_state = @chapters.group_by { |t| t.state }
    end
    @hash = Gmaps4rails.build_markers(@chapters) do |chapter, marker|
      marker.lat chapter.latitude
      marker.lng chapter.longitude
      marker.title   "#{chapter.name}"
      marker.infowindow render_to_string(:partial => "/chapters/infowindow",  :formats => [:html], :locals => { :chapter => chapter})
      marker.picture(chapter.gmaps_marker_params);
    end
  end

  def show_chapters
    if !params[:state].blank?
      @chapters = Chapter.active.where(:state => params[:state]).order("name ASC")
    elsif !params[:latitude].blank? and !params[:longitude].blank?
      distance = params[:distance] unless params[:distance].blank? || params[:distance].to_f == 0 
      @chapters = Chapter.active.near([params[:latitude],params[:longitude]], distance || 100)
    elsif !params[:zip].blank?
      if !!(params[:zip] =~ /^[-+]?[0-9]+$/) and params[:zip].length == 5
        zip = params[:zip] + ", USA"
      else
        zip = params[:zip]
      end
      distance = params[:distance] unless params[:distance].blank? || params[:distance].to_f == 0 
      @chapters = Chapter.active.near(zip, distance || 100)
    else
      @chapters = Chapter.active.order("state ASC, name ASC").all
      @chapters_by_state = @chapters.group_by { |t| t.state }
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def embed
    index #call index
    respond_to do |format|
      format.html { render 'index', :layout => 'embed' }
      format.json { render json: @hash }
    end   
  end

  def full
    index #call index
    respond_to do |format|
      format.html { render 'index', :layout => 'full' }
      format.json { render json: @hash }
    end   
  end  
  def pflag
    index #call index
    respond_to do |format|
      format.html { render 'index', :layout => 'pflag' }
      format.json { render json: @hash }
    end    
  end
end
