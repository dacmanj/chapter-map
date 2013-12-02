class HomeController < ApplicationController
  def index
    if !params[:state].blank?
      @chapters = Chapter.where(:state => params[:state]).order("name ASC")
    elsif !params[:zip].blank?
      distance = params[:distance] unless params[:distance].blank? || params[:distance].to_f == 0 
      @chapters = Chapter.active.near(params[:zip], distance || 100)
    else
      @chapters = Chapter.active.order("state ASC, name ASC").all
      @chapters_by_state = @chapters.group_by { |t| t.state }
    end
    @hash = Gmaps4rails.build_markers(@chapters) do |chapter, marker|
      marker.lat chapter.latitude
      marker.lng chapter.longitude
      marker.title   "#{chapter.name}"
      marker.infowindow render_to_string(:partial => "/chapters/infowindow",  :formats => [:html], :locals => { :chapter => chapter})
      case chapter.category
#        when "Chapter"
#          marker.picture({
#                    :url => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/red-dot.png",
#                    :width   => 32,
#                    :height  => 32
#                   });
        when "Representative"
          marker.picture({
                    :url => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/purple-dot.png",
                    :width   => 32,
                    :height  => 32
                   });
        end
      end
  end

  def show_chapters
    if !params[:state].blank?
      @chapters = Chapter.active.where(:state => params[:state]).order("name ASC")
    elsif !params[:zip].blank?
      distance = params[:distance] unless params[:distance].blank? || params[:distance].to_f == 0 
      @chapters = Chapter.active.near(params[:zip], distance || 100)
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
      format.html { render 'index', :layout => 'pflag' }
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
